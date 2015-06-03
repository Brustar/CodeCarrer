var client={
	isEnter : false,
	lWSC : null,

	createSocket : function (){
		if( jws.browserSupportsWebSockets() ) {
			this.lWSC = new jws.jWebSocketJSONClient();
  			// Optionally enable GUI controls here
	  		jws.ClientGamingPlugIn.setActive( true );
		} else {
  			// Optionally disable GUI controls here
  			alert( jws.MSG_WS_NOT_SUPPORTED );
		}
	},

	login : function () {
		if( this.lWSC ) {
			log( "Logging in..." );
			try {
				var lRes = this.lWSC.login(jws.GUEST_USER_LOGINNAME, jws.GUEST_USER_PASSWORD);
				if( lRes.code == 0 ) {
					log( "Asychronously waiting for response..." );
				} else {
					log( lRes.msg );
				}
			} catch( ex ) {
				log( "Exception: " + ex.message );
			}
		}
	},

	checkKeepAlive : function ( aOptions ) {
		if( !aOptions ) {
			aOptions = {};
		}
		aOptions.interval = 30000;
		this.lWSC.startKeepAlive( aOptions );
	},

	connect : function () {
		var lURL = jws.getDefaultServerURL(); // + "/;timeout=120000";
		// if already connected use existing connection to re-login...
		if( this.lWSC.isConnected() ) {
			log( "Already connected." );
			return;
		}

		log("Connecting to " + lURL + "..." );
		try {
			// try to establish connection to jWebSocket server
			this.lWSC.open( lURL, {
				// use JSON sub protocol
				subProtocol: jws.WS_SUBPROT_JSON,
				// connection timeout in ms
				openTimeout: 5,
				
				// OnConnectionTimeout callback
				OnOpenTimeout: function( aEvent ) {
					log( "Opening timeout exceeded!" );
				},
				// OnOpen callback
				OnOpen: function( aEvent ) {
					log("Connection to established." );
					// start keep alive if user selected that option
					client.checkKeepAlive({ immediate: false });
				},
		
				// OnWelcome event
				OnWelcome: function( aEvent )  {
					log( "jWebSocket Welcome received." );
					// call getAuthClients method from jWebSocket System Client Plug-In
				},

				// OnGoodBye event
				OnGoodBye: function( aEvent )  {
					log( "jWebSocket GoodBye received." );
				},

				// OnMessage callback
				OnMessage: function( aEvent, aToken ) {
					// for debug purposes
					log("OnMessage:" + aEvent.data);
					if( aToken ) {
						// is it a response from a previous request of this client?
						if( aToken.type == "response" ) {
							// figure out of which request
							if( aToken.reqType == "login" ) {
								if( aToken.code == 0 ) {
									log("Welcome '" + aToken.username + "' ");
									// call getAuthClients method from jWebSocket System Client Plug-In
									client.lWSC.broadcastGamingEvent({player:three.player});
								} else {
									log("Error logging in '" + + "': " + aToken.msg );
								}
							} else if( aToken.reqType == "getClients" ) {
							}
							// is it an event w/o a previous request ?
						} else if( aToken.type == "event" ) {
							// interpret the event name
						} else if( aToken.type == "welcome" ) {
							// interpret the event name
						} else if( aToken.type == "goodBye" ) {
							log(" says good bye (reason: " + aToken.reason + ")!" );
						} else if( aToken.type == "broadcast" ) {
							// is it any token from another client
							if(aToken.id!=undefined) three.move(aToken.id,aToken.cType,aToken.rim,aToken.bType);
							if(aToken.mId!=undefined) three.prepareMove(aToken.mId);
							if(aToken.player!=undefined) {
								client.loadPlayer(aToken.player);
								client.loadPlayer(aToken.player);							
							}
							//认输
							if(aToken.endMethod!=undefined){
								three.endGame(aToken.endMethod,aToken.giveuper);
							}
							//游戏重新开始
							if(aToken.game != undefined){
								three.reload(aToken.game,aToken.walkState);						
							}
						}
					}
				},
				// OnReconnecting callback
				OnReconnecting: function( aEvent ) {
					log( "Re-establishing jWebSocket connection..." );
				},
				// OnClose callback
				OnClose: function( aEvent ) {
					this.lWSC.stopKeepAlive();
					log("Disconnected from server." );
				}

			});
		} catch( ex ) {
			log( "Exception: " + ex.message );
		}

		this.lWSC.setSystemCallbacks({
			// OnLoggedIn event
			OnLoggedIn: function( aEvent )  {
				log( "jWebSocket LoggedIn received." );			
			},
			// OnLoginError event
			OnLoginError: function( aEvent )  {
				log( "jWebSocket LogginError received." );
			},
			// OnLoggedOut event
			OnLoggedOut: function( aEvent )  {
				log( "jWebSocket LoggedOut received." );
			},
			// OnLogoutError event
			OnLogoutError: function( aEvent )  {
				log( "jWebSocket LogoutError received." );
			}
		});
	},

	ready : function ready(){
		this.createSocket();
		this.connect();
	},

	serverRole : function (){
		if(three.player.length==2){
			three.player.sort();
			var p=$("#client").text();
			for(var i=0;i<three.player.length;i++){
				if(p==three.player[i]) return i;
			}
		}
		return -1;
	},

	sortPlayer : function (a,b){
		return Math.random() - Math.random();	
	},

	suffix : function (){
		return jws.isIE_LE6()? ".gif" : ".png";
	},
	
	enter : function(){
  		var nick=$("#nickName").val();
  		if(nick){
  			$("#client").text(nick);
  			client.initPlayer();
  			if(three.player.length<2){
  				three.player.push(nick);
  				//游戏开始后,把帮助变成认输
  				client.showGiveup();
  				client.login();
  			}else{
  				client.isEnter=true;
  				alert("游戏人数已满.")
  			}
  		}else{
  			alert("请输入昵称.");
  			$("#nickName").focus();
  		}
	},
	
	showGiveup : function(){
		var giveup=document.createElement("input");
  		$(giveup).val("认输").attr("type","button").bind("click",three.giveup);
  		$(".help").empty().append(giveup);
	},
	
	loadPlayer : function(ps,enter,nick,ws){
		client.isEnter=(ps.length==2);
		three.player=ps;
		if(enter!=undefined){
			client.isEnter=enter;
			if(enter){
				$("#client").text(this.playerByNick(nick));	
			}
			client.showGiveup();
		}
		three.walkState=ws;
		client.initPlayer();
	},
	
	//初始化对家及本方的信息
  	initPlayer : function(){
  		var nick=$("#client").text();
  		var player=this.playerByNick(nick);
  		if(this.serverRole()==0){
  			$("#self").text("本方: "+nick);
  			$("#opponent").text("对方: "+player);
  			$("#st").attr("src","images/start"+this.suffix());
  			$("#ot").attr("src","images/stop"+this.suffix());
  		}else{
  			$("#self").text("对方: "+player);
  			$("#opponent").text("本方: "+nick); 
  			$("#st").attr("src","images/start"+this.suffix()); 		
  			$("#ot").attr("src","images/stop"+this.suffix()); 		
  		}  		
  	},
  	
  	playerByNick : function(nick){
  		var i=-1;
  		for(n in three.player){
  			if(nick!=three.player[n]){
  				i=n;
  			}
  		}
  		return three.player[i]==undefined?"":three.player[i];
  	},
  	
  	//提示应该轮到谁走了
  	showTurn : function(){
  		var ot= three.role==0?"stop":"start";
  		var st= three.role==0?"start":"stop";
  		$("#ot").attr("src","images/"+ot+this.suffix());
  		$("#st").attr("src","images/"+st+this.suffix());
  	},
  	
  	initTip : function(){
  		var nickName= document.createElement("input");
  		$(nickName).attr("id","nickName").attr("type","text").addClass("input");
  		var button=document.createElement("input");
  		$(button).attr("type","button").val("开始").bind("click",client.enter);
  		$("#client").append(nickName).append(button);
  		$("#nickName").focus();
  	},
  	
  	initToolbar : function(){
 		this.ready();
  		this.initPlayer();
  		$("#tStone").attr("src","images/chess_AS"+this.suffix());
  		$("#bStone").attr("src","images/chess_BS"+this.suffix());
  		$("#st").attr("src","images/stop"+this.suffix());
  		$("#ot").attr("src","images/stop"+this.suffix());
  		this.initTip();
  		$(document).bind("keydown",function(e){
  			if(e.keyCode==13){
  				client.enter();
  			}
  		});
  	},
  	
  	exitPage : function () {
		// this allows the server to release the current session
		// immediately w/o waiting on the timeout.
		if( client.lWSC ) {
			client.lWSC.disconnect({
				// force immediate client side disconnect
				timeout: 0
			});
		}
	}
};

function log(c) {
	window.console && console.log(c);
};

$(document).ready(function() {
	client.initToolbar();
	three.init();
});
