//	var xml = new ActiveXObject("Microsoft.XMLDOM");
//	xml.async = false;


//-------------------------------------------------------------
// 注: 参数xml是Record级的记录结果集.
//     或者说: xml.childNodes.length 就是记录集的条数.
function xmlFieldData(xml,recordnum,field)
// recordnum	- 记录数
// field		- 字段名
{
//	root=xml.documentElement;	
//	record=root.getElementsByTagName("ModelData").item(0);
	record=xml.item(recordnum);
//	record=root;

//	alert("xmlFieldData: "+record.text);

	var XML_Data=record.getElementsByTagName(field).item(0).text;

//	alert('Inside getModelData: '+Call_Data);
	return XML_Data;
//	return record.getElementsByTagName(field).item(0).text;
}

//--------------------------------------
// 记录结果集条数
function xmlLength(xml){
//	alert(xml.childNodes.length);
	try{
		return(xml.childNodes.length);
	}catch(exception){
		alert("XML菜单文件读取出错!");
	}
}

//--------------------------------------
// XML 与 下拉菜单
// 参数	xml 一般可采用"根"记录.
//		xmlRecordTag 是指向记录集的"路径", 如: "DATA/Company"
//		oID 是下拉菜单选取值, 即selected选择项的值
//		offset - 为空时，没有第一项，否则，第一项就是空
function xmlOption(xml,xmlRecordTag,xID,xName,opt,oID,offset,OptionStyle,xTreeID){

	if(!opt){
		alert("系统错误: 菜单控件不对!");
		return;
	}
	if(!xml){
		alert("系统错误: xml文件或相关错误!");
		return;
	}

	var args=xmlOption.arguments;	
//	var OptionStyle;
//--------------------------------------
//	OptionStyle - 下拉菜单的样式。
//	"SORT" :  xID的长度为3时, xName前加"--", 否则增加缩进空格
//	if (args.length>7)	OptionStyle=args[7];


//	alert(xmlRecordTag.lastIndexOf("/"));
	var i=xmlRecordTag.lastIndexOf("/");
	//----------------------------
	// 以下语句的目的, 是为了取是记录集的条数,
	if (i==-1)	{
		head_xml=xml;
		Recordset=xmlRecordTag;
	}else{
		head_xml=xml.getElementsByTagName(xmlRecordTag.substring(0,xmlRecordTag.lastIndexOf("/"))).item(0);
//		alert(head_xml);
		Recordset=xmlRecordTag.substring(xmlRecordTag.lastIndexOf("/")+1,xmlRecordTag.length);
//		alert(Recordset);
	}
//	alert(xml);
//	alert(xmlFieldData(xml,1,xID));
/*	alert(xmlLength(xml));
	root=xml.documentElement;	
//	record=root.getElementsByTagName("Company").item(1);
	alert(xmlLength(root));

	record=root.getElementsByTagName("DATA");

	alert(record.item(0).text);
	alert(xmlLength(record.item(0)));
*/
	opt.length=offset;
//	var offset=0;
	var	i=0,pre="";
/*	if(FirstItem!=""){
		opt.length=1;
		opt[i].text=FirstItem;
		opt[i].value="";
		offset=1;
		
	}
*/	var selectedIndex=0;
	var idLen;
//		alert(head_xml.item(0).text+xmlLength(head_xml));
	for(i=0;i<xmlLength(head_xml);i++){
//		alert(xmlLength(head_xml)+i);
		opt.length=i+1+offset;

		opt[i+offset].value=xmlFieldData(head_xml.getElementsByTagName(Recordset),i,xID);
		if(OptionStyle=="SORT"){
			idLen=opt[i+offset].value.length;
			if(idLen<=3) {
				pre="--";
			}else{
				idLen=(idLen-3)*2/3;
				pre="";
				//--------------------------------------
				// 注: 以下使用 >0 是为了容错, 
				//     如果不应使用"SORT"的, 使用了"SORT"后, 会造成以下死循环!
				//--------------------------------------
				while(idLen-->0){
					pre+=" ";
				}
			}
		}
		if(OptionStyle=="TreeSORT"){
//			alert(xTreeID);
			idLen=xmlFieldData(head_xml.getElementsByTagName(Recordset),i,xTreeID).length;
//			alert(idLen);
			if(idLen<=3) {
				pre="--";
			}else{
				idLen=(idLen-3)*2/3;
				pre="";
				//--------------------------------------
				// 注: 以下使用 >0 是为了容错, 
				//     如果不应使用"SORT"的, 使用了"SORT"后, 会造成以下死循环!
				//--------------------------------------
				while(idLen-->0){
					pre+=" ";
				}
			}
		}
		opt[i+offset].text=pre+xmlFieldData(head_xml.getElementsByTagName(Recordset),i,xName);
		if(opt[i+offset].value==oID) selectedIndex=i+offset;
	}
//	alert(opt.selectedIndex);
	opt.selectedIndex=selectedIndex;
//	opt.click();
//	alert("OK");
}




