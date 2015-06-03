<!-- #include FILE="../include/StringParse.asp" -->
<% 
    loginID=Request("loginID")
	res loginid
    password=Request("password")
    strmode=Request("mode")
	if strmode="out" then 
		'session.Abandon
		session("grade")=empty
		session("username")=empty
		session("groupName")=empty
		session("rightID")=empty	
	end if
%>
<html>
<head>
<%
if trim(loginID)<>"" then
	sql="select grade,username,groupID from userinfo where username='"&loginID&"' and password='"&password&"'"
	set rs=conn.execute(sql)
	if not rs.eof then
		if rs(0)<>0 then   'grade=0是为禁用帐号
			session("grade")=rs(0)
			session("username")=rs(1)
			temp=split(getData("groupname,rightID","groupinfo","id",rs(2)),"$")
			'session("groupName")=temp(0) '取权限组名
			'session("rightID")=temp(1)  '取权限			
			Response.Redirect "index.htm"
		else
%>
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
	window.alert("该帐号无权限,请与管理员联系！");
	history.back();
//-->
</SCRIPT>
<%  		
		end if
	else
%>
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
	window.alert("非法帐号或密码！");
	history.back();
//-->
</SCRIPT>
<% 
	end if
	rs.close
    set rs=nothing
end if
CloseConn()	
%>
<title>系统管理登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
function checkform() {
	if (document.form1.Loginid.value=="")
	{
		window.alert("管理者帐号不能为空!");
		document.form1.Loginid.onfocus;
		return (false);
	}
			
	if (document.form1.password.value=="")
	{
		window.alert("密码不能为空!");
		document.form1.password.onfocus;
		return (false);
	}
	if (document.form1.password.value.indexOf("'")>=0)
	{
		window.alert("密码不可有非法字符.");
		document.form1.password.onfocus;
		return (false);
	}
	if (document.form1.Loginid.value.indexOf("'")>=0)
	{
		window.alert("管理者帐号不可有非法字符.");
		document.form1.Loginid.onfocus;
		return (false);
	}
	return(true);
}

//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="css/style.css" type="text/css">
</head>

<body bgcolor="#0C89A7" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../images/main_bg.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
<FORM action="Login.asp" method=POST id=form1 name=form1 onsubmit="return checkform()">
  <tr>
    <td align="center"> 
      <table cellspacing=0 cellpadding=0 width=270 border=0>
        <tbody> 
        <tr> 
          <td width=267 bgcolor=#dfdfdb colspan=3 height=21> 
            <p align="center"><img height=21 
      src="../images/login_01.gif" width=267></p>
          </td>
          <td width=3 bgcolor=#dfdfdb height=146 rowspan=4> 
            <p align="center"><img height=146 
      src="../images/login_02.gif" width=3></p>
          </td>
        </tr>
        <tr> 
          <td width=5 bgcolor=#dfdfdb height=140 rowspan=4> 
            <p align="center"><img height=140 
      src="../images/login_03.gif" width=5></p>
          </td>
          <td width=71 bgcolor=#dfdfdb height=38 align="right" valign="bottom" class="fontpx12"> 
            帐号：</td>
          <td width=191 bgcolor=#dfdfdb height=38 valign="bottom"> 
            <input 
      style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; FONT-SIZE: 13px; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #dfdfdb" 
      size=14 name="Loginid">
          </td>
        </tr>
        <tr> 
          <td width=71 bgcolor=#dfdfdb height=26 align="right" valign="bottom" class="fontpx12"> 
            密码：</td>
          <td valign=bottom width=191 bgcolor=#dfdfdb height=26> 
            
              <input type="password"
      style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; FONT-SIZE: 13px; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #dfdfdb" 
      size=14 name="password">
              </td>
        </tr>
        <tr> 
              <td style="FONT-SIZE: 12px; VERTICAL-ALIGN: 0px; LETTER-SPACING: 1px" 
    valign=top width=262 bgcolor=#dfdfdb colspan=2 height=61> <p align=center><br>
	                  <input type="submit" value="登录" id=submit1 name=submit1 class="text2">&nbsp;&nbsp;
                  <input name="resetform" type="reset" value="重置">
                </p>
          </td>
        </tr>
        <tr> 
          <td width=265 bgcolor=#dfdfdb colspan=3 height=15> 
            <p align="center"><img height=15 
      src="../images/login_09.gif" 
width=265></p>
          </td>
        </tr>
        </tbody>
      </table>
    </td>
  </tr></FORM>
</table>
</body>
</html>