<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ID = request("newsID")
     mode = request("Mode")
	 cateid=request("cateid")
	 if mode="EditInfo" then
	 	sql="select * from newsinfo where id="& ID
		set rs=conn.execute(sql)
		if not rs.eof then
			subject=rs("subject")
			modified=rs("modified")
			content=rs("content")
			source=rs("source")			
			author=rs("author")
			ischeck=rs("ischeck")
			ImgUrl=rs("ImgUrl")
			happendate=rs("happendate")
		end if
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
    temp=window.confirm("你确定要删除此新闻吗？");
    if (temp){
      editForm.action="NewsInfoSave.asp?mode="+mode;
      editForm.submit();
    }

  }
  if(mode=="Edit"){
    editForm.action="NewsInfoSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="New"){
    if(editForm.txtTitle.value==""){
      alert("请输入标题!");
      editForm.txtTitle.focus();
      return;
    }
    editForm.action="NewsInfoSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="Pass"){
          editForm.action="NewsInfoSave.asp?mode="+mode;
	      editForm.submit();
  }
  if(mode=="NotPass"){
          editForm.action="NewsInfoSave.asp?mode="+mode;
          editForm.submit();
  }
}

function submitForm(mode,aspfile){
  if (mode=="del"){
    var temp=window.confirm("确认要删除此数据？");
    if (temp){
            editForm.action="NewsInfoSave.asp?mode="+mode;
            editForm.submit();
    }
  }
  else{
    editForm.action="NewsInfoSave.asp?mode="+mode;
    editForm.submit();
  }
}

function checkNull(){
  if (editForm.txtTitle.value==""){
    alert("请输入标题!");
    return false;
  }
  return true;
}

function RTrim(Str)
{
  var retStr;
  var pos=Str.length;
  if (pos>0)
    {
      while (Str.charAt(--pos) ==" ");
      if (pos==-1)
         retStr="";
      else
        retStr=Str.sub(0,pos+1);
    }
  else
    {
    retStr=Str;
    }
  return retStr;
}

function UploadFile(txt){
  window.open("../include/upload.asp","UploadFile","width=450,height=80,scrollbars=yes");
  FileValue=txt;
}
function PopDate(txt){
	var splashWin=window.open("../include/SelectDate.htm",'tip','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0');
	splashWin.resizeTo(230,236);
	DateValue=txt;
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
      <td align=right class=k_105pt width=110><font si??ze="2"><strong>标题：</strong></font></td>
      <td width="775"> <input type=text name="txtTitle" size=50 maxlength=150 value="<%=subject%>"  class="text1">
        <font color="red">*</font></td>
    </tr>
    <tr >
      <td align=right class=k_105pt width=110><font size="2"><strong>文章来源：</strong></font></td>
      <td><input type=text name="txtResource" size=50 maxlength=50 value="<%=SOURCE%>" class="text1">
      </td>
    </tr>
    <tr>
      <td align=right class=k_105pt><font size="2"><strong>作者：</strong></font></td>
      <td><input type=text name="txtAuthor" size=50 maxlength=20 value="<%=author%>" class="text1"></td>
    </tr>
	<% if cateid="6" or cateid="4" or cateid="7" or cateid="8" then%>
<INPUT TYPE=hidden NAME=cateid value="<%= cateid %>">
<% Else %>
    <tr>
      <td align=right class=k_105pt><font size="2"><strong>信息类别：</strong></font></td>
      <td align="left">
<select name="cateid">
<%getSelectTree "NewsCate","Catename",cateid,session("language")%>
</SELECT>
      </td>
    </tr>
	<% End If %>
    <tr>
      <td valign="top" align="right" class=k_105pt width=110> <font size="2"><strong><br>
        内容： </strong></font></td>
                  <td align="left"> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= content %>"> 
        <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
        <IFRAME STYLE="border: none" NAME=EditBox src="../include/edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
      </td>
    </tr>
    <tr>
      <td align=right class=k_105pt width=110><font size="2"><strong>新闻日期：</strong></font></td>
      <td align="left"><input name=happendate size=15 maxlength=10 value="<%=happendate%>" class="text1" onClick="PopDate(this);">
	  </td>
    </tr>
    <tr>
      <td align=right class=k_105pt width=110><font size="2"><strong>图片附件：</strong></font></td>
      <td align="left"><input name="ImgUrl" type=text class="text1" value="<%=ImgUrl%>" size="30" maxlength="25" readonly> 
                    &nbsp;<input type="button" name="btattache" value="浏览..." onclick="UploadFile(ImgUrl)" class="button">
      </td>
    </tr>
    <tr>
      <td align=right class=k_105pt><font size="2"><strong>发布人：</strong></font></td>
      <td align=left class=k_105pt><%="暂时为空"%></td>
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
        <td width="120" align=left class=k_105pt> <%=nowstr%> </td>     
    </tr>
    <tr>
      <td align=right class=k_105pt> <font size="2"><strong>审批状态：
        </strong></font></td>
      <td align=left class=k_105pt>
<%
        if ischeck then
				res("通过")
		else
				res("不通过")
        end if
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
<%
    CloseConn()
%>