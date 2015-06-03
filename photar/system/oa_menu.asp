<!-- #include FILE="../include/UserCheck.asp" -->
<% 
language=request("language")
if language="English" then
	session("language")=1
else
	session("language")=0
end if
 %>
<html>
<head>
<title>广东丰达科技有限公司</title>
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<script language="JavaScript">
<!--
function Exit(){
                if (confirm("确认要注销此系统吗?")){
                        form1.mode.value="out";
                        form1.submit();
                }else{
                    form1.mode.value="";
                }
}
//-->
</script>
<link rel="stylesheet" href="css/style.css" type="text/css">
</head>

<body bgcolor=#0C89A7 leftMargin="0" marginHeight="0" marginWidth="0" topMargin="0" align="center">
<FORM  action="Login.asp" method=post id=form1 name=form1 target="_parent">
    <%
    userName = session("UserName")
    groupName = session("groupName")
%>
<br>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td height="24" align=left>&nbsp;&nbsp;<font size="3" face="华文新魏" color=White><b>广东丰达科技有限公司网站<font size="3">管理平台</font></b></font>&nbsp;&nbsp;<font  color=White>当前用户：<%=userName%>&nbsp;&nbsp;所属权限组：<%=groupName%></font></td>
      <% If session("language")=1 Then %>
	  <td align=right><A HREF="?language=Chinese"><img src="../images/chinese.gif" width="59" height="15" border="0"></A></td><% Else %>
      <td align=right><A HREF="?language=English"><img src="../images/english.gif" width="59" height="15" border="0"></A></td>
      <% End If %><td><div align="center"><A HREF="javascript:Exit()"><img src="../images/exit_new.gif" width="59" height="15" border="0"></A></div></td>
    </tr>
    <tr> 
      <td colspan=4> <table width="100%" border="0" cellspacing="0" cellpadding="0" height="17" background="../images/oa_menu_13_new_bg.gif">
          <tr> 
            <td height="17" width="20"><img src="../images/oa_menu_13_new1a.gif" width="20" height="17"></td>
            <td background="../images/oa_menu_13_new_bg.gif" height="17"> <img src="../images/oa_menu_13_new_bga.gif" width="10" height="10"> 
            </td>
            <td width="50" align="right"> <div align="right"><img src="../images/oa_menu_13_new2.gif" width="50" height="17"></div></td>
          </tr>
        </table></td>
    </tr>
  </table>
<input type="hidden" name="mode" value="out">
</FORM>