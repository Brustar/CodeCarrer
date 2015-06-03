
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = false

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = false

-- for module display
CC_DESIGN_RESOLUTION = {
    width = 640,
    height = 960,
    autoscale = "FIXED_WIDTH",
    callback = function(framesize)
        local ratio = framesize.height / framesize.width
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
            return {autoscale = "FIXED_HEIGHT"}
        end
    end
}

APP_VERSION={
    [1]={name="FoundWord",version=1.0},
    [2]={name="Maze",version=1.0},
    [3]={name="CrazyCat",version=1.0},
    [4]={name="BrushThrough",version=1.0},
    [6]={name="FlyMore",version=1.0},
    [5]={name="Bubble",version=1.0},
    [8]={name="Warrior",version=1.0},
    [7]={name="SuperDye",version=1.0},
    [9]={name="ChineseBlock",version=1.0},
    [10]={name="FiveChess",version=1.0},
    [11]={name="VirtualFutures",version=1.0},
    [12]={name="BigWord",version=1.0},

    [100]={name="MiniGames",version=1.0}
}

TCP_IP="192.168.1.222"
TCP_PORT=9300

DES_KEY="$LxLUaGm"
SOFT_ID=898