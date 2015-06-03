
local FiveChessBase = class("FiveChessBase")

FiveChessBase.NO_CHESS = 0     --无棋子
FiveChessBase.BLACK_CHESS = -1 --黑棋子（玩家）
FiveChessBase.WHITE_CHESS = 1  --白棋子（机器人）

function FiveChessBase:ctor()
end

return FiveChessBase