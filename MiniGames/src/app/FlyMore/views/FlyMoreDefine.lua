--region NewFile_1.lua
--Author : Administrator
--Date   : 2015/5/21
--此文件由[BabeLua]插件自动生成
local FlyMoreDefine = class("FlyMoreDefine", cc.load("mvc").ViewBase)

local Timer   = import("..models.Timer")
local Player   = import("..models.Player")
local Cloud   = import("..models.Cloud")
local ComboTrigger   = import("..models.ComboTrigger")

local TimerSprite = import(".TimerSprite")
local PlayerSprite = import(".PlayerSprite")
local CloudSprite = import(".CloudSprite")
local ComboTriggerSprite   = import(".ComboTriggerSprite")
local HeightTipSprite = import(".HeightTipSprite")

FlyMoreDefine.events = {
    GAME_OVER_EVENT = "GAME_OVER_EVENT",
    TIME_OVER_EVENT="TIME_OVER_EVENT",
}

FlyMoreDefine.ZORDER_COMBO_TRIGGER = 100
FlyMoreDefine.ZORDER_HEIGHT_TIP = 50
FlyMoreDefine.ZORDER_TIMER = 100
FlyMoreDefine.ZORDER_CLIPPING = 0
FlyMoreDefine.ZORDER_ZONE = 50
FlyMoreDefine.ZORDER_SKY = 0
FlyMoreDefine.ZORDER_PLAYER = 100
FlyMoreDefine.ZORDER_CLOUD = 50
FlyMoreDefine.ZORDER_TREE = 0

FlyMoreDefine.WIDTH = display.width
FlyMoreDefine.HEIGHT =display.height

FlyMoreDefine.CLIPPING_WIDTH = display.width
FlyMoreDefine.CLIPPING_HEIGHT = display.height 

FlyMoreDefine.CLOUD_HORIZONTAL_NUM = 6

FlyMoreDefine.CLOUD_COLOR_HEIGHT_1 = 1200
FlyMoreDefine.CLOUD_COLOR_HEIGHT_2 = 2400
FlyMoreDefine.CLOUD_COLOR_HEIGHT_3 = 3600

FlyMoreDefine.CLOUD_NUM_RATE_1 = 70
FlyMoreDefine.CLOUD_NUM_RATE_2 = 95
FlyMoreDefine.CLOUD_NUM_RATE_3 = 100

FlyMoreDefine.ADD_WIDTH = 60

function FlyMoreDefine:ctor()
 
end

--保存高度
function FlyMoreDefine:showResultMenu(view)
    view.endTime = os.date("%Y-%m-%d %H:%M:%S")
    local height = 0
    height = view:getGameHeight()
    view.newHeight=height
    if height > view.hisGameHeight_ then
        view.hisGameHeight_ = height
    end     
end

--发送结算数据
function FlyMoreDefine:submitResult(view)
    local FlyMoreEnd = GamePB_pb.PBFlyjumpGamelog_Update_Params()
    print("**********",view.startTime)
    FlyMoreEnd.starttime = view.startTime
    FlyMoreEnd.endtime = view.endTime
    FlyMoreEnd.height = view.hisGameHeight_
    view.costtime = view.timer_:getModel().INIT_SECONDS - view.timer_:getModel():getLeftSeconds()
    FlyMoreEnd.costtime =view.costtime
    print(view.hisGameHeight_)
    print(view.costtime)
    local flag,endReturn = HttpManager.post("http://lxgame.lexun.com/interface/flyjump/updategamelog.aspx",FlyMoreEnd:SerializeToString())
    if not flag then return end
    local obj=ServerBasePB_pb.PBMessage()
    obj:ParseFromString(endReturn)
    print(obj.outmsg)
end
 
return FlyMoreDefine


--endregion