/*
			var xmlMenu = new ActiveXObject("Microsoft.XMLDOM");
			xmlMenu.async = false;

			xmlMenu.load("../../../Include/pageMenu.xml");
			root=xmlMenu.getElementsByTagName("pageMenu");
//			alert(root.item(0).text)
			var bb=root.item(0);

			
			alert(bb.getElementsByTagName("Item").item(0).text);
			alert(xmlFieldData(xmlMenu.getElementsByTagName("pageMenu/Item"),1,"id"));

			alert(xmlMenu.getElementsByTagName("pageMenu/Item").item(0).childNodes.length);

*/
//---------------
// 返回 xID 为 xValue的, 名为oName的值.
	function getString(xmlRecordTag,xID,xValue,oName) {
//		alert(xml.getElementsByTagName("pageMenu").item(0).childNodes.length);
//		var a=xml.getElementsByTagName("pageMenu").item(0);
//		alert(a.childNodes.length);
//		alert(xmlLength(a));
		
		var i,head_xml;

		var i=xmlRecordTag.lastIndexOf("/");

	  try{
		//----------------------------
		// 以下语句的目的, 是为了取是记录集的条数,
		if (i==-1)	{
			head_xml=this.xml;
			Recordset=xmlRecordTag;
		}else{
			head_xml=this.xml.getElementsByTagName(xmlRecordTag.substring(0,xmlRecordTag.lastIndexOf("/"))).item(0);
//			alert(head_xml);
			Recordset=xmlRecordTag.substring(xmlRecordTag.lastIndexOf("/")+1,xmlRecordTag.length);
//			alert(Recordset);
		}
		
//		alert(head_xml.childNodes.length);
//		alert(xmlLength(head_xml));
//		alert(this.recordCount());
		
		for (i=0;i<this.recordCount();i++){
//			alert(xmlFieldData(xml.getElementsByTagName(xmlRecordTag),i,xID));
			if(xmlFieldData(this.xml.getElementsByTagName(xmlRecordTag),i,xID)==xValue){
				return xmlFieldData(this.xml.getElementsByTagName(xmlRecordTag),i,oName);
			}
		}
		return "";
	  }catch(exception){
	  }
	}

	function setXmlDb(xmlRecordTag,xID,xValue) {
		this.xmlRecordTag=xmlRecordTag;
		this.xID=xID;
		this.xValue=xValue;
	}

	function getXmlDbField(oName){
		return this.getString(this.xmlRecordTag,this.xID,this.xValue,oName);
	}

//---------------------------------------------
// XML范例:
//
//	var xml = new ActiveXObject("Microsoft.XMLDOM");
//	xml.async = false;
//	xml.load("../company/company.xml.php");
//
//	1. root=xml.documentElement;	根记录.
//
//	2. root=xml.getElementsByTagName("DATA").item(0)
//		如果xml文件如:
//		<DATA>
//			<name>test</name>
//		</DATA>
//		这时, (1)和(2)的root是等值的. 但一般使用(1)更方便, 不需要知道"根"字段名.
//
//		另外, 也等同于: 
//	 	root=xml.childNodes.item(0);
//
//	3. 取下一级(下一层)的记录集, 关键是使用: .item(0)   , 如下:
//		xml.getElementsByTagName("DATA").item(0).getElementsByTagName("Company").item(0).text  
//		xml.getElementsByTagName("pageMenu/Item");
//		另: 等同于:
//		1. xml.getElementsByTagName("DATA/Company").item(0).text
//		2. xml.getElementsByTagName("DATA/Company").item(0).xml
//
//	4. 在以上(3)中, 是知道字段时的使用方法, 如不知道字段名, 可使用: childNodes ; 如下:
//		xml.getElementsByTagName("DATA").item(0).childNodes.item(0).text
//
//	5. 记录条数的计算方法:
//		xml.childNodes.length
//
//	6. 在清楚xml结构的情况下, 使用以下方法指向更直接的深层数据.
//		xml.getElementsByTagName("DATA/Company").item(0).text
//		注: 这看上去很方便, 但实际在一些情况是很不方便的, 主要是不知道记录条数,
//			如上, 很容易取得"Company"的数据, 但我们要知道有多少条Company,就不能知道了,
//			只能使用 xml.getElementsByTagName("DATA").childNodes.length
//				或: xml.documentElement.childNodes.length;	
//			显得重复, 在函数应用中, 可使用"DATA/Company"作为参数, 在函数内进行分解.
//  7. xml.documentElement.xml 
//---------------------------------------------------------
function Class_XML(){
	this.xml= new ActiveXObject("Microsoft.XMLDOM");
	this.xml.async = false;
	this.load=xmlLoad;
	this.recordCount=xmlRecordCount;
	this.getString=getXmlString;
	this.fieldData=FieldData;
	this.selectedBox=xmlSelectedBox;
	this.transformNode=xmlTransformNode;
	this.setDb=setXmlDb;
	this.dbField=getXmlDbField;
	this.addElement=addXmlElement;
}


