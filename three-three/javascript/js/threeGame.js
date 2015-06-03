var three={
	walkState : false,		//是否走棋状态
  	canClickBlank : true,		//是否可以点击棋格
  	role : 0,			//走棋一方代号[0:A,1:B]
  	moveChess : null,  		//准备移动的棋子  
  	type : 0,
  	player : [],
  	//获取当前游戏棋盘状态
  	currentGrids : function(){
  		var grids=[];
  		for(var i=0;i<24;i++){
  			grids.push(this.typeOfChess($("#chess_"+i+">img")));
  		}
  		return grids;
  	},
  	//刷新游戏棋盘状态
  	reload : function(grids,walkState){
  		for(var i=0;i<grids.length;i++){
  			three.showChess($("#chess_"+i),grids[i]);
  		}
  		three.walkState=walkState;
  	},
  	//重置游戏棋盘状态
  	resetGrid : function(){
	  	var grids=[];
  		for(var i=0;i<24;i++){
  			grids.push(-1);
  		}
  		return grids;
  	},
  
  	//棋子类型
  	typeOfChess : function(c){
		for(var i=0;i<c.length;i++){
			if(c[i].style.display!="none"){
				if($(c).parent().hasClass("rim")) return 4;
				else return i;
			}
		}
		return -1;
  	},
  	//根据棋子类型查询棋盘上的棋子
  	queryChess : function(type){
		var cs=[];
		for(var i=0;i<24;i++){
			var chs=$("#chess_"+i+">img");
			for(var j=0;j<chs.length;j++){
				if(type==j && chs[j].style.display!="none"){
					cs.push($("#chess_"+i));
				}
			}
		}
		return cs;
  	}, 
	//判断是否走子状态  
  	isWalkState : function (){
		for(var i=0;i<24;i++){
			var c=$("#chess_"+i+">img");
			if(three.typeOfChess(c)==-1) return false;
		}
		return true;
	},
	
	isPeace : function(){
		if(three.isWalkState()){
			var temp=0;
			for(var i=0;i<24;i++){
				var c=$("#chess_"+i+">img");
				if(three.typeOfChess(c)==2 || three.typeOfChess(c)==3){
					return false;
				}
			}
			return true;
		}
		return false;
	},
   	//判断是否三个棋子连成一线
 	isThreeLine : function (chess){
		var res=false;
		var cs=this.lineChesses(chess);
		var n=this.typeOfChess($(chess).children("img"));
		for(var i=0;i<cs.length;i++){
			for(var j=0;j<cs[i].length;j++){
				var cn=this.typeOfChess($("#chess_"+cs[i][j]+">img"));
				if(cn!=n) { //当一条线上有一个棋不同时返回false
					res=false;
					break;
				}
				res=true;
			}
			if(res) return true;
		}
		return res;
  	},
 
  	//显示可以压的棋子
	showCoverable : function (){
		var type=(this.role==1?0:1);
		this.updateChessType(4,type);
		this.role=(this.role==0?1:0); //提示时,把role赋回原值
		client.initPlayer(); //保持红手提示状态一致
		this.canClickBlank=false;
  	},
  	//复原提示棋子
	recoverTipChess : function (){
		$(".rim").removeClass("rim");
		this.role=(this.role==0?1:0); //复原提示时,把role赋回原值
  	},
  	//更新棋子类型
  	updateChessType :function (ch,type){
		if(type<0 && type>1 || type==undefined) type=4;
		var cs=this.queryChess(type);
		for(var i=0;i<cs.length;i++){
			this.showChess(cs[i],ch,true);
		}
  	},
  	//取得棋子横坐标
  	chessLeft:function (w,l){
		switch(l){
			case 0:
			case 6:
			case 7:
				return 0+w*100;
			case 1:
			case 5:
				return 300;
			case 2:
			case 3:
			case 4:
				return 600-w*100;
			default :
				return -1;	
		}
  	},
  	//取得棋子纵坐标
  	chessTop:function (w,l){
		switch(l){
			case 0:
			case 1:
			case 2:
				return 0+w*100;
			case 3:
			case 7:
				return 300;
			case 4:
			case 5:
			case 6:
				return 600-w*100;
			default :
				return -1;	
		}
  	},
  	//取得棋子编号
  	chessId : function (c){
		return ($(c).attr("id")+"").replace(/[^\d]/g,'')/1
  	},
  	//取得三棋一线的棋子数组
  	lineChesses : function (chess){
		var cs=[];
		var sla=[];
		var slb=[];
		var sw=[];
		var cn=this.chessId(chess);
		var w=Math.floor(cn/8); //小于等于 x，且与 x 最接近的整数。
		var l=cn%8;
		if(l%2==0) {
			if (l==6){
				sla.push(cn-6);
				sla.push(cn+1);
			}else{
				sla.push(cn+1);
				sla.push(cn+2);
			}
			if(l==0){
				slb.push(cn+6);
				slb.push(cn+7);
			}else{
				slb.push(cn-1);
				slb.push(cn-2);
			}	
		}else if (l==7){
			sla.push(cn-1);
			sla.push(cn-7);
		}else{
			sla.push(cn-1);
			sla.push(cn+1);
		}
		if(w==0){
			sw.push(cn+8);
			sw.push(cn+16);
		}else if (w==1){
			sw.push(cn-8);
			sw.push(cn+8);
		}else{
			sw.push(cn-8);
			sw.push(cn-16);
		}
		cs.push(sla);
		cs.push(sw);
		if(slb.length>0) cs.push(slb);
		return cs;
  	},
  	//取得相邻棋子
  	siblingChesses : function (chess){
		var cs=[];
		var cn=this.chessId(chess);
		var w=Math.floor(cn/8); 
		var l=cn%8;
		l==0?cs.push(cn+7):cs.push(cn-1);
		l==7?cs.push(cn-7):cs.push(cn+1);
		if(w==0){
			cs.push(cn+8);
		}else if(w==2){
			cs.push(cn-8)
		}else{
			cs.push(cn-8);
			cs.push(cn+8);
		}
		return cs;
  	},
  	//放大棋子
  	zoom : function (c,size){
		$(c).width(size).height(size);
		$(c).children("img").width(size).height(size);
  	},
  	//处理走棋
  	handleMove : function (chess){
		if(this.canMove(chess)){		
  			var id=this.chessId(chess);
			//向服务器发送棋子状态,bType:广播的type
			client.lWSC.broadcastGamingEvent( { mId: id});
		}
  	},
  	//准备移动
  	prepareMove : function(id){
  		this.zoom($("#disk>div"),50);
	  	this.zoom($("#chess_"+id),60);
  		this.moveChess=$("#chess_"+id);
		this.canClickBlank=true;	  
  	},
  	//可否走动
  	canMove:function (chess){
		var sib=this.siblingChesses(chess);
		for(var j=0;j<sib.length;j++){
			if(this.typeOfChess($("#chess_"+sib[j]+">img"))==-1)return true;
		}
		return false;
  	},
  	//是否可移动的棋格
  	isMoveGrid:function (chess){
		if(this.canClickBlank && this.canMove(this.moveChess)){
			var sib=this.siblingChesses(this.moveChess);
			for(var j=0;j<sib.length;j++){
				if(sib[j]==this.chessId(chess)) return true;
			}
		}
		return false;
  	},
	//检查游戏状态,查询对方棋子相邻有无空格,无空格则赢棋.
	checkGameState:function (){
		var type=(three.role==1?0:1);
		var cs=three.queryChess(type);
		if(cs.length>2){
			for(var i=0;i<cs.length;i++){
				var sib=three.siblingChesses(cs[i]);
				for(var j=0;j<sib.length;j++){
					if(three.typeOfChess($("#chess_"+sib[j]+">img"))==-1)return;
				}
			}
		}
		three.endGame();
	},
	
	endGame : function(method,giveuper){
		var msg;
		if("giveup"==method){
			var player=$("#client").text();
			if(player==giveuper){
				msg="你输了。";
			}else{
				msg="恭喜，你赢了。";
			}
		}else if("peace"==method){
			msg="玩成平局了.";
		}else{
			if(client.serverRole()==0){
				if(three.role==1){
					msg="恭喜，你赢了。";
				}else{
					msg="你输了。";
				}
			}else{
				if(three.role==1){
					msg="你输了。";
				}else{
					msg="恭喜，你赢了。";
				}
			}
		}
		if(confirm(msg+"还玩一局吗?")){
			var game=three.resetGrid();
			client.lWSC.broadcastGamingEvent({game : game,walkState:false});	
		}
		else{
			client.exitPage();
			window.opener = null;
			window.close();
		}
	},
	//认输
  	giveup : function(){
  		if(three.walkState){
  			if(confirm("确定要认输吗?")){
  				var loser=$("#client").text();
  				client.lWSC.broadcastGamingEvent({endMethod : "giveup" ,giveuper: loser});
  			}
  		}else{
  			alert("刚开始玩,不允许认输.");
  		}  	
  	},
	//把覆盖的棋移走
  	removeCoverChess : function(){
  		if(this.isWalkState()){ //棋盘棋满
			this.updateChessType(-1,2); 
			this.updateChessType(-1,3);
			this.checkGameState();
			this.role=(this.role==0?1:0); //移棋后,把role走棋先后顺序对调
			client.showTurn();
			this.walkState=true;
		}
  	},
  	//显示棋格点上的棋子
  	showChess : function(c,s,cr){
  		if(s==4){
			$(c).addClass("rim");
		}else{
			$(c).children("img").each(function(i,o){
				$(o).hide();
				if(i==s){
					$(o).show();
					three.zoom($("#disk>div"),50);
					three.zoom(o,60);
					if(!cr && s==1 || s==0){
						three.role=s;
						client.showTurn();//提示应该轮到谁走了
					}
					if(s==2 || s==3){
						three.role=(three.role==0?1:0); //移棋后,把role走棋先后顺序对调
						client.showTurn();
						three.role=(three.role==0?1:0); //移棋后,把role走棋先后顺序对调
					}
				}
			});
		}
  	},
  	//向服务器发送走棋动作
  	goChess : function (c,s,cr){
  		var id=this.chessId(c);
		//向服务器发送棋子状态,bType:广播的type
		if(client.lWSC)
			client.lWSC.broadcastGamingEvent( { id: id, cType: s,rim: cr||false,bType : this.type});
  	}, 
  
   //下棋动作
  	move : function (c,s,cr,bt){
  		c="#chess_"+c;
  		this.type=bt;
		this.showChess(c,s,cr);
		this.afterMove($(c),s);
	},
	//收到服务器广播后,更新对方的走棋动作
	afterMove : function(c,s){
		var type=this.type;
		if(this.walkState){ //走棋模式
			if(type==-1){ //棋子着落点
				three.zoom($("#disk>div"),50);
				this.zoom(c,60); //提示着落点
				this.showChess(this.moveChess,-1); //清空走前的落点
				if(this.isThreeLine(c)){
					this.showCoverable();
				}						
			}
					
			if(type==4){
				this.recoverTipChess();
				this.checkGameState();
			}
		}else{ //下棋布局模式
			if(type>=0 && type<4) return;
			if(type==-1 && this.canClickBlank){ //点空棋
				if(this.isThreeLine(c)){
					this.showCoverable(); //提示哪些棋可以被压
					return;
				}
			}
			if(type==4){ //点提示棋
				this.recoverTipChess(); //提示棋失效,还原为原棋
				this.canClickBlank=true;
			}
			//和局
			if(three.isPeace()){
				client.lWSC.broadcastGamingEvent( { endMethod: "peace"});
			}
			this.removeCoverChess();
		}
		
	},
	//初始化棋盘   
 	init: function (){
		var chessCounter=0;
		for(var w=0;w<3;w++){
			for(var l=0;l<8;l++){
				var chessA=new Image();
				$(chessA).attr("src","images/chess_A"+client.suffix()).hide();
				var chessB=new Image();			
				$(chessB).attr("src","images/chess_B"+client.suffix()).hide();
				var chessAB=new Image();
				$(chessAB).attr("src","images/chess_A_B"+client.suffix()).hide(); 
				var chessBA=new Image();
				$(chessBA).attr("src","images/chess_B_A"+client.suffix()).hide();			
			
				var div = document.createElement('DIV');
				$(div).attr("id","chess_"+chessCounter)	
				.css("left",this.chessLeft(w,l))
				.css("top",this.chessTop(w,l))
				.addClass("chess")
				.append(chessA)
				.append(chessB)
				.append(chessAB)
				.append(chessBA)
				.bind("click",function(){
					if(three.role==client.serverRole()){ //当session.role=0时可以点击
						var type=three.type=three.typeOfChess($(this).children("img"));
						if(three.walkState){ //走棋模式
							if(type==1 && three.role==0){ //黑方走棋
								three.handleMove(this);
							} 
						
							if(type==0 && three.role==1){ //红方走棋
								three.handleMove(this);
							}
					
							if(type==-1 && three.isMoveGrid(this)){ //棋子着落点
								three.role==1?three.goChess(this,0):three.goChess(this,1);													
							}
					
							if(type==4){
								three.goChess(this,-1);
							}
						}else{ //下棋布局模式
							if(type>=0 && type<4) return;
							if(type==-1 && three.canClickBlank){ //点空棋
								three.role==1?three.goChess(this,0):three.goChess(this,1); //轮流下棋
							}
							if(type==4){ //点提示棋
								three.role==0?three.goChess(this,3):three.goChess(this,2);
							}
						}
					}
				});
			
				$("#disk").append(div);
				chessCounter++;
			}
		}
  	}

} 