function startup(){
	var gPrefService=null;
	var swift=document.getElementById('swift');
	var exact=document.getElementById('exact');
	if (!gPrefService)
      gPrefService = Components.classes["@mozilla.org/preferences-service;1"]
                               .getService(Components.interfaces.nsIPrefBranch2);
	if(gPrefService.getBoolPref("javascript.enabled")){
		exact.setAttribute('selected',true);
		swift.setAttribute('selected',false);
	}else{
		exact.setAttribute('selected',false);
		swift.setAttribute('selected',true);
	}
}

function doOK(){
	var gPrefService=null;
	var configs=document.getElementById('configs');
	if (!gPrefService)
      gPrefService = Components.classes["@mozilla.org/preferences-service;1"]
                               .getService(Components.interfaces.nsIPrefBranch2);	

	if (configs.selectedIndex==0) {
		gPrefService.setBoolPref("javascript.enabled", false);
		gPrefService.setBoolPref("security.enable_java", false);
	}
	if (configs.selectedIndex==1) {
		gPrefService.setBoolPref("javascript.enabled", true);
		gPrefService.setBoolPref("security.enable_java", true);
	}
}

function doCancel(){
	//alert("cancel");
}

addEventListener("load", startup, false);