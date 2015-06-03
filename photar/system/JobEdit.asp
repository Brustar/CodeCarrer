<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ID = request("ID")
     mode = request("Mode")
	 if mode="EditInfo" then
	 	sql="select * from Jobinfo where id="& ID
		set rss=conn.execute(sql)
		if not rss.eof then
			JobName=rss("JobName")
			modified=rss("modified")
			content=rss("requirement")
			requireNumber=rss("requireNumber")
			EducationalLevel=rss("EducationalLevel")
			Salary=rss("Salary")
			specialty=rss("specialty")
		end if
		closers(rss)
	 end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<link rel="stylesheet" href="../include/style.css" type="text/css">
<script src="../include/edit/include/xml.js"></script>
<script src="../include/edit/system/include/htmlCtrl.js"></script>
<script src="../include/edit/include/js/htmlCtrl.js"></script>
<script src="../include/edit/system/news/edit.js"></script>
<SCRIPT LANGUAGE=javascript>
<!--
function checkform(mode){
submit_message();
  
  if(mode=="Del"){
    temp=window.confirm("你确定要删除此招聘信息吗？");
    if (temp){
      editForm.action="JobSave.asp?mode="+mode;
      editForm.submit();
    }
  }
  
  if(mode=="Edit"){
    editForm.action="JobSave.asp?mode="+mode;
    editForm.submit();
  }
  
  if(mode=="New"){
    if(editForm.JobName.value==""){
      alert("请输入职位名!");
      editForm.JobName.focus();
      return;
    }
    editForm.action="JobSave.asp?mode="+mode;
    editForm.submit();
  }
  
  if(mode=="Pass"){
          editForm.action="JobSave.asp?mode="+mode;
	      editForm.submit();
  }
  
  if(mode=="NotPass"){
          editForm.action="JobSave.asp?mode="+mode;
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
		  <td colspan=2 align=center><strong><font size="4">职 位 信 息 发 布</font></strong></td>
		</tr>
        <tr>
          <td valign="top">
<form name="editForm" method="post">
  <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
    <tr>
                  <td align=right class=k_105pt width=147><font size="2"><strong>职位名：</strong></font></td>
      <td width="554"> <input type=text name="JobName" size=50 maxlength=150 value="<%=JobName%>"  class="text1">
        <font color="red">*</font></td>
    </tr>
    <tr>
                  <td align=right class=k_105pt><font size="2"><strong>招聘人数：</strong></font></td>
      <td><input type=text name="requireNumber" size=50 maxlength=20 value="<%=requireNumber%>" class="text1"></td>
    </tr>
	  <tr>
                  <td align=right class=k_105pt width=147><font size="2"><strong>学历：</strong></font></td>
      <td><select name="EducationalLevel">
		<%getSelect "specialty","id,EducationalLevel",EducationalLevel%>			
      </select>
      </td>
    </tr> 
    <tr>
                  <td align=right class=k_105pt width=147><font size="2"><strong>专业：</strong></font></td>
      <td><input type=text name="specialty" size=50 maxlength=50 value="<%=specialty%>" class="text1">
                     </td>
    </tr> 
    <tr>
                  <td align=right class=k_105pt><font size="2"><strong>提供薪水：</strong></font></td>
                  <td align="left"><input type=text name="Salary" size=50 maxlength=50 value="<%=Salary%>" class="text1"> 
                  </td>
    </tr>
    <tr>
      <td valign="top" align="right" class=k_105pt width=147> <font size="2"><strong><br>
                    职位要求及说明： </strong></font></td>
                  <td align="left"> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= content %>"> 
        <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
        <IFRAME STYLE="border: none" NAME=EditBox src="../include/edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
      </td>
    </tr>
    <tr>
      <td align=right class=k_105pt> <font size="2"><strong>创建日期：
        </strong></font></td>
      <%if mode="NewInfo" then 
	  		nowstr=now
		else
			nowstr=modified
		end if
	  %>
        <td width="554" align=left class=k_105pt> <%=nowstr%> </td>     
    </tr>
    <tr>
      <td valign="top"><font size="2">&nbsp;</font></td>
      <td>
 <input type="Hidden" name=english value="<%= session("language") %>">
<input type=hidden name="MyBody" value="">
<input type="hidden" name="ID" value="<%=ID%>">
<input type="hidden" name="isCheck" value="<%=isCheck%>">
<% if mode="NewInfo" then %>
<input type="button" name="bt1" value="新增" class="text3" onClick="checkform('New')">
<% Elseif mode="EditInfo" then %>
          <input type="button" name="bt2" value="修改" class="text3" onClick="checkform('Edit')">
          <input type="button" name="bt3" value="删除" class="text3" onClick="checkform('Del')"> 
<% End If %>
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
<% CloseConn() %>