function FieldData(recordnum,field){
	xmlFieldData(this.xml,recordnum,field);
}

function xmlLoad(fileName){
	try{
		this.xml.load(fileName);
	}catch (exception){ 
		alert("xml file load error");  //注意, 这句总是不运行!, 也就是说, 不会报错.
	}
}

function xmlRecordCount(recordTag){
	var args=xmlRecordCount.arguments;
	if(args.length==0) return(this.xml.documentElement.childNodes.length);
	return(this.xml.getElementsByTagName(recordTag).item(0).childNodes.length);
}

function xmlSelectedBox(xmlRecordTag,xID,xName,opt,oID,offset,optionStyle,xTreeID){
//	alert(this.xml.getElementsByTagName(xmlRecordTag).item(1).text);
	xmlOption(this.xml,xmlRecordTag,xID,xName,opt,oID,offset,optionStyle,xTreeID);
}


//---------------
// 返回 xID 为 xValue的, 名为oName的值.
function getXmlString(xmlRecordTag,xID,xValue,oName) {
  try{
	var args=getXmlString.arguments;
	
		var rowNum=xID;
		var headStr=xmlRecordTag.substring(0,xmlRecordTag.lastIndexOf("/"));

	//---------------------------------
	// 只有一个参数, 取满足条件的第一条记录.
	if(args.length==1){
		return this.xml.getElementsByTagName(xmlRecordTag).item(0).text;
	}
	//---------------------------------
	// 只有两个参数, 取满足条件的第 xID 条记录. 
	// 注: 
	//		1. xID 在此而含义已变为是 第几条记录, 
	//		2. xmlRecordTag中至少有两个 "/", 
	if(args.length==2){
		
		if(headStr.lastIndexOf("/")==-1){
			return this.xml.getElementsByTagName(xmlRecordTag).item(rowNum).text;
		}

//		headStr=headStr.substring(0,headStr.lastIndexOf("/"));
//		alert(headStr);
		var fieldName=xmlRecordTag.substring(xmlRecordTag.lastIndexOf("/")+1,xmlRecordTag.length);
//		alert(fieldName);
//		alert(this.xml.getElementsByTagName(headStr).item(0).text);


//		return xmlFieldData(this.xml.getElementsByTagName(headStr).item("Item"),xID,fieldStr);

//		alert("test:"+this.xml.getElementsByTagName(headStr).item(0).text +fieldName);
		
		return xmlFieldData(this.xml.getElementsByTagName(headStr),rowNum,fieldName);
//				xmlFieldData(head_xml.getElementsByTagName(Recordset),i,xID);


		//--------------------- 以下是测试:
//		return (this.xml.getElementsByTagName(headStr).item(0).getElementsByTagName(fieldName).item(0).text);

//		return (this.xml.getElementsByTagName(headStr).item(rowNum).text);

		return xmlFieldData(this.xml.getElementsByTagName(headStr).item(rowNum),xID,fieldName);

	
	}

		
	var i,head_xml;

	var i=xmlRecordTag.lastIndexOf("/");
	//----------------------------
	// 以下语句的目的, 是为了取是记录集的条数,
	if (i==-1)	{
		head_xml=this.xml;
		Recordset=xmlRecordTag;
	}else{
		head_xml=this.xml.getElementsByTagName(xmlRecordTag.substring(0,xmlRecordTag.lastIndexOf("/"))).item(0);
		Recordset=xmlRecordTag.substring(xmlRecordTag.lastIndexOf("/")+1,xmlRecordTag.length);
//		alert(head_xml.text+ Recordset);
//		alert(Recordset);
	}
	
//	alert(head_xml.childNodes.length);
//	alert(xmlLength(head_xml));
//	alert(this.recordCount());
	
	for (i=0;i<this.recordCount(headStr);i++){
//		alert(xmlFieldData(xml.getElementsByTagName(xmlRecordTag),i,xID));
//		alert(xmlRecordTag);
		if(xmlFieldData(this.xml.getElementsByTagName(xmlRecordTag),i,xID)==xValue){
//			alert("xml validate data i : "+i);
			return xmlFieldData(this.xml.getElementsByTagName(xmlRecordTag),i,oName);
		}
	}
	return "";
  }catch(exception){
	  //alert("XML getString("+xmlRecordTag+"/"+oName+") error. ");
  }
}

function addXmlElement(ElemName,ElemText,recordTag) {

	var root;
    var newElem;
//    alert(this.xml.documentElement.xml);
	if(!recordTag){
	    root = this.xml.documentElement;
	}else{
		root = this.xml.getElementsByTagName(recordTag).item(0);
	}
    newElem = this.xml.createElement(ElemName);

	root.appendChild(newElem);
    root.lastChild.text = ElemText;
}


function xmlTransformNode(xsl){
	var a=this.xml;
	return a.transformNode(xsl.xml);
}
xml=new Class_XML();
xsl=new Class_XML();
