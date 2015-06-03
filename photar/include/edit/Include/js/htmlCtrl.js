function Class_HTML(){
	this.radio=Radio;
	this.setRadio=SetRadio;
	this.setUpRadio=SetUpRadio;
	this.setCtrl=SetCtrl;
}

function SetUpRadio(name,defaultValue,style,nYes,nNo,vYes,vNo){
	this.name=name;

	this.nYes="是";
	if(nYes)this.nYes=nYes;
	
	this.nNo="否";
	if(nNo)	this.nNo=nNo;
	
	this.vYes=1;
	if(vYes) this.vYes=vYes;
	
	this.vNo=0;
	if(vNo)this.vNo=vNo;
	
	this.defaultValue=vYes;
	if(defaultValue)this.defaultValue=defaultValue;

}

function SetCtrl(ctrl){
	this.ctrl=ctrl;
}

function Radio(vRadio){
	var oRadio="";
	if(vRadio) oRadio=vRadio;
	
	if(oRadio=="")oRadio=this.defaultValue;

	var str="<input type=radio name="+this.name+" value="+this.vYes;
//	alert(this.defaultValue);
///	alert(this.vYes);
	if(this.vYes==oRadio) str += " checked";
	str += "> "+this.nYes;
 	str += " <input type=radio name="+this.name+" value="+this.vNo;
	if(this.vNo==oRadio) str += " checked";
	str += "> "+this.nNo ;
	document.write(str);
}

function SetRadio(value){
	if(!this.ctrl) {
		alert("SetCtrl() must be first");
		return;
	}

	for(i=0;i<this.ctrl.length;i++){
		if(this.ctrl[i].value==value)
			this.ctrl[i].checked=true;
	}

}


// 以下三个函数用于 "返回"按钮
function goBack(url){
	f=document.backURL;
	f.action=url;
	f.backFlag.value="1";
	f.submit();
}
function goUrl(url){
	document.backURL.action=url;
	document.backURL.submit();
}
function backUrl(form){
	form.backURL.value=document.backURL.backURL.value;
}
