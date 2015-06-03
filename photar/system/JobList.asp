<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
    JobName = request("JobName")
    specialty = request("specialty")
	CompanyID = request("CompanyID")
    thispage=1
    if request("thispage")<>empty then thispage = Cint(request("thispage"))
%>
<html>
<head>
<title>应聘信息管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" href="../include/style.css" type="text/css">
<SCRIPT LANGUAGE=javascript>
function submitForm(Data){
  document.FrmNews.byMode.value=Data;
  document.FrmNews.submit();
}

function goPage(page){
	document.Pageform.action="JobList.asp?thispage="+page;
	document.Pageform.submit();
}
</SCRIPT>
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" >
<table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
  <form name="FrmNews" method="post" action="">
  <tr>
    <td width="100%">
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td bgcolor="#0C89A7"  valign="middle" >
            <p class="unnamed1" align="center">应 聘 信 息 管 理 </td>

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
              <td bgcolor="#E6E6E6" width="100%" align="right"> <br>
                <table border="0" cellspacing="8" cellpadding="0" width="100%">
                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table border="0" width="100%" cellpadding="3" cellspacing="1">
                        <tr bgcolor="#e4e4e4">
                           <td bgcolor="#FFFFFF">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <input type=hidden name=currentpages value="1">
                                <tr> 
                                  <td class="cpx12black" height=35>&nbsp;职位名： 
                                    <input name="JobName" size=25 value="<%=JobName%>" class="text1"> 
                                   <input type=hidden name=mode> <input type=hidden name=byMode value="">
                                    &nbsp; </td>
                                  <td height=35 colspan="2" class="cpx12black">&nbsp;专业： 
                                    <input name="specialty" size=25 value="<%=specialty%>" class="text1"> 
                                    &nbsp; </td>
                                  <td class="cpx12black" height=35>
                                    <a href="javascript:submitForm('byCate')" class="cpx12black"><img src="../images/button_search.gif" alt="查询" width="33" height="19" border="0" align="absmiddle"></a> 
                                  </td>
                                </tr>
                              </table>
                           </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                                <a href="JobEdit.asp?Mode=NewInfo" class="cpx12black"><img src="../images/button_add.gif" border="0" alt="新增" align="absmiddle"></a>&nbsp;&nbsp;&nbsp;&nbsp;
<table border="0" cellspacing="8" cellpadding="0" width="100%">
                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table width="100%" border="0" cellpadding="3" cellspacing="1">
                          <tr bgcolor="#C8C8C8" align=center> 
                            <td class="cpx12black" align=center>序号</td>
                            <td class="cpx12black" align=center>职位名</td>
                            <td class="cpx12black" align=center>需求人数</td>
                            <td align=center class="cpx12black">应聘人数</td>
							<td class="cpx12black" align=center>专业</td>
                            <td class="cpx12black" align=center>学历</td>
                            
                          </tr>
                          <%
'页面显示
	set rs=server.CreateObject ("adodb.recordset") 
	sql="select * from Jobinfo where 1=1"
	if JobName<>"" then sql=sql & " and JobName like '%" & JobName & "%'"
	if specialty<>"" then sql=sql & " and specialty like '%" & specialty & "%'"
	sql=sql & " and english=" & session("language")
	sql=sql & " order by modified desc"
	rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=20	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			JobName=RS("JobName")
			SPECIALTY=RS("SPECIALTY")
			requireNumber=RS("requireNumber")
			EducationalLevel=getdata("EducationalLevel","specialty","id",RS("EducationalLevel"))
			RequestNumber=RS("RequestNumber")
			ID=rs("ID")
%>
                          <tr bgcolor="#FFFFFF" align=left> 
                            <td class="cpx12black"> 
                              <div align="center"><%=i%></div></td>
                            <td> <a href="JobEdit.asp?Mode=EditInfo&ID=<%=ID%>" class="cpx12black"> 
                              <%=JobName%></a> </td>
                            <td class="cpx12black"> 
                              <div align="center"><%=requireNumber%></div></td>
                            <td class="cpx12black"> 
                              <div align="center"><a href="JobList.asp?Mode=EditInfo&ID=<%=ID%>" class="cpx12black"><%=RequestNumber %></a></div></td>
                            <td class="cpx12black"> 
                              <div align="center"><%=SPECIALTY%></div></td>
                            <td class="cpx12black"> <div align="center"><% =EducationalLevel%></div></td>
                          </tr>
                          <%
	 rs.movenext
     next
end if
%>
                        </table>
                    </td>
                  </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="right" class="cpx12black">
<!-- #include FILE="../include/goPage.asp" -->
                    </td>
                  </tr>
                </table>
                <br>
              </td>
              <td background="../images/oa_menu_from3_04.gif" width="7"><img border="0" src="../images/tls.gif" width="7" height="1">
                　</td>
            </tr>
            <tr>
              <td width="7"> <img src="../images/oa_menu_from3_05.gif" width=7 height=15></td>
              <td background="../images/oa_menu_from3_06.gif" width="100%">
                <img border="0" src="../images/tls.gif" width="7" height="1"></td>
              <td width="7"> <img src="../images/oa_menu_from3_07.gif" width=7 height=15></td>
            </tr>
          </table>
        </center>
      </div>
    </td>
  </tr>
    </form>
</table>
</body>
</html>
<% 
closers(rs)
closeconn()
 %>