local BubbleSprite = class("BubbleSprite")
BubbleSprite.bubbleType = {
	{ATYPE = "dots_red_%d.png",INDEX = 1,NORMAL=true}, --非选中状态下红色
	{ATYPE = "dots_orig_%d.png",INDEX = 2,NORMAL=true},	--非选中状态下橙色
	{ATYPE = "dots_yellow_%d.png",INDEX = 3,NORMAL=true},--非选中状态下黄色
	{ATYPE = "dots_green_%d.png",INDEX = 4,NORMAL=true}, --非选中状态下绿色
	{ATYPE = "dots_blue_%d.png",INDEX = 5,NORMAL=true}, --非选中状态下蓝色
	{ATYPE = "dots_pink_%d.png",INDEX =6,NORMAL=true},--非选中状态下紫色
	{ATYPE = "dots_f_red_%d.png",INDEX =7,NORMAL=true},--选中状态下红色
	{ATYPE = "dots_f_orig_%d.png",INDEX =8,NORMAL=true},--选中状态下橙色
	{ATYPE = "dots_f_yellow_%d.png",INDEX =9,NORMAL=true},--选中状态下黄色
	{ATYPE = "dots_f_green_%d.png",INDEX =10,NORMAL=true},--选中下绿色
	{ATYPE = "dots_f_blue_%d.png",INDEX=11,NORMAL=true},--选中下蓝色
	{ATYPE = "dots_f_pink_%d.png",INDEX=12,NORMAL=true}--选中下紫色
}

BubbleSprite.specialBubble = {
	{ATYPE = "dots_caise%d.png",INDEX=1,NORMAL=false},--非选中状态下彩色球
	{ATYPE = "dots_h_bom%d.png",INDEX=2,NORMAL=false},--非选中状态下横向炸弹
	{ATYPE = "dots_z_bom%d.png",INDEX=3,NORMAL=false},--非选中状态下竖向炸弹
	{ATYPE = "dots_s_bom%d.png",INDEX=4,NORMAL=false},--非选中状态下双向炸弹
	{ATYPE = "dots_2_time%d.png",INDEX=5,NORMAL=false},--非选中状态下X2球
	{ATYPE = "dots_5_time%d.png",INDEX=6,NORMAL=false},--非选中状态下+5球
    {ATYPE = "dots_gold%d.png",INDEX=7,NORMAL=false},--非选中状态下的金礼包
    {ATYPE = "dots_silver%d.png",INDEX=8,NORMAL=false},--非选中状态下的银礼包
    {ATYPE = "dots_copper%d.png",INDEX=9,NORMAL=false},--非选中状态下的铜礼包
	{ATYPE = "dots_caise_%d.png",INDEX=10,NORMAL=false},--选中状态下彩色球
	{ATYPE = "dots_h_bom_%d.png",INDEX=11,NORMAL=false},--选中状态下横向炸弹
	{ATYPE = "dots_z_bom_%d.png",INDEX=12,NORMAL=false},--选中状态下竖向炸弹
	{ATYPE = "dots_s_bom_%d.png",INDEX=12,NORMAL=false},--选中状态下双向炸弹
	{ATYPE = "dots_2_time_%d.png",INDEX=14,NORMAL=false},--选中状态下x2球
	{ATYPE = "dots_5_time_%d.png",INDEX=15,NORMAL=false},--选中状态+5球
    {ATYPE = "dots_gold_%d.png",INDEX=16,NORMAL=false},--选中状态下的金礼包
    {ATYPE = "dots_silver_%d.png",INDEX=17,NORMAL=false},--选中状态下的银礼包
    {ATYPE = "dots_copper_%d.png",INDEX=18,NORMAL=false},--选中状态下的铜礼包
}
return BubbleSprite