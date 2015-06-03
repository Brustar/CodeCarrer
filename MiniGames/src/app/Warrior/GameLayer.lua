

local GameLayer = class("GameLayer")
--local maps= JsonManager.decode(WARRIOR_MAP)

 GameLayer.VERIFY_MAP = {
                    [3]={
                            up={5,6,12},
                            right={9,10,12}
                        },
                    [5]={
                            up={5,6,12},
                            down={3,5,9}
                        },
                    [6]={
                            right={9,10,12},
                            down={3,5,9}
                        },
                    [9]={
                            up={5,6,12},
                            left={3,10,6}
                        },
                    [10]={
                            left={3,10,6},
                            right={9,10,12}
                        },
                    [12]={
                            left={3,10,6},
                            down={3,5,9}
                        }
                    }


return GameLayer