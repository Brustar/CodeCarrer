<!--#include file="../inc/dbopen.asp"-->
<% 
id = trim(request("id")) 
sql="select * from production where id=" & id
set rs=conn.execute(sql)
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>后台管理</title>
<link href="../images/this.css" rel="stylesheet" type="text/css">
<link href="../edit/this.css" rel="stylesheet" type="text/css">
</head>
<script src="../edit/include/xml.js"></script>
<script src="../edit/system/include/htmlCtrl.js"></script>
<script src="../edit/include/js/htmlCtrl.js"></script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="96%" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#000000">
  <tr bgcolor="#ffffff">
          
    <td height="10" align="left" class=t9 colspan=2> <strong><font color="#FF6600" class=t9>您现在的位置：－&gt; 
      </font> <span id=nav class=t9> 修改产品信息</span> </strong> </td>
        </tr>

<script src="../edit/system/news/edit.js"></script>
<script>
function go(pageNO){
//	if(pageNO==0)return;
	document.searchForm.pageNO.value=pageNO;
	document.searchForm.submit();
}
//onload=onStart;

var a=document.location.href;
var urlRoot=a.indexOf("/",7);
//alert(a.substring(urlRoot,a.length));
var img="";

function doEdit(){
	submit_message();
}

function doReset(){
	document.editForm.reset();
	//RTELoaded(document.frames.EditBox);
}



function imgCtrl(){
	var args=imgCtrl.arguments;
	var com="";

	for(i=0;i<args.length;i++){
		if(com!="") com+="&&";
		com += args[i] + "==''" ;
	}
//			alert(com);
	if(com!=""){
		com = "if("+com+"){"
			+ "	document.all.showPic.style.display='none';"
			+ "}else{"
			+ "	document.all.showPic.style.display=''; "
			+ "} ";
//			alert(com);
		eval(com);
	}
	

	for(i=0;i<args.length;i++){
		com = "if("+args[i]+"!=''){ "
			+ " document.all."+args[i]+"_show.style.display=''; "
			+ " document.all."+args[i]+"_pic.src='/Img/news/'+"+args[i]+"; "
			+ "	}else{ "
			+ "	document.all."+args[i]+"_show.style.display='none';"
			+ "	} ";
//			alert(com);
	eval(com);
	}
}


</script>
        <tr bgcolor="#ffffff">
          <td colspan=2>
	 &nbsp;>> <a href="#" onclick="javascript: history.back();">返回</a> 
              
            </td>
            </tr>
	  <form action="modify_action.asp" method=post name=editForm onSubmit="javascript: return false; submit_message();">
       <tr> 
      <td width=200 align=center bgcolor="#DAFCF4">产品名称</td>
      <td bgcolor=#FFFFEE><input name="pro_name" type="text" id="pro_name" value="<%= rs("pro_name") %>">
        <input name="id" type="hidden" id="id" value="<%= request("id") %>"> </td>
    </tr>
	   <tr bgcolor="#DAFCF4">                
      <td width=200 align=center bgcolor="#DAFCF4">所属产品类别</td>
				
      <td bgcolor=#FFFFEE> 
        <select name="parent_id" id="parent_id">
          <option value="0" selected>Sisco产品根目录</option>
          <% sql="select * from product_class where parent_id=0"
				set class_1=conn.execute(sql)
				do while not class_1.eof
				%>
          <option value="<%=class_1(0)  %>" <% If Cint(rs("parent_id"))=Cint(class_1("id")) Then response.Write("selected") %>>&nbsp;├<%= class_1("class_name") %></option>
          <% 
				strsql="select * from product_class where parent_id=" & class_1(0)
				set class_2=conn.execute(strsql)
				do while not class_2.eof%>
          <option value="<%=class_2(0) %>" <% If Cint(rs("parent_id"))=Cint(class_2("id")) Then response.Write("selected") %>>&nbsp;&nbsp;┠<%= class_2("class_name") %></option>
          <% 
				strsql="select * from product_class where parent_id=" & class_2(0)
				set class_3=conn.execute(strsql)
				do while not class_3.eof%>
          <option value="<%=class_3(0) %>" <% If Cint(rs("parent_id"))=Cint(class_3("id")) Then response.Write("selected") %>>&nbsp;&nbsp;&nbsp;├<%= class_3("class_name") %></option>
          <% 
				class_3.movenext
				loop
				class_2.movenext
				loop
				class_1.movenext
				loop
				 %>
        </select></td>     
			  </tr>
	   <tr> 
      <td width=200 align=center bgcolor="#DAFCF4">产品说明</td>
      <td bgcolor=#FFFFEE> </td>
    </tr>
    <tr> 
      <td bgcolor=#FFFFEE colspan=2> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= rs("descript") %>"> 
        <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
        <IFRAME STYLE="border: none" NAME=EditBox src="../edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
      </td>
    </tr>     
    <tr bgcolor="#FFFFee"> 
      <td colspan=4 align=center> <table border="0" cellpadding="2" cellspacing="0" class="t9">
          <tr> 
            <td width="65"> <script>button("修改","javascript:doEdit();",70,"submit");</script></td>
            <td width="65"> <script>button("取消","javascript:doReset();",70);</script></td>
            <td height="25" align=right colspan=2> </td>
          </tr>
        </table></td>
    </tr>
  </form>
  <%
   rs.close 
   set rs=nothing
   conn.close 
   set conn=nothing   
   %>
</table>
</body>
</html>
