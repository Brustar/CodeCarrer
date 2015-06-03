LoadingLayer = class("LoadingLayer")

function LoadingLayer.infoLoading(index)
	local CSB
	if index == 1 then --找字的loading
		CSB = cc.CSLoader:createNode("FoundWord/loading.csb") 
	elseif index == 10 then --五子棋的loading
		CSB = cc.CSLoader:createNode("FiveChess/loading.csb") 
	end
	--适配美术资源
	CSB:setContentSize(display.size)
    ccui.Helper:doLayout(CSB)
    return CSB
end
