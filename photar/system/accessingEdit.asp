<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ID = request("ID")
     mode = request("Mode")
	 if mode="EditInfo" then
	 	sql="select * from accessing where id="& ID
		set rss=conn.execute(sql)
		if not rss.eof then
			accessingName=rss("accessingName")
			modified=rss("modified")
			content=rss("content")
			MediaName=rss("MediaName")
			telephone=rss("telephone")
			Email=rss("Email")
			ischeck=rss("ischeck")
			accessingDate=rss("accessingDate")
		end if
		closers(rss)
	 end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<link rel="stylesheet" href="../include/style.css" type="text/css">
<script src="../include/edit/system/news/edit.js"></script>
<SCRIPT LANGUAGE=javascript>
<!--
function checkform(mode){
submit_message();
  
  if(mode=="Del"){
    temp=window.confirm("你确定要删除此转让信息吗？");
    if (temp){
      editForm.action="accessingSave.asp?mode="+mode;
      editForm.submit();
    }
  }
  
  if(mode=="Edit"){
    editForm.action="accessingSave.asp?mode="+mode;
    editForm.submit();
  }
  
  if(mode=="New"){
    if(editForm.accessingName.value==""){
      alert("请输入项目名!");
      editForm.accessingName.focus();
      return;
    }
    editForm.action="accessingSave.asp?mode="+mode;
    editForm.submit();
  }
  
  if(mode=="Pass"){
          editForm.action="accessingSave.asp?mode="+mode;
	      editForm.submit();
  }
  
  if(mode=="NotPass"){
          editForm.action="accessingSave.asp?mode="+mode;
          editForm.submit();
  }
  
}
function PopDate(txt){
	var splashWin=window.open("../include/SelectDate.htm",'tip','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0');
	splashWin.resizeTo(230,236);
	DateValue=txt;
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
                  <td align=right class=k_105pt width=147><font size="2"><strong>采访主题：</strong></font></td>
      <td width="554"> <input type=text name="accessingName" size=50 maxlength=150 value="<%=accessingName%>"  class="text1">
        <font color="red">*</font></td>
    </tr>
    <tr>
                  <td align=right class=k_105pt><font size="2"><strong>媒体名：</strong></font></td>
      <td><input type=text name="MediaName" size=50 maxlength=20 value="<%=MediaName%>" class="text1"></td>
    </tr>
	 <tr>
                  <td align=right class=k_105pt><font size="2"><strong>采访日期：</strong></font></td>
                  <td align="left"><input type="text" name=accessingdate value="<%=accessingdate%>" onClick="PopDate(this);" size=20 class="text1" readonly> 
                  </td>
    </tr>
	<tr>
                  <td align=right class=k_105pt><font size="2"><strong>电话：</strong></font></td>
      <td><input type=text name="Telephone" size=50 maxlength=20 value="<%=Telephone%>" class="text1"></td>
    </tr> <tr>
                  <td align=right class=k_105pt><font size="2"><strong>电子邮件：</strong></font></td>
                  <td align="left"><input type=text name="Email" size=50 maxlength=50 value="<%=Email%>" class="text1"> 
                  </td>
    </tr>
    <tr>
                  <td valign="top" align="right" class=k_105pt width=147> <font size="2"><strong><br>
                    采访说明： </strong></font></td>
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
    </tr>    <tr>
      <td align=right class=k_105pt> <font size="2"><strong>审批状态：
        </strong></font></td>
      <td align=left class=k_105pt>
<%
        select case ischeck
            case 0
				res("未审批")
            case 1
				res("通过")
            case 2
				res("不通过")
        end select
%>
     </td>
    </tr>
    <tr>
      <td valign="top"><font size="2">&nbsp;</font></td>
      <td>
<input type="Hidden" name=english value="<%= session("language") %>">
<input type=hidden name="MyBody" value="">
<input type="hidden" name="ID" value="<%=ID%>">
<input type="hidden" name="isCheck" value="<%=isCheck%>">
<!-- #include FILE="../include/Buttons.asp" -->
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