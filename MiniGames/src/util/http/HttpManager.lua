-- http网络请求
local http = require("http")

module("HttpManager",package.seeall)

function get(url)
	local res, code = http.request(url)
	if code==200 then 
		return res	
	else
		return "bad request"
	end
end


function post(url,post_data)
	if not connected() then
		return false
	end
	post_data=post_data or ""
	post_data=string.format("pbBase=%s&pbData=%s",native.pb(),util.des(post_data))
	local res, code = http.request(url,post_data)
	if code==200 then 
		return true,res	
	else
		return false,"bad request"
	end
end


function download(url,code)
	local manager=DownloadManager.new()
	manager:get(url,code)
	manager:dispatch()
end


function downloads(urls)
	local manager=DownloadManager.new()
	for _,v in ipairs(urls) do
		manager:get(v.url,v.code)
	end
	return manager:dispatch()
end

function downIcon(url)
	local png=get(url)
	local _,_,_,file=parseUrl(url)
	if file then
		io.writefile(device.writablePath..file, png)
	end
end


function connected()
	if not native.networkReachable() then
		if cc.Director:getInstance():getRunningScene() then
			DialogBox.run(cc.Director:getInstance():getRunningScene(),"连接失败，请检查你的网络设置。")
		end
		return false
	end
	return true
end