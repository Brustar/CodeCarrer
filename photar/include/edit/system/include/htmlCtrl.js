menuXml=new Class_XML();
menuXml.load("../include/xml/pageMenu.xml.jsp");


function menu(menuID,_title,_url){
	var highlight=false;
	var title;
	var url;
	var str;

	if (menuID=="")	{
		document.write("<td></td>");
		return;
	}

	var selectedId=menuXml.getString("pageMenus/selectedId");

	var treeID=menuXml.getString("pageMenus/selectedTreeId").substring(0,3);

	if(_title){
		title=_title;
		url=_url;
	}else{
		if (menuID==menuXml.getString("pageMenus/pageMenu/Item","treeID",treeID,"id"))highlight=true;
	
		menuXml.setDb("pageMenus/pageMenu/Item","id",menuID);
		title=menuXml.dbField("name");
		url=menuXml.dbField("url");
	}


//	alert(menuXml.getString("pageMenu/Item","id","001","name"));

	var str;
	str="<td width=\"85\" height=\"21\" valign=\"bottom\" align=center ";
	if(highlight){
		str+="background=\"../images/botton_bg.gif\" ";
	}else{
		str+="background=\"../images/botton_bg2.gif\" ";
		str+="onMouseOver=\"background='../images/botton_bg.gif';\" onMouseOut=\"background='../images/botton_bg2.gif'\"";
	}
	str+=">";
	str+="<a href=../"+url+">"+title+"</a>";
	str+="</td>";
	document.write(str);
}

function button(text,url,width,type){
	var str="<table width=\""+width+"\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
	str+="<tr>";
	str+="<td width=\"9\">";
	if(type=="submit"){
		str+="<input type=image";
	}else{
		str+="<img";
	}
	str+=" src=\"../edit/images/on_r.gif\" width=\"9\" height=\"20\"></td>";
	str+="<td align=\"center\" background=\"../edit/images/bg_2.gif\" class=\"t9\"><a href=\""+url+"\">";
	str+=text;
	str+="</a></td>";
	str+="<td width=\"10\"><img src=\"../edit/images/on_l.gif\" width=\"9\" height=\"20\"></td>";
    str+="</tr>";
    str+="</table>";
	document.write(str);
	return str;
}

function selectedBox(opt,id){
	for(i=0;i<opt.length;i++){
		if(opt[i].value==id) {
			opt.selectedIndex=i;
			break;
		}
	}
}
