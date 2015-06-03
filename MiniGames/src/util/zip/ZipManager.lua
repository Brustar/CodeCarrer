require('zip')

module("ZipManager",package.seeall)

function extract(f)
	local zfile, err = zip.open(f)   
    assert(zfile, err)

    for file in zfile:files() do
    	local d, err = zfile:open(file.filename)
    	assert(d, err)
    	local _,i = string.find(file.filename,'%w+(/)$')
   
    	if i then
    		ZipManager.mkdir(file.filename)
    		d:close()
        else
			ZipManager.copyfile(d,device.writablePath..file.filename)
    	end
    end

end

function copyfile(sourcefile,destination)
	destinationfile = io.open(destination,"wb")
	for line in sourcefile:lines() do
		destinationfile:write(line)
	end
	sourcefile:close()
	destinationfile:close()
end

function mkdir(dir)
	if dir then
		local target=device.writablePath..dir
		if device.platform == "windows" then
			target = string.gsub(target,"/","\\")
		end
		print("mkdir "..target)
		os.execute("mkdir "..target)
	end
end