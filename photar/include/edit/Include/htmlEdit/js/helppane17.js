//helppane.js Version 1.7
var H_URL_BASE='',H_TOPIC='',H_KEY='',L_H_TEXT='',H_FILTER='',H_BRAND='',bSearch=false;
var H_CONFIG='',L_H_APP='',L_CONTACTUS_URL='';
var H_BURL='helppane.htm',H_TARG='',H_VER='1.7';
var h_win,H_OTHER='',bResize=true,v4='';
function DoHelp(iNm) {
	var sQP='?',W,H,sWD,sc=screen.width,bIE4PC;
	var agent = navigator.userAgent.toLowerCase();
	var app = navigator.appName.toLowerCase();
       	var agent_isMSN = false, vi = agent.indexOf('msn ');
        var agent_isMacMSN = false;
	if (vi > -1) {
		agent_isMSN = agent.substring(vi+4);
		agent_isMSN = parseFloat(agent_isMSN.substring(0,agent_isMSN.indexOf(";")));
		agent_isMSN = (agent_isMSN != NaN && agent_isMSN >= 6)
	}
        agent_isMacMSN = agent.indexOf('ppc mac os x') > -1  && agent.indexOf('msn explorer') > -1; 

	sQP+='H_VER='+H_VER+'&v4='+v4;
	if (H_BRAND!='') sQP+='&BrandID='+H_BRAND
	if (H_FILTER!='') sQP+='&Filter='+H_FILTER 
        if (agent_isMSN && !agent_isMacMSN){
        sQP+=(bSearch) ? '&SEARCHTERM='+escape(H_KEY)+'&S_TEXT='+encodeURIComponent(L_H_TEXT) :'&TOPIC='+H_TOPIC ;}      else{
        sQP+=(bSearch) ? '&SEARCHTERM='+escape(H_KEY)+'&S_TEXT='+escape(L_H_TEXT):'&TOPIC='+H_TOPIC ;}

	if (typeof(v1)!="undefined") sQP+='&v1='+escape(v1)
	else sQP+='&v1='+escape(document.location.protocol + "//" + document.location.hostname)
    sQP+='&v2='+escape(document.location.search);
    if (typeof(H_CONFIG) != "undefined" && (self.name == null || self.name == "" || self.name == "msnMain")) self.name = H_CONFIG.substring(0,H_CONFIG.indexOf("."));
    sQP+='&tmt='+escape(window.name);
	if (sc<=800) sQP+="&sp=1";
	W=(sc<= 800 && agent.indexOf("mac")==-1)?180:230;
	H=(agent.indexOf("windows")>0 && agent.indexOf("aol")>0) ? screen.availHeight-window.screenTop-22:screen.availHeight//*AOL

	if (agent_isMSN && !agent_isMacMSN){
		window.external.showHelpPane(H_URL_BASE+'/frameset.asp'+sQP+'&H_APP='+encodeURIComponent(L_H_APP)+'&INI='+H_CONFIG,W)
	}
        else if (agent_isMSN && agent_isMacMSN){
		window.external.showHelpPane(H_URL_BASE+'/frameset.asp'+sQP+'&H_APP='+escape(L_H_APP)+'&INI='+H_CONFIG,W)
	}	
	else if (agent.indexOf('webtv')>0 || agent.indexOf('msn companion')>0 || agent.indexOf('stb')>0 ){
                document.location=H_URL_BASE+'/frameset.asp'+sQP+'&H_APP='+escape(L_H_APP)+'&INI='+H_CONFIG
	}
	else {
		sWD="toolbar=0,status=0,menubar=0,width="+W+",height="+H+",left="+(sc-W)+",top=0,resizable=1";
		bResize=false;
		bIE4PC = agent.indexOf("msie 4")>0 && agent.indexOf("aol")<0 && agent.indexOf("mac")<0
		if (H_TARG=='') H_TARG = (bIE4PC)?'_help17':'_help';
		if (iNm != null) H_TARG+=iNm;
		if (bIE4PC && h_win!=null && !h_win.closed) h_win.location.replace(H_BURL+sQP)
		else h_win=window.open(H_BURL+sQP,H_TARG,sWD);
		if (h_win && agent.indexOf("mac")<0 && app.indexOf("netscape")<0) h_win.opener=self//*IE5+PC
	}
}


