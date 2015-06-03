//	---------------------------------------------------------------------------
//	jWebSocket Client Gaming Plug-In
//	Copyright (c) 2010 Alexander Schulze, Innotrade GmbH, Herzogenrath
//	---------------------------------------------------------------------------
//	This program is free software; you can redistribute it and/or modify it
//	under the terms of the GNU Lesser General Public License as published by the
//	Free Software Foundation; either version 3 of the License, or (at your
//	option) any later version.
//	This program is distributed in the hope that it will be useful, but WITHOUT
//	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//	FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
//	more details.
//	You should have received a copy of the GNU Lesser General Public License along
//	with this program; if not, see <http://www.gnu.org/licenses/lgpl.html>.
//	---------------------------------------------------------------------------


//	---------------------------------------------------------------------------
//  jWebSocket Client Gaming Plug-In
//	---------------------------------------------------------------------------

jws.ClientGamingPlugIn = {

	// namespace for client gaming plugin
	// not yet used because here we use the system broadcast only
	NS: jws.NS_BASE + ".plugins.clientGaming",
	
	fIsActive: false,

	setActive: function( aActive ) {
		if( aActive ) {
			
		} else {
			
		}
		jws.ClientGamingPlugIn.fIsActive = aActive;
	},
	
	isActive: function() {
		return jws.ClientGamingPlugIn.fIsActive;
	},

	// this method is called when the server connection was established
	processOpened: function( aToken ) {
		log( "jws.ClientGamingPlugIn: Opened " + aToken.sourceId );
		if( this.isActive() ) {		
			// broadcast an identify request to all clients to initialize game.
			aToken.ns = jws.SystemClientPlugIn.NS;
			aToken.type = "broadcast";
			aToken.request = "identify";
			this.sendToken( aToken );
		}	
	},

	// this method is called when the server connection was closed
	processClosed: function( aToken ) {
		// console.log( "jws.ClientGamingPlugIn: Closed " + aToken.sourceId );

		// if disconnected remove ALL players from playground
		if( this.isActive() ) {
		
		}	
	},

	// this method is called when another client connected to the network
	processConnected: function( aToken ) {
		// console.log( "jws.ClientGamingPlugIn: Connected " + aToken.sourceId );
		if( this.isActive() ) {
				//move(aToken.id,aToken.cType,aToken.rim);
		}	
	},

	// this method is called when another client disconnected from the network
	processDisconnected: function( aToken ) {
		// console.log( "jws.ClientGamingPlugIn: Disconnected " + aToken.sourceId );
		if( this.isActive() ) {
		
		}	
	},

	// this method processes an incomng token from another client or the server
	processToken: function( aToken ) {
		// Clients use system broadcast, so there's no special namespace here
		if( aToken.ns == jws.SystemClientPlugIn.NS ) {
			// process a click from another client
			if( aToken.event == "move" ) {
				//three.move(aToken.id,aToken.type,aToken.rim,aToken.canClick);
			// process a move from another client
			} else if( aToken.event == "identification" ) {					
				// process an identification request from another client
				if(aToken.game!=undefined) {
					three.reload(aToken.game);
					client.loadPlayer(aToken.ps,aToken.enter,aToken.nick,aToken.ws);
				}
			} else if( aToken.request == "identify" ) {
				var game=three.currentGrids();
				var ps=three.player;
				var nick=$("#client").text();
				var enter =client.isEnter;
				var ws=three.walkState;
				var lToken = {
					ns: jws.SystemClientPlugIn.NS,
					type: "broadcast",
					event: "identification",
					game: game,
					ps : ps,
					enter : enter,
					nick : nick,
					ws : ws,
					username: this.getUsername()
				};
				this.sendToken( lToken );				
			}
		}
	},

	// this method broadcasts a token to all other clients on the server
	broadcastGamingEvent: function( aToken, aOptions ) {
		var lRes = this.checkConnected();
		if( lRes.code == 0 ) {
			// use name space of system plug in here because 
			// there's no server side plug-in for the client-pluh-in
			aToken.ns = jws.SystemClientPlugIn.NS;
			aToken.type = "broadcast";
			aToken.event = "move";
			// explicitely include sender,
			// default is false on the server
			aToken.senderIncluded = true;
			// do not need a response here, save some time ;-)
			aToken.responseRequested = false;
			aToken.username = this.getUsername();
			this.sendToken( aToken, aOptions );
		}
		return lRes;
	}

};

// add the JWebSocket Client Gaming PlugIn into the TokenClient class
jws.oop.addPlugIn( jws.jWebSocketTokenClient, jws.ClientGamingPlugIn );
