<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
dim groupID,sql,groupName
groupID=request("groupID")
groupName=request("groupName")
if groupName<>empty then groupName=""
%>
<HTML>
<HEAD>
<title>系统管理</title>
<SCRIPT LANGUAGE=JAVASCRIPT>
<!--
       function GoBack(){
			window.location="UserGroupList.asp";
       }
//-->
</SCRIPT>
<meta http-equiv="Context-Language" content="zh-cn"><meta http-equiv="Content-Type" content="text/html charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
</HEAD>
<BODY leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" bgcolor="#0C89A7">
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
    <tr>
      <td width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="200">
              <p class="unnamed1" align="center"><span class="unnamed1">系统用户设置</span> 
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
                <td colspan=3 bgcolor="#FFFFFF"></td>
                <td bgcolor="#E6E6E6" width="100%" align="center">
                  <h3 align="center"><br>
                  </h3>
                  <table width="570" border=1 cellspacing=0 cellpadding=5 bordercolordark="#ffffff" bordercolorlight="#484848" bgcolor="#FFFFFF">
                    <tr>
                      <td align="center" width="72"><span class="fontpx12"><font color="#CC3300">序号</font></span>
                      </td>
                      <td align="center" width="201"><span class="fontpx12"><font color="#CC3300">用户名称</font></span>
                      </td>
                      <td align="center" width="216"><span class="fontpx12"><font color="#CC3300">登陆名称</font></span>
                      </td>
                      <td align="center" width="299"><span class="fontpx12"><font color="#CC3300">所属权限组</font></span>
                      </td>
                    </tr>
<%
sql="select * from userinfo where groupid=" & groupID
set rss = conn.execute(sql)
i=1
dim userNo,UserID,userName
while not rss.eof
  userNo=rss("TrueName")
  UserID=rss("id")
  userName=rss("userName")
  groupID=rss("groupID")
  groupName = getdata("groupName","groupinfo","id",groupID)
%>
                    <tr>
                      <td align="center" width="72"><span class="fontpx12"><font color="#646464"><%=i%></font></span>
                      </td>
                      <td align="center" width="201"><a href="UserEdit.asp?ID=<%=UserID%>"><span class="fontpx12"><font color="#646464">
                         <%=userNo%>
                         </font></span></a>
                      </td>
                      <td align="center" width="216"><a href="UserEdit.asp?ID=<%=UserID%>"><span class="fontpx12"><font color="#646464"><%=userName%></font></span></a> 　
                      </td>
                      <td align="center" width="299"><span class="fontpx12"><font color="#646464"><%=groupName%></font></span>
                      </td>
                    </tr>
<%
    i=i+1
	rss.movenext
wend
closeRs(rss)   
%>
                  </table>
                  <p>
                  <table width="508" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right" width="506">
                        <input type="button" value="新 增" name=button1 class="button" onClick="javascript:window.location ='UserEdit.asp?mode=NewUser&groupID=<%=groupID%>&groupName=<%=getstring(groupName)%>'"></a>
                        <input type="button" value="返 回" name=button1 onClick="javascript:GoBack()" class="button">
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
</BODY>
</HTML>
<% closeconn() %>