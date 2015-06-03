require "socket"

DownloadManager=class("DownloadManager")

function DownloadManager.ctor()
    DownloadManager.threads = {}
end

function DownloadManager.receive(connection)
    connection:settimeout(0)  -- do not block
    local s, status, partial = connection:receive(2^10) --10M
    if status == "timeout" then
        coroutine.yield(connection)
    end
    return s or partial, status
end

function DownloadManager.download(url)
    local host,port,path,file=parseUrl(url)
    local c = assert(socket.connect(host, port))
    c:send("GET " .. path .. " HTTP/1.0\r\n\r\n")
    print("save to:",device.writablePath..file)
    
    local content = ""
    while true do
        local s, status, partial = DownloadManager.receive(c)
        content=content..(s or partial)
        if status == "closed" then
            break
        end
    end

    if string.find(content,"\r\n\r\n") then  
        content = string.split(content,"\r\n\r\n")[2]
    end

    io.writefile(device.writablePath..file,content)
    c:close()
    --升级时解开zip文件
    if string.find(file,"%.zip$") then
        ZipManager.extract(file)
    end
end

function DownloadManager:get(url,code)
    local _,_,_,file=parseUrl(url)
    local path=string.format("%s%s",device.writablePath,file or "")
    code=string.lower(code or "")
    if not io.exists(path) or (io.exists(path) and code~=md5.filecode(path)) then
        -- create coroutine
        local co = coroutine.create(function ()
            DownloadManager.download(url)
        end)
        -- intert it in the list
        table.insert(self.threads, co)
    end

end

function DownloadManager:dispatch()
    local i = 1
    while true do
        if self.threads[i] == nil then  -- no more threads?
            if self.threads[1] == nil then -- list is empty?
                break
            end
            i = 1  -- restart the loop
        end
        local status, res = coroutine.resume(self.threads[i])
        if not res then   -- thread finished its task?
            table.remove(self.threads, i)
        else
            i = i + 1
        end
    end

    return i
end

function parseUrl(url)
    local host,port,path=string.match(url,"([^/]*%.%w+):?(%d*)(/.+)")
    if port == "" then port =  80 end
    local file=string.match(path, ".+/([^/]*%.%w+)$")
    return host,port,path,file
end