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
		if rs(0)<>0 then   'grade=0��Ϊ�����ʺ�
			session("grade")=rs(0)
			session("username")=rs(1)
			temp=split(getData("groupname,rightID","groupinfo","id",rs(2)),"$")
			'session("groupName")=temp(0) 'ȡȨ������
			'session("rightID")=temp(1)  'ȡȨ��			
			Response.Redirect "index.htm"
		else
%>
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
	window.alert("���ʺ���Ȩ��,�������Ա��ϵ��");
	history.back();
//-->
</SCRIPT>
<%  		
		end if
	else
%>
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
	window.alert("�Ƿ��ʺŻ����룡");
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
<title>ϵͳ�����¼</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
function checkform() {
	if (document.form1.Loginid.value=="")
	{
		window.alert("�������ʺŲ���Ϊ��!");
		document.form1.Loginid.onfocus;
		return (false);
	}
			
	if (document.form1.password.value=="")
	{
		window.alert("���벻��Ϊ��!");
		document.form1.password.onfocus;
		return (false);
	}
	if (document.form1.password.value.indexOf("'")>=0)
	{
		window.alert("���벻���зǷ��ַ�.");
		document.form1.password.onfocus;
		return (false);
	}
	if (document.form1.Loginid.value.indexOf("'")>=0)
	{
		window.alert("�������ʺŲ����зǷ��ַ�.");
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
            �ʺţ�</td>
          <td width=191 bgcolor=#dfdfdb height=38 valign="bottom"> 
            <input 
      style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; FONT-SIZE: 13px; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #dfdfdb" 
      size=14 name="Loginid">
          </td>
        </tr>
        <tr> 
          <td width=71 bgcolor=#dfdfdb height=26 align="right" valign="bottom" class="fontpx12"> 
            ���룺</td>
          <td valign=bottom width=191 bgcolor=#dfdfdb height=26> 
            
              <input type="password"
      style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; FONT-SIZE: 13px; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #dfdfdb" 
      size=14 name="password">
              </td>
        </tr>
        <tr> 
              <td style="FONT-SIZE: 12px; VERTICAL-ALIGN: 0px; LETTER-SPACING: 1px" 
    valign=top width=262 bgcolor=#dfdfdb colspan=2 height=61> <p align=center><br>
	                  <input type="submit" value="��¼" id=submit1 name=submit1 class="text2">&nbsp;&nbsp;
                  <input name="resetform" type="reset" value="����">
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