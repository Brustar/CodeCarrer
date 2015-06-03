<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<!-- #include FILE="../include/GroupTree.asp" -->
<%
  dim groupIDS,sql  
  sql="select * from groupinfo where parentid='0'"
  Set rs=conn.execute(sql)
%>
<html>
<head>
<meta http-equiv="Context-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html charset=gb2312">
<title>权限组管理</title>
<link rel="stylesheet" href="../include/style.css" type="text/css">
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0">
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
      <tr>
        <td width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%">
            <tr>
              <td bgcolor="#0C89A7" valign="middle" width="200">
                <p class="unnamed1" align="center"><span class="unnamed1">用户权限组设置</span> 
          </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td width="100%" bgcolor="#E6E6E6">       
           <table width="85%" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                <td width="1" valign="top" background="../images/line_bg.gif"></td>
                <td>
<%
while not rs.eof
	  dim groupName, groupID
	  groupName=rs("groupname")
	  groupID=rs("id")
	  parentID=rs("parentid")
%>
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="cpx12black">
                        <table width="75%" border="0" cellspacing="0" cellpadding="0" height="5">
                          <tr>
                                                 <td></td>
                          </tr>
                        </table>

                 <img src="../images/file.gif" width="27" height="13" align="absmiddle">
               <a HREF="RightList.asp?groupID=<%=groupID%>&parentID=<%=parentID%>" class="cpx12black"><%=groupName%></a> &nbsp;&nbsp;&nbsp; <a HREF="UserGroupEdit.asp?mode=NewGroup&parentID=<%=groupID%>&gradeID=<%=gradeID%>"><img SRC="../images/fileb.gif" border="0" alt="添加权限组" WIDTH="11" HEIGHT="13" align="absmiddle"></a>&nbsp; 
                  <a HREF="UserGroupEdit.asp?groupID=<%=groupID%>" class="cpx12black"><img SRC="../images/pen.gif" border="0" alt="修改" height="13" align="absmiddle"></a>&nbsp; 
                  <a HREF="UserList.asp?groupID=<%=groupID%>&groupName=<%=groupName%>"><img SRC="../images/man.gif" border="0" alt="用户列表" height="13" align="absmiddle"></a> 
                  <%  getGroup(groupID) %>
                </td>
                    </tr>
                  </table>

<%
	rs.movenext
wend
    closeRS(rs)
%>
                                 </td>
                </tr>
               </table>

           <p>
              <center>
          <a href="UserGroupEdit.asp?mode=NewGroup&parentID=0" class="cpx12black">点击此处增加第一级权限组</a> 
        </center>
            </p>
        </td>
    </tr>
</table>
</body>
</html>
<% closeconn() %>