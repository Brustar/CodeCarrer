//	var xml = new ActiveXObject("Microsoft.XMLDOM");
//	xml.async = false;


//-------------------------------------------------------------
// ע: ����xml��Record���ļ�¼�����.
//     ����˵: xml.childNodes.length ���Ǽ�¼��������.
function xmlFieldData(xml,recordnum,field)
// recordnum	- ��¼��
// field		- �ֶ���
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
// ��¼���������
function xmlLength(xml){
//	alert(xml.childNodes.length);
	try{
		return(xml.childNodes.length);
	}catch(exception){
		alert("XML�˵��ļ���ȡ����!");
	}
}

//--------------------------------------
// XML �� �����˵�
// ����	xml һ��ɲ���"��"��¼.
//		xmlRecordTag ��ָ���¼����"·��", ��: "DATA/Company"
//		oID �������˵�ѡȡֵ, ��selectedѡ�����ֵ
//		offset - Ϊ��ʱ��û�е�һ����򣬵�һ����ǿ�
function xmlOption(xml,xmlRecordTag,xID,xName,opt,oID,offset,OptionStyle,xTreeID){

	if(!opt){
		alert("ϵͳ����: �˵��ؼ�����!");
		return;
	}
	if(!xml){
		alert("ϵͳ����: xml�ļ�����ش���!");
		return;
	}

	var args=xmlOption.arguments;	
//	var OptionStyle;
//--------------------------------------
//	OptionStyle - �����˵�����ʽ��
//	"SORT" :  xID�ĳ���Ϊ3ʱ, xNameǰ��"--", �������������ո�
//	if (args.length>7)	OptionStyle=args[7];


//	alert(xmlRecordTag.lastIndexOf("/"));
	var i=xmlRecordTag.lastIndexOf("/");
	//----------------------------
	// ��������Ŀ��, ��Ϊ��ȡ�Ǽ�¼��������,
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
				// ע: ����ʹ�� >0 ��Ϊ���ݴ�, 
				//     �����Ӧʹ��"SORT"��, ʹ����"SORT"��, �����������ѭ��!
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
				// ע: ����ʹ�� >0 ��Ϊ���ݴ�, 
				//     �����Ӧʹ��"SORT"��, ʹ����"SORT"��, �����������ѭ��!
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
// ���� xID Ϊ xValue��, ��ΪoName��ֵ.
	function getString(xmlRecordTag,xID,xValue,oName) {
//		alert(xml.getElementsByTagName("pageMenu").item(0).childNodes.length);
//		var a=xml.getElementsByTagName("pageMenu").item(0);
//		alert(a.childNodes.length);
//		alert(xmlLength(a));
		
		var i,head_xml;

		var i=xmlRecordTag.lastIndexOf("/");

	  try{
		//----------------------------
		// ��������Ŀ��, ��Ϊ��ȡ�Ǽ�¼��������,
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
// XML����:
//
//	var xml = new ActiveXObject("Microsoft.XMLDOM");
//	xml.async = false;
//	xml.load("../company/company.xml.php");
//
//	1. root=xml.documentElement;	����¼.
//
//	2. root=xml.getElementsByTagName("DATA").item(0)
//		���xml�ļ���:
//		<DATA>
//			<name>test</name>
//		</DATA>
//		��ʱ, (1)��(2)��root�ǵ�ֵ��. ��һ��ʹ��(1)������, ����Ҫ֪��"��"�ֶ���.
//
//		����, Ҳ��ͬ��: 
//	 	root=xml.childNodes.item(0);
//
//	3. ȡ��һ��(��һ��)�ļ�¼��, �ؼ���ʹ��: .item(0)   , ����:
//		xml.getElementsByTagName("DATA").item(0).getElementsByTagName("Company").item(0).text  
//		xml.getElementsByTagName("pageMenu/Item");
//		��: ��ͬ��:
//		1. xml.getElementsByTagName("DATA/Company").item(0).text
//		2. xml.getElementsByTagName("DATA/Company").item(0).xml
//
//	4. ������(3)��, ��֪���ֶ�ʱ��ʹ�÷���, �粻֪���ֶ���, ��ʹ��: childNodes ; ����:
//		xml.getElementsByTagName("DATA").item(0).childNodes.item(0).text
//
//	5. ��¼�����ļ��㷽��:
//		xml.childNodes.length
//
//	6. �����xml�ṹ�������, ʹ�����·���ָ���ֱ�ӵ��������.
//		xml.getElementsByTagName("DATA/Company").item(0).text
//		ע: �⿴��ȥ�ܷ���, ��ʵ����һЩ����Ǻܲ������, ��Ҫ�ǲ�֪����¼����,
//			����, ������ȡ��"Company"������, ������Ҫ֪���ж�����Company,�Ͳ���֪����,
//			ֻ��ʹ�� xml.getElementsByTagName("DATA").childNodes.length
//				��: xml.documentElement.childNodes.length;	
//			�Ե��ظ�, �ں���Ӧ����, ��ʹ��"DATA/Company"��Ϊ����, �ں����ڽ��зֽ�.
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
		alert("xml file load error");  //ע��, ������ǲ�����!, Ҳ����˵, ���ᱨ��.
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
// ���� xID Ϊ xValue��, ��ΪoName��ֵ.
function getXmlString(xmlRecordTag,xID,xValue,oName) {
  try{
	var args=getXmlString.arguments;
	
		var rowNum=xID;
		var headStr=xmlRecordTag.substring(0,xmlRecordTag.lastIndexOf("/"));

	//---------------------------------
	// ֻ��һ������, ȡ���������ĵ�һ����¼.
	if(args.length==1){
		return this.xml.getElementsByTagName(xmlRecordTag).item(0).text;
	}
	//---------------------------------
	// ֻ����������, ȡ���������ĵ� xID ����¼. 
	// ע: 
	//		1. xID �ڴ˶������ѱ�Ϊ�� �ڼ�����¼, 
	//		2. xmlRecordTag������������ "/", 
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


		//--------------------- �����ǲ���:
//		return (this.xml.getElementsByTagName(headStr).item(0).getElementsByTagName(fieldName).item(0).text);

//		return (this.xml.getElementsByTagName(headStr).item(rowNum).text);

		return xmlFieldData(this.xml.getElementsByTagName(headStr).item(rowNum),xID,fieldName);

	
	}

		
	var i,head_xml;

	var i=xmlRecordTag.lastIndexOf("/");
	//----------------------------
	// ��������Ŀ��, ��Ϊ��ȡ�Ǽ�¼��������,
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
