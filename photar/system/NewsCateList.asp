<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<!-- #include FILE="../include/NewsCateTree.asp" -->
<%
    sql = "select * from newscate where parentid=0"	
	sql=sql & " and english=" & session("language")
	set rs=conn.execute(sql)
%>
<html>
<head>
<meta http-equiv="Context-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html charset=gb2312">
<title>系统管理</title>
<script language=javascript>
function del(NewsCate){
	if(confirm("是否确定要删除!")) {
		this.location.href = 'NewsCateEdit.asp?mode=Del&NewsCateID=' + NewsCate;		
	}
	else{
		return(false);
	}
}
</script>
<link rel="stylesheet" href="../include/style.css" type="text/css">
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0">
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
      <tr>
        <td width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%">
            <tr>
              <td bgcolor="#0C89A7" valign="middle" width="200">
                <p class="unnamed1" align="center"><span class="unnamed1"><strong>新闻栏目设置</strong></span> 
          </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td width="100%" bgcolor="#E6E6E6">
          <div align="center">
             <table width="85%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="1" valign="top" background="../images/line_bg.gif"></td>
                <td>
<%
	i=0
    while not rs.eof
		i=i+1
        dim CateName,ID
        CateName = rs("CateName")
        ID = rs("ID")
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
                  <%=CateName%>
                  &nbsp;&nbsp;&nbsp;
  <a HREF="NewsCateEdit.asp?mode=NewNewsCate&parentID=<%=ID%>&rootID=<%=ID%>&isNewsCate=0"><img SRC="../images/fileb.gif" border="0" alt="添加功能页面" height="13" align="absmiddle"></a>&nbsp;
                <a HREF="NewsCateEdit.asp?NewsCateID=<%=ID%>" class="cpx12black"><img SRC="../images/pen.gif" border="0" alt="修改" height="13" align="absmiddle"></a>
								<a HREF="javascript:del(<%=ID%>)"><img SRC="../images/del.gif" border="0" alt="删除子模块" height="13" align="absmiddle"></a>&nbsp;
			<% getNewsCate(ID) %>

                </td>
                    </tr>
                  </table>

<% 
rs.movenext
wend %>
                                 </td>
                </tr>
               </table>

           <p>
              <center>
          <a href="NewsCateEdit.asp?parentID=0&rootID=0&isNewsCate=1&mode=NewNewsCate" class="cpx12black">点击此处增加第一级栏目</a> 
        </center>
            </p>
        </td>
       </tr>
     </table>

</body>
</html>
<% closeconn() %>