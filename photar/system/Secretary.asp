<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     mode = "EditInfo"
	  if session("language")=1 then 
	 	table="SiteInitEn"
	else
		table="SiteInit"
	end if
	 if mode="EditInfo" then
	 	sql="select * from " & table
		set rs=conn.execute(sql)
		if not rs.eof then
			secretary=rs("secretary")
			secretaryinfo=rs("secretaryinfo") '档案
			secretaryPic=rs("secretaryPic")
			secretaryMail=rs("secretaryMail")
		end if
	 end if
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
<script src="../include/edit/system/news/edit.js"></script>
<SCRIPT LANGUAGE=javascript>
<!--
function checkform(mode){
  submit_message();
  if(mode=="Del"){
    temp=window.confirm("你确定要删除此新闻吗？");
    if (temp){
      editForm.action="initSave.asp?mode="+mode;
      editForm.submit();
    }

  }
  if(mode=="Edit"){
    editForm.action="initSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="New"){
    if(editForm.secretary.value==""){
      alert("请输入网站名称!");
      editForm.secretary.focus();
      return;
    }
    editForm.action="initSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="Pass"){
          editForm.action="initSave.asp?mode="+mode;
	      editForm.submit();
  }
  if(mode=="NotPass"){
          editForm.action="initSave.asp?mode="+mode;
          editForm.submit();
  }
}

function UploadFile(txt){
  window.open("../include/upload.asp","UploadFile","width=450,height=80,scrollbars=yes");
  FileValue=txt;
}
//-->
</SCRIPT>
</head>
<body bgcolor="#0C89A7" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0">
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#0C89A7" width="90%" align="center">
  <tr>
	<td width="100%" bgcolor="#E6E6E6">
		<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="red">*</font>为必填项
		<br>
      <table border=0 cellpadding="2" cellspacing="1" width="100%">
		<tr>
		  <td colspan=2 align=center><strong><font size="4">信 息 发 布</font></strong></td>
		</tr>
        <tr>
          <td valign="top">
<form name="editForm" method="post">
  <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
    <tr>
                  <td align=right class=k_105pt width=139><font si??ze="2"><strong>董秘姓名：</strong></font></td>
      <td width="748"> <input type=text name="secretary" size=50 maxlength=150 value="<%=secretary%>"  class="text1">
        <font color="red">*</font></td>
    </tr>
    <tr >
                  <td align=right class=k_105pt width=139><font si??ze="2"><strong>董秘照片：</strong></font></td>
      <td>
	  <input name="secretaryPic" type=text class="text1" value="<%=secretaryPic%>" size="30" readonly>&nbsp;&nbsp
  <input type="button" name="btattache" value="浏览..." onclick="UploadFile(secretaryPic)" class="button">
                    <% If secretaryPic<>empty Then %><img src="../uploadfiles/<%=secretaryPic%>" alt="董秘照片预览"><% End If %>
 </td>
    </tr>    <tr>
                  <td align=right class=k_105pt width=139><font si??ze="2"><strong>董秘邮箱：</strong></font></td>
      <td width="748"> <input type=text name="secretaryMail" size=50 maxlength=150 value="<%=secretaryMail%>"  class="text1">
        <font color="red">*</font></td>
    </tr>
    <tr>
                  <td valign="top" align="right" class=k_105pt width=139> <font size="2"><strong><br>
                    </strong></font><font si??ze="2"><strong>董秘档案</strong></font><font size="2"><strong></strong></font><font size="2"><strong>： 
                    </strong></font></td>
                  <td align="left"> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= secretaryInfo %>"> 
        <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
        <IFRAME STYLE="border: none" NAME=EditBox src="../include/edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
      </td>
    </tr>
    <tr>
                  <td align=right class=k_105pt> <font size="2"><strong>修改日期： 
                    </strong></font></td>
        <td width="748" align=left class=k_105pt> <%=now%> </td>     
    </tr>
    <tr>
      <td valign="top"><font size="2">&nbsp;</font></td>
      <td>
<input type=hidden name="MyBody" value="">
<input type="button" name="bt2" value="修改" class="text3" onClick="checkform('Edit')">
<input type="button" name="btBack" value="返回" class="text3" onClick="javascript:history.back();">
      </td>
    </tr>
  </table>
</form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%
	closers(rs)
    CloseConn()
%>