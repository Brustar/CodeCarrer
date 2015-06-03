var three={
	walkState : false,		//�Ƿ�����״̬
  	canClickBlank : true,		//�Ƿ���Ե�����
  	role : 0,			//����һ������[0:A,1:B]
  	moveChess : null,  		//׼���ƶ�������  
  	type : 0,
  	player : [],
  	//��ȡ��ǰ��Ϸ����״̬
  	currentGrids : function(){
  		var grids=[];
  		for(var i=0;i<24;i++){
  			grids.push(this.typeOfChess($("#chess_"+i+">img")));
  		}
  		return grids;
  	},
  	//ˢ����Ϸ����״̬
  	reload : function(grids,walkState){
  		for(var i=0;i<grids.length;i++){
  			three.showChess($("#chess_"+i),grids[i]);
  		}
  		three.walkState=walkState;
  	},
  	//������Ϸ����״̬
  	resetGrid : function(){
	  	var grids=[];
  		for(var i=0;i<24;i++){
  			grids.push(-1);
  		}
  		return grids;
  	},
  
  	//��������
  	typeOfChess : function(c){
		for(var i=0;i<c.length;i++){
			if(c[i].style.display!="none"){
				if($(c).parent().hasClass("rim")) return 4;
				else return i;
			}
		}
		return -1;
  	},
  	//�����������Ͳ�ѯ�����ϵ�����
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
	//�ж��Ƿ�����״̬  
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
   	//�ж��Ƿ�������������һ��
 	isThreeLine : function (chess){
		var res=false;
		var cs=this.lineChesses(chess);
		var n=this.typeOfChess($(chess).children("img"));
		for(var i=0;i<cs.length;i++){
			for(var j=0;j<cs[i].length;j++){
				var cn=this.typeOfChess($("#chess_"+cs[i][j]+">img"));
				if(cn!=n) { //��һ��������һ���岻ͬʱ����false
					res=false;
					break;
				}
				res=true;
			}
			if(res) return true;
		}
		return res;
  	},
 
  	//��ʾ����ѹ������
	showCoverable : function (){
		var type=(this.role==1?0:1);
		this.updateChessType(4,type);
		this.role=(this.role==0?1:0); //��ʾʱ,��role����ԭֵ
		client.initPlayer(); //���ֺ�����ʾ״̬һ��
		this.canClickBlank=false;
  	},
  	//��ԭ��ʾ����
	recoverTipChess : function (){
		$(".rim").removeClass("rim");
		this.role=(this.role==0?1:0); //��ԭ��ʾʱ,��role����ԭֵ
  	},
  	//������������
  	updateChessType :function (ch,type){
		if(type<0 && type>1 || type==undefined) type=4;
		var cs=this.queryChess(type);
		for(var i=0;i<cs.length;i++){
			this.showChess(cs[i],ch,true);
		}
  	},
  	//ȡ�����Ӻ�����
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
  	//ȡ������������
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
  	//ȡ�����ӱ��
  	chessId : function (c){
		return ($(c).attr("id")+"").replace(/[^\d]/g,'')/1
  	},
  	//ȡ������һ�ߵ���������
  	lineChesses : function (chess){
		var cs=[];
		var sla=[];
		var slb=[];
		var sw=[];
		var cn=this.chessId(chess);
		var w=Math.floor(cn/8); //С�ڵ��� x������ x ��ӽ���������
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
  	//ȡ����������
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
  	//�Ŵ�����
  	zoom : function (c,size){
		$(c).width(size).height(size);
		$(c).children("img").width(size).height(size);
  	},
  	//��������
  	handleMove : function (chess){
		if(this.canMove(chess)){		
  			var id=this.chessId(chess);
			//���������������״̬,bType:�㲥��type
			client.lWSC.broadcastGamingEvent( { mId: id});
		}
  	},
  	//׼���ƶ�
  	prepareMove : function(id){
  		this.zoom($("#disk>div"),50);
	  	this.zoom($("#chess_"+id),60);
  		this.moveChess=$("#chess_"+id);
		this.canClickBlank=true;	  
  	},
  	//�ɷ��߶�
  	canMove:function (chess){
		var sib=this.siblingChesses(chess);
		for(var j=0;j<sib.length;j++){
			if(this.typeOfChess($("#chess_"+sib[j]+">img"))==-1)return true;
		}
		return false;
  	},
  	//�Ƿ���ƶ������
  	isMoveGrid:function (chess){
		if(this.canClickBlank && this.canMove(this.moveChess)){
			var sib=this.siblingChesses(this.moveChess);
			for(var j=0;j<sib.length;j++){
				if(sib[j]==this.chessId(chess)) return true;
			}
		}
		return false;
  	},
	//�����Ϸ״̬,��ѯ�Է������������޿ո�,�޿ո���Ӯ��.
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
				msg="�����ˡ�";
			}else{
				msg="��ϲ����Ӯ�ˡ�";
			}
		}else if("peace"==method){
			msg="���ƽ����.";
		}else{
			if(client.serverRole()==0){
				if(three.role==1){
					msg="��ϲ����Ӯ�ˡ�";
				}else{
					msg="�����ˡ�";
				}
			}else{
				if(three.role==1){
					msg="�����ˡ�";
				}else{
					msg="��ϲ����Ӯ�ˡ�";
				}
			}
		}
		if(confirm(msg+"����һ����?")){
			var game=three.resetGrid();
			client.lWSC.broadcastGamingEvent({game : game,walkState:false});	
		}
		else{
			client.exitPage();
			window.opener = null;
			window.close();
		}
	},
	//����
  	giveup : function(){
  		if(three.walkState){
  			if(confirm("ȷ��Ҫ������?")){
  				var loser=$("#client").text();
  				client.lWSC.broadcastGamingEvent({endMethod : "giveup" ,giveuper: loser});
  			}
  		}else{
  			alert("�տ�ʼ��,����������.");
  		}  	
  	},
	//�Ѹ��ǵ�������
  	removeCoverChess : function(){
  		if(this.isWalkState()){ //��������
			this.updateChessType(-1,2); 
			this.updateChessType(-1,3);
			this.checkGameState();
			this.role=(this.role==0?1:0); //�����,��role�����Ⱥ�˳��Ե�
			client.showTurn();
			this.walkState=true;
		}
  	},
  	//��ʾ�����ϵ�����
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
						client.showTurn();//��ʾӦ���ֵ�˭����
					}
					if(s==2 || s==3){
						three.role=(three.role==0?1:0); //�����,��role�����Ⱥ�˳��Ե�
						client.showTurn();
						three.role=(three.role==0?1:0); //�����,��role�����Ⱥ�˳��Ե�
					}
				}
			});
		}
  	},
  	//��������������嶯��
  	goChess : function (c,s,cr){
  		var id=this.chessId(c);
		//���������������״̬,bType:�㲥��type
		if(client.lWSC)
			client.lWSC.broadcastGamingEvent( { id: id, cType: s,rim: cr||false,bType : this.type});
  	}, 
  
   //���嶯��
  	move : function (c,s,cr,bt){
  		c="#chess_"+c;
  		this.type=bt;
		this.showChess(c,s,cr);
		this.afterMove($(c),s);
	},
	//�յ��������㲥��,���¶Է������嶯��
	afterMove : function(c,s){
		var type=this.type;
		if(this.walkState){ //����ģʽ
			if(type==-1){ //���������
				three.zoom($("#disk>div"),50);
				this.zoom(c,60); //��ʾ�����
				this.showChess(this.moveChess,-1); //�����ǰ�����
				if(this.isThreeLine(c)){
					this.showCoverable();
				}						
			}
					
			if(type==4){
				this.recoverTipChess();
				this.checkGameState();
			}
		}else{ //���岼��ģʽ
			if(type>=0 && type<4) return;
			if(type==-1 && this.canClickBlank){ //�����
				if(this.isThreeLine(c)){
					this.showCoverable(); //��ʾ��Щ����Ա�ѹ
					return;
				}
			}
			if(type==4){ //����ʾ��
				this.recoverTipChess(); //��ʾ��ʧЧ,��ԭΪԭ��
				this.canClickBlank=true;
			}
			//�;�
			if(three.isPeace()){
				client.lWSC.broadcastGamingEvent( { endMethod: "peace"});
			}
			this.removeCoverChess();
		}
		
	},
	//��ʼ������   
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
					if(three.role==client.serverRole()){ //��session.role=0ʱ���Ե��
						var type=three.type=three.typeOfChess($(this).children("img"));
						if(three.walkState){ //����ģʽ
							if(type==1 && three.role==0){ //�ڷ�����
								three.handleMove(this);
							} 
						
							if(type==0 && three.role==1){ //�췽����
								three.handleMove(this);
							}
					
							if(type==-1 && three.isMoveGrid(this)){ //���������
								three.role==1?three.goChess(this,0):three.goChess(this,1);													
							}
					
							if(type==4){
								three.goChess(this,-1);
							}
						}else{ //���岼��ģʽ
							if(type>=0 && type<4) return;
							if(type==-1 && three.canClickBlank){ //�����
								three.role==1?three.goChess(this,0):three.goChess(this,1); //��������
							}
							if(type==4){ //����ʾ��
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