<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/tree.asp" -->
<%
rightID=session("rightID")
if session("grade")=1 then '超级管理员
	sql="select * from Moduleinfo where parentID=0"
else
	sql = "select * from Moduleinfo where parentID=0 and id in(" & rightID & ")"
end if
set rs=conn.execute(sql)
%>
<html>
<head>
<title>电子配套市场</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../include/css.css" type="text/css">

</head>

<body bgcolor="#0C89A7" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../images/left_bg_829.gif">
 <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" align="left">
            <script language=JavaScript1.2 src="../include/menu.js"></script>
            <!--第一层-->
<%
            i = 0
            while not rs.eof
                i=i+1
                moduleName=rs("modulename")
				moduleID=rs("ID")
				parentid=rs("parentid")
				URL=rs("URL")
				if parentid=0 then
					functions=""
				else
					functions=URL
				end if
                dim parentName,parent,childName
                parentName="KB" &i&"Parent"
                parent="KB"&i
                childName="KB"&i&"Child"
                if parentid=0 then
%>
                  <div class=parent id=<%=parentName%>>
                  <a href="#" onClick="expandIt('<%=parent%>'); return false" >
                  <table width="100%" cellpadding="0" cellspacing="0" border="0" height="19">
                    <tr>
                       <td height="19" width="150" background="../images/new_bu_2.gif" class="cpx12black" valign="middle" align="left">
                       <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td class="shadow1" align="left" height="19">&nbsp;&nbsp;<%=moduleName%></td>
                          </tr>
                        </table>
                        </td>

                    </tr>
                  </table>
                  </a></div>
<%  getTree moduleID,childName
	end if   'IsModule
	rs.movenext
wend
    rs.close()
	set rs=nothing
	closeconn()
%>

 <script language=JavaScript>
if (NS4) {
        firstEl = "KB1Parent";
        firstInd = getIndex(firstEl);
        arrange();
}
</script>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      </td>
  </tr>
</table>
</body>
</html>