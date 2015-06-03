var flvplayer =
    {
        pageUrl: "",
        allText: "",
        ajaxUrl:"",
        flvUrl:"",
        ajReq:null,
        executor:null, 
        queryString: {rpocc: 'rpocc'},
        
        play : function()
        {
	        this.executor="/usr/bin/flvplayer"; //"/usr/bin/kmplayer","/usr/bin/vlc"/usr/bin/mplayer
	        this.pageUrl=window.content.document.location.href;
			if(gContextMenu && gContextMenu.onLink) 
					this.pageUrl=gContextMenu.link.toString();			
	        this.allText = window.content.document.documentElement.innerHTML;
	        this.fillQueryString();
	        if (this.pageUrl.indexOf('youtube.com') != -1)
		    {
			    this.processYouTube();
		    }
		    else if(this.pageUrl.indexOf('abcnews.go.com') != -1){
		    	this.processAbcNews();
		    }
		    
		    else if(this.pageUrl.indexOf('vids.myspace.com') != -1){
		    	this.processMySpace();
		    }
		    
		    else if(this.pageUrl.indexOf('tudou.com') != -1 || this.pageUrl.indexOf('sina.com.cn') != -1 || this.pageUrl.indexOf('youku.com') != -1){
		    	this.ajaxUrl="http://www.flvcd.com/parse.php";
		    	this.sendAjax(this.ajaxUrl,'kw='+this.pageUrl,this.getFlvUrl);
		    }
		    
		    /*else if(this.pageUrl.indexOf('youku.com') != -1){
		    	this.ajaxUrl="http://flv.zlfzl.com/vs.php";
		    	var bitrate="网址例子:"+this.pageUrl;
		    	this.sendAjax(this.ajaxUrl,'url='+this.pageUrl+'&bitrate=' + bitrate ,this.getFlvUrl,true);
		    }*/	        
	        
        },
		
		playMedia : function(){
			if(gContextMenu && gContextMenu.onLink) 
					this.pageUrl=gContextMenu.link.toString();
			else
				return;
			this.playFlv(this.pageUrl);
		},
		
		openModeWindow: function(){
			window.open("chrome://flvplayer/content/browseMode.xul", "_blank","chrome,extrachrome,menubar,resizable,scrollbars,status,toolbar");
		},
        
        fillQueryString: function() {
        	var QS = unescape(window.content.document.location.search).substring(1).split('&');
        	for (var p in QS) {
            	this.queryString[QS[p].split('=')[0].toLowerCase()] = QS[p].split('=')[1];
        	}
    	},
        
        processYouTube: function()
            {
	            var reg=/t=[\w-]{10,}/ig;
	            if (reg.test(this.allText) || reg.test(this.allText))
	            {
		            var code = this.pageUrl.substr(this.pageUrl.lastIndexOf('v=')+2);
		            if(code.indexOf('&') != -1)
			            code = code.substr(0,code.indexOf('&'))
		            this.flvUrl = 'http://youtube.com/get_video?video_id=' + code + "&" + this.allText.match(reg)[0]// (reg.exec(this.allText) || reg.exec(this.allText));
		            this.playFlv(this.flvUrl);
	            }
	            
            },
            
        processAbcNews: function()
            {
	            var regHost=/playerSwf.addVariable \(\"config\"\,\s\"[^\s]+/ig;
	            var regRealHost=/http:\/\/[^\s]+(.com)/ig;
	            var regPath=/playerSwf.addVariable \(\"playlistUrl\"\,\s\"[^\s]+/ig;
	            var regRealPath=/\"\/[^\s]+\"\);/ig;
	            if (regHost.test(this.allText) && regPath.test(this.allText))
	            {
		            var hostTemp = this.allText.match(regHost)[0];
		            var host=hostTemp.match(regRealHost)[0];
		            var pathTemp = this.allText.match(regPath)[0];
		            var temp=pathTemp.match(regRealPath)[0]
		            var path=temp.substring(1,temp.length-3);		           
		            this.ajaxUrl=host + path;
		    		this.sendAjax(this.ajaxUrl,null,this.playAbcNewsFlv);
	            } else{
	            	var param=this.pageUrl.substring(this.pageUrl.indexOf('=')+1,this.pageUrl.length);
	            	this.ajaxUrl="http://a.abcnews.com/widgets/mediaplayer/embedPlayerPlaylist";
		    		this.sendAjax(this.ajaxUrl,"id="+param,this.playAbcNewsFlv);
	            }
            },
        
        processMySpace: function() {
            //alert(this.queryString.videoid)
            this.ajaxUrl="http://mediaservices.myspace.com/services/rss.ashx";
            this.sendAjax(this.ajaxUrl,'type=video&videoID=' + this.queryString.videoid ,this.playAbcNewsFlv);
        
    	},
        
        sendAjax: function(url,params, func, post)
            {
	            this.ajReq = new XMLHttpRequest();

	            if(post)
	            {
		            this.ajReq.open("POST", url, true);
		            this.ajReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
		            this.ajReq.send(params);
	            }
	            else
	            {
		            if(params)
		            	this.ajReq.open("GET", url + "?" + params, true);
		            else
		            	this.ajReq.open("GET", url, true);
		            this.ajReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
		            this.ajReq.send(null);
	            }

	            this.ajReq.onreadystatechange = func;
            },
            
         playFlv: function(url){
         	if(url && url.length>0){
				//var args = ['-quiet','-cache','1024','-framedrop','-autosync','5','-vo','mbx_egl','-vf','field=0','-ao','alsa','-af','format=s32be'];
				 url.replace(/\&/g, "\\\&");
				var args = [];
				proc_call(this.executor,url,args);
			}else
				alert("can't play this media.");
         },
         
         playAbcNewsFlv: function() {
			if (flvplayer.ajReq.readyState == 4) {
				if (flvplayer.ajReq.status == 200) {
				    var result=flvplayer.ajReq.responseText;
					var urlReg=/http:\/\/[^\s]+\.flv/ig;
        			this.flvUrl = result.match(urlReg)[0];
        			flvplayer.playFlv(this.flvUrl);
                }
			}
		},
         
         getFlvUrl: function() {
			if (flvplayer.ajReq.readyState == 4) {
				if (flvplayer.ajReq.status == 200) {
				    var result=flvplayer.ajReq.responseText;
					//var urlReg=/(?:http:\/\/[\w.]+\/[^\s]*)\.flv/ig;
					var urlReg=/(>)(?:http:\/\/[\w.]+\/[^\s]*)(<\/a>)/ig;
        			//this.flvUrl=urlReg.exec(result);
        			var str=result.match(urlReg)[0];
        			var reg = /(>|<\/a>)/g;
        			this.flvUrl = str.replace(reg,function($0)
                                       {
                                           return "";
                                       });
        			flvplayer.playFlv(this.flvUrl);
                }
			}
		}
		
    };

function proc_call(programdir,fileName,args)
{
	if (!fileName){
		alert("Not found file");
		return ;
	}
	
	try
	{
		netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		var file = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
		file.initWithPath(programdir);
		var process=Components.classes['@mozilla.org/process/util;1'].createInstance(Components.interfaces.nsIProcess);
		process.init(file);
		args.push(fileName);	
		process.run(false,args,args.length,{});
	}
	catch(e)
	{
		alert("no flv file embed this page or no such executable.");
	}
}

function playflv()
{
	flvplayer.play();
}

function closeMe (parent, tableNode, original)
{
	try
	{
		original.setAttribute("mpc-granted", "true");
		parent.replaceChild (original, tableNode);
	}
	catch(e)
	{}

}

var flvExt_urlBarListener = {

                               QueryInterface:
                               function(aIID)
                               {
	                               if (aIID.equals(Components.interfaces.nsIWebProgressListener) ||
	                                       aIID.equals(Components.interfaces.nsISupportsWeakReference) ||
	                                       aIID.equals(Components.interfaces.nsISupports))
		                               return this;

	                               throw Components.results.NS_NOINTERFACE;
                               },

                               onLocationChange:
                               function(aProgress, aRequest, aURI)
                               {
	                               flvExtension.processNewURL(aRequest,aURI);
                               },

                               onStateChange:
                               function()
                               {}

                               ,

                               onProgressChange:
                               function()
                               {}

                               ,

                               onStatusChange:
                               function()
                               {}

                               ,

                               onSecurityChange:
                               function()
                               {}

                               ,

                               onLinkIconAvailable:
                               function()
                               {}

                           };

var flvExtension = {

                      oldURL:
                      null,

                      init:
                      function()
                      {
	                      // Listen for webpage loads
	                      gBrowser.addProgressListener(flvExt_urlBarListener,
	                                                   Components.interfaces.nsIWebProgress.NOTIFY_STATE_DOCUMENT);
                      },

                      uninit:
                      function()
                      {
	                      gBrowser.removeProgressListener(flvExt_urlBarListener);
                      },

                      processNewURL:
                      function(aRequest,aURI)
                      {
	                      if (aURI.spec == this.oldURL)
		                      return;

	                      // now we know the url is new...
	                      this.oldURL = aURI.spec;
	                      window.addEventListener("pageshow", replaceNode, true);
                      }
                  };

function replaceNode(event)
{
	var doc=event.originalTarget;
	var flashNodes=getFlashNodes(doc);
	var flashUrls=getFlashUrls(doc);
	for(var i=0;i<flashNodes.length;i++)
	{
		//判断是否为embed flv
		if(embedFlv(doc,flashUrls[i]))
		{ 
			var parent=flashNodes[i].parentNode;
			replaceNodesToTable(doc,flashNodes[i],parent);
		}
	}

}

function getFlashNodes(doc)
{
	var flashNodes=[];

	for(var i=0;i<doc.applets.length;i++)
	{
		t=doc.applets[i].movie.toLowerCase();

		if(t.indexOf(".swf")>0)
			flashNodes.push(doc.applets[i]);
	}

	for(var i=0;i<doc.embeds.length;i++)
	{
		t=doc.embeds[i].src.toLowerCase();

		if(t.indexOf(".swf")>0)
			flashNodes.push(doc.embeds[i]);
	}

	//土豆
	var obj = doc.getElementsByTagName("object");

	for(var i=0; i<obj.length;i++)
		flashNodes.push(obj[i]);

	return flashNodes;
}

function getFlashUrls(doc)
{
	var flashUrls=[];
	var urlArr=[];

	for(var i=0;i<doc.applets.length;i++)
	{
		t=doc.applets[i].movie.toLowerCase();

		if(t.indexOf(".swf")>0)
			urlArr.push(t);
	}

	for(var i=0;i<doc.embeds.length;i++)
	{
		t=doc.embeds[i].src.toLowerCase();

		if(t.indexOf(".swf")>0)
			urlArr.push(t);
	}

	for(var i=0;i<urlArr.length;i++)
	{

		if(((/^\w+:/).test(urlArr[i])))
			flashUrls.push(urlArr[i]);
		else
			flashUrls.push("http://"+doc.location.hostname+doc.location.pathname+urlArr[i]);
	}

	return flashUrls;
}

function embedFlv(doc,url)
{
	var page=doc.location.href.toLowerCase();
	//page.indexOf("youku.com")!=-1 && page.length>"http://www.youku.com/".length 
	var youkuReg=/(v|www|kanba).youku.com\/[^\s]+([==]|[\.html])?/ig;
	
	if((youkuReg.test(page) || youkuReg.test(page)) && url && url.toLowerCase().indexOf("qplayer.swf")!=-1){
		return true;
	}
	//page.indexOf("youtube.com")!=-1 && page.length>"http://www.youtube.com/".length
	var youtubeReg=/www.youtube.com\/watch\?v=[^\s]*/ig;
	if((youtubeReg.test(page) || youtubeReg.test(page)) && url && url.toLowerCase().indexOf("version-check.swf")==-1)
		return true;
	
	var abcnewsReg=/abcnews.go.com\/[^\s]+/ig;
	if(abcnewsReg.test(page) || abcnewsReg.test(page))
		return true;
		
	var myspaceReg=/vids.myspace.com\/[^\s]+/ig;
	if(myspaceReg.test(page) || myspaceReg.test(page))
		return true;
	
	var tudouReg=/www.tudou.com\/[^\s]+/ig;
	if(tudouReg.test(page) || tudouReg.test(page))
		return true;
	var sinaReg=/(video|ent|blog|sports|eladies).sina.com.cn[^\s]*\.[s]*html/ig;	
	if(sinaReg.test(page) || sinaReg.test(page))
		return true;

	return false;
}

function replaceNodesToTable(doc,elem,parent)
{
	try
	{
		var ImgWidth = elem.ownerDocument.defaultView.getComputedStyle( elem, '' ).getPropertyValue ("width");
		var ImgHeight = elem.ownerDocument.defaultView.getComputedStyle( elem, '' ).getPropertyValue ("height");

		if (ImgWidth.indexOf("px") != -1)
		{
			ImgWidth = ImgWidth.substring(0, ImgWidth.indexOf("px"));
		}

		if (ImgHeight.indexOf("px") != -1)
		{
			ImgHeight = ImgHeight.substring(0, ImgHeight.indexOf("px"));
		}

		if (ImgWidth.indexOf("auto") != -1)
		{
			ImgWidth = "100%";
		}

		if (ImgHeight.indexOf("auto") != -1)
		{
			ImgHeight = "100%";
		}

		if (parseInt ( ImgWidth, 10 ) < 80)
			ImgWidth = "80";

		if (parseInt ( ImgHeight, 10 ) < 32)
			ImgHeight = "42";

		if (ImgWidth.indexOf("%") == -1)
			ImgWidth += "px";

		if (ImgHeight.indexOf("%") == -1)
			ImgHeight += "px";

		// Modify TextAlignment
		var alignment = elem.ownerDocument.defaultView.getComputedStyle( elem.parentNode, '' ).getPropertyCSSValue( "text-align" );

		alignment = alignment.getStringValue();

		if ("-moz-center" == alignment)
		{
			alignment = "center";
		}

		if ("start" == alignment)
		{
			alignment = "left";
		}

		var tableNodeRoot = doc.createElement("table");
		tableNodeRoot.setAttribute("cellpadding", "0px");
		tableNodeRoot.setAttribute("cellspacing", "0px");
		tableNodeRoot.setAttribute("border", "0px");
		tableNodeRoot.setAttribute("width", "100%");
		tableNodeRoot.setAttribute("style", "border:none !important;");
		var trNodeRoot = doc.createElement("tr");
		tableNodeRoot.appendChild(trNodeRoot);
		var tdNodeRoot = doc.createElement("td");
		tdNodeRoot.setAttribute("align", alignment);
		trNodeRoot.appendChild(tdNodeRoot);
		var tableNode = doc.createElement("table");
		tableNode.setAttribute("cellpadding", "0");
		tableNode.setAttribute("cellspacing", "0");
		tableNode.setAttribute("style", "float: right !important; border: 0x !important; padding: 0px !important; margin: 0px !important;");
		tdNodeRoot.appendChild(tableNode);
		var trNode = doc.createElement("tr");
		tableNode.appendChild(trNode);

		var tdNode = doc.createElement("td");
		tdNode.setAttribute("valign", "top");
		tdNode.setAttribute("align", "right");
		trNode.appendChild(tdNode);
		//tableNode.setAttribute("title", document.getElementById("bundle_flvplayer").getString("openStream"));
		tableNode.setAttribute("style", "padding: 0px !important; margin: 0px !important; border:solid thin; color: gray; cursor: pointer; border-collapse: collapse; border-style:solid; border-collapse: collapse; border: solid rgb(128, 128, 128) 1px; width: "+ImgWidth+"; height: "+ImgHeight+";");
		
		//tdNode.setAttribute("style", "padding: 0px !important; margin: 0px !important; border: 0px !important; background: rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-pause.png) no-repeat center; height: 100%;");
		tdNode.setAttribute("style", "padding: 0px !important; margin: 0px !important; border: 0px !important; background: rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-pause.png) no-repeat center; height: 100%;");
		
		tdNode.addEventListener("mouseover",  function(event)
		                        {
			                        if (event.target.hasAttribute("mpc-blackBox"))
			                        {
				                        //event.target.style.background = "rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-play.png) no-repeat center"; 
				                        event.target.style.background = "rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-play.png) no-repeat center"; 
			                        }
			                        else
			                        {
				                        //event.target.style.background = "rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-pause.png) no-repeat center";
				                        event.target.style.background = "rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-pause.png) no-repeat center"; 
			                        }

		                        }

		                        , true);
		tdNode.addEventListener("mouseout", function(event)
		                        {
			                        //event.target.style.background = "rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-pause.png) no-repeat center";
			                        event.target.style.background = "rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-pause.png) no-repeat center"; 
		                        }

		                        , true);
		tdNode.setAttribute("mpc-blackBox", true);
		tableNode.addEventListener("click", function(event)
		                           {
			                           if (event.target.hasAttribute("mpc-blackBox"))
			                           {
				                           //event.target.style.background = "rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-wait.gif) no-repeat center";
				                           event.target.style.background = "rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-wait.gif) no-repeat center"; 
				                           // Use a time out to force icon change (upper line) before openning stream
				                           		
				                           window.setTimeout(function ()
				                                             {
					                                             //event.target.style.background = "rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-pause.png) no-repeat center";
					                                             event.target.style.background = "rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-pause.png) no-repeat center"; 
				                                             }
				                                             , 3000);				                           
				                          window.setTimeout(function () {playflv();}  , 1);
									   }
		                           }

		                           , true);
		
		tableNode.addEventListener("dblclick", function(event)
		                           {
			                           return;
		                           }

		                           , true);

		// Close icon
		var imgNode = doc.createElement("img");
		//imgNode.setAttribute("src", "chrome://flvplayer/skin/close.png");
		imgNode.setAttribute("src", "http://www.mtcera.com/images/close.png");
		imgNode.setAttribute("border", "0");
		imgNode.setAttribute("style", "float: right !important; border: 1px black !important; padding: 0px !important; margin: 0px !important;  width: 10px; height: 10px; cursor: pointer; display:inline;");
		imgNode.setAttribute("alt", "X");
		//imgNode.setAttribute("title", document.getElementById("bundle_flvplayer").getString("closeReplacer"));
		imgNode.addEventListener("click", function(event)
		                         {
			                         closeMe(parent, tableNodeRoot, elem);
		                         }

		                         , true);
		imgNode.addEventListener("mouseover", function(event)
		                         {
			                         //tdNode.style.background = "rgb(0, 0, 0) url(chrome://flvplayer/skin/icon-pause.png) no-repeat center";
			                         tdNode.style.background = "rgb(0, 0, 0) url(http://www.mtcera.com/images/icon-pause.png) no-repeat center";
		                         }

		                         , true);
		tdNode.appendChild(imgNode);

		if (parent.nodeName.toLowerCase().indexOf("object") > -1 )
		{
			if (null != parent.parentNode)
			{
				elem = parent;
				parent = parent.parentNode;
			}
		}

		parent.replaceChild (tableNodeRoot, elem);
		return true;

	}
	catch(e)
	{
		//alert("error:"+e.description);
	}

	return false;
}

window.addEventListener("load", function()
                        {
	                        flvExtension.init()
                        }

                        , false);
window.addEventListener("unload", function()
                        {
	                        flvExtension.uninit()
                        }

                        , false);
