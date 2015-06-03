<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
dim groupID,groupName,mode,TrueName,userName,passWord,ID,sql
mode=request("mode")
if mode=empty then mode=""
groupID=request("groupID")
groupName=request("groupName")
TrueName=request("TrueName")
if TrueName=empty then TrueName=""
userName=request("userName")
response.Write(userName)
'response.End()
if userName=empty then userName=""
passWord=request("passWord")
if passWord=empty then passWord="123"
ID=request("ID")
txt="这个用户名已存在，请重新输入！"
if mode="New" then
    sql="select id from userinfo where username='" & userName & "'"
    Set rs1=conn.execute(sql)
    if not rs1.eof then
        closers(rs1)
        ShowMsg(txt)
    else
        sql = "insert into userinfo (username,password,groupid,truename) values("
        sql = sql & "'" & userName & "','" & passWord&"','" & groupID & "','" & truename & "')"
        conn.execute sql
		ID="1"
        response.Redirect("userList.asp?groupID="&groupID&"&groupName="&groupName)
        closers(rs1)
	end if
elseif mode="Edit" then
    sql="select id from userinfo where username='" & userName & "' and id<>" & ID
    Set rs1=conn.execute(sql)
    if not rs1.eof then
	    closers(rs1)
        ShowMsg(txt)
    else
	    sql="update userinfo set TrueName='"&TrueName&"',username='"&userName&"',password='"&passWord&"' where ID=" & ID
        conn.execute sql
		response.Redirect("userList.asp?groupID="&groupID&"&groupName="&groupName)
        closers(rs1)
    end if
elseif mode="Del" then
    sql="delete userinfo where ID='"&ID&"'"
    conn.execute sql
    response.Redirect("userList.asp?groupID="&groupID&"&groupName="&groupName)
elseif mode="Set" then
    sql="update userinfo set password='123' where ID='"&ID&"'"
    conn.execute sql
    response.Redirect("userList.asp?groupID="&groupID&"&groupName="&groupName)
end if

if ID<>empty then
    sql="select * from userinfo where ID=" & ID
    Set rsr=conn.execute(sql)
    if not rsr.eof then
	    groupID = rsr("groupid")
        groupName = getdata("groupName","groupinfo","id",groupID)
        TrueName = rsr("TrueName")
        userName = rsr("userName")
        passWord = rsr("password")
    end if
	closers(rsr)
end if
%>
<HTML>
<HEAD>
<title>系统管理</title>
<SCRIPT LANGUAGE=javascript>
<!--
        function checkform(mode){
                if (mode=="Del")
                {
                        temp=window.confirm("你确定要删除此用户吗？");
                        if (temp)
                        {
                                form1.mode.value=mode;
                                form1.submit();
                        }
                }
                else if (mode=="Set")
                {
                        temp=window.confirm("你确定要恢复初始密码吗？");
                        if (temp)
                        {
                                form1.mode.value=mode;
                                form1.submit();
                        }
                }
                else
                {
                        if (form1.userName.value=="" || form1.trueName.value=="" || form1.passWord.value=="")
                        {
                                window.alert("输入不可为空！");
                        }else if(form1.passWord.value!=form1.passWord2.value){
                                window.alert("密码不一致，请重新输入！");
                                form1.passWord.focus();
                        }
                        else{
                        form1.mode.value=mode;
                        form1.submit();
                        }
                }

        }
//-->
</SCRIPT>

<meta http-equiv="Context-Language" content="zh-cn"><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
</HEAD>
<BODY leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" bgcolor="#0C89A7">
<form action="UserEdit.asp" method=POST  name=form1>
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
    <tr>
      <td width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="200">
              <p class="unnamed1" align="center"><span class="unnamed1">系统角色设置</span>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td width="100%" bgcolor="#E6E6E6">
        <div align="center">
          <center>
            <table border=0 cellpadding=0 cellspacing=0 width="100%">
              <tr>
                <td colspan=3 bgcolor="#FFFFFF"> <img src="../images/oa_menu_from3_01.gif" width=218 height=1></td>
              </tr>
              <tr>
                <td width="7" background="../images/oa_menu_from3_02.gif">
                  <img border="0" src="../images/tls.gif" width="7" height="1"></td>
                <td bgcolor="#E6E6E6" width="100%" align="center">
                  <h3 align="center"><br>
                  </h3>

                  <table width="75%" border=1 cellspacing=0 cellpadding=5 bordercolordark="#ffffff" bordercolorlight="#484848" bgcolor="#FFFFFF">
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">登陆名称：</font></span>
                        <input  name="userName" class="button1" id="userName" value="<%=userName%>">
                        <font color="#CC3300">（帐号）</font>&nbsp;&nbsp;
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">用户名称：</font></span>
                        <input name="trueName" class="button1" id="trueName" value="<%=trueName%>" >
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">用户密码：</font></span>
                        <input type="password" name="passWord" value="<%=passWord%>" class="button1" >
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">确认密码：</font></span>
                        <input type="password" name="passWord2" value="<%=passWord%>" class="button1" >
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">所属权限组：</font></span>
                        <%=groupName%>

                      </td>
                    </tr>
                    <input type="Hidden" name=groupID value="<%=groupID%>">
                    <input type="Hidden" name=groupName value="<%=groupName%>">
                    <input type="Hidden" name=ID value="<%=ID%>">
                  </table>
                  <p>
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right">
                        <%if mode="NewUser" then%>
                        <input type="button" value="新 增" name=button1 onClick="javascript:checkform('New');" class="button">
                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() ;" class="button">
                        <%else%>
                        <input type="button" value="恢复初始密码" name=button1 onClick="javascript:checkform('Set');" class="button">
                        <input type="button" value="修 改" name=button1 onClick="javascript:checkform('Edit');" class="button">
                        <input type="button" value="删 除" name=button1 onClick="javascript:checkform('Del');" class="button">
                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() ;" class="button">
                        <%end if%>
                        <input type="Hidden" name=mode >
                      </td>
                    </tr>
                  </table>

                  <h3 align="center"><br>
                  </h3>
                </td>
              </tr>
            </table>
          </center>
        </div>
      </td>
    </tr>
  </table>
</form>
</BODY>
</HTML>
<% closeconn() %>