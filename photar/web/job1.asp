<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=javascript>
function goPage(page){
	document.Pageform.action="Job1.asp?thispage="+page;
	document.Pageform.submit();
}
</SCRIPT>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<%
    JobName = request("JobName")
    thispage=1
    if request("thispage")<>empty then thispage = Cint(request("thispage"))
%>
<table width="778" height="155" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/job.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
              <embed src="flash/job.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="4" bgcolor="E7E3E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="1" bgcolor="C8C8C8"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="164" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><a href="index.asp"><img src=<%=Timg("images/fengbiao_index.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="info.asp"><img src=<%=Timg("images/fengbiao_0.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="news.asp"><img src=<%=Timg("images/fengbiao_1.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="mien.asp"><img src=<%=Timg("images/fengbiao_2.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="sell.asp"><img src=<%=Timg("images/fengbiao_3.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="job.asp"><img src=<%=Timg("images/fengbiao_40.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="job.asp?field=JobStratagem" class="a5">人才战略</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="job1.asp" class="a5">招聘信息</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table></td>
    <td width="1" bgcolor="9C9A9C"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
    <td width="613" valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="images/d_tiao.gif">　　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="job.asp" class="a1">人力资源 
            </a><font color="0071BD">&gt;</font> <a href="job1.asp">招聘信息</a></td>
        </tr>
      </table>
      <table width="99%" border="0" align="center" cellpadding="2" cellspacing="0">
        <form name="form1" method="post" action="">
          <tr> 
            <td width="14%" height="35"><font color="#666666">&nbsp;<font color="298E9C">&nbsp;职位查询：</font></font> 
            </td>
            <td width="25%"><input type="text" name="jobname" class="input0"></td>
            <td width="61%"><input type="image" src=<%=Timg("images/search1.gif")%> width="20" height="19"></td>
          </tr>
        </form>
      </table> 
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td bgcolor="#CCCCCC"><table width="100%" border="0" cellspacing="1" cellpadding="4">
              <tr bgcolor="298E9C"> 
                <td height="25"> 
                  <div align="center"><font color="#FFFFFF">更新日期</font></div></td>
                <td> 
                  <div align="center"><font color="#FFFFFF">职位名称</font></div></td>
                <td> 
                  <div align="center"><font color="#FFFFFF">招聘人数</font></div></td>
                <td> 
                  <div align="center"><font color="#FFFFFF">学历</font></div></td>
                <td> 
                  <div align="center"><font color="#FFFFFF">专业</font></div></td>                
              </tr>
<%	set rs=server.CreateObject ("adodb.recordset") 
	sql="select * from Jobinfo where 1=1"
	if JobName<>"" then sql=sql & " and JobName like '%" & JobName & "%'"
	sql=sql & " order by modified desc"
	rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=12	
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
			modified=rs("modified")
%>
                          <tr bgcolor="#FFFFFF" align=left> 
                            <td class="fonthr-18"> 
                              <div align="center"><%=modified%></div></td>
                            <td> <a href="Job_show.asp?ID=<%=ID%>" class="a1"> 
                              <%=JobName%></a> </td>
                            <td class="cpx12black"> 
                              <div align="center"><%=requireNumber%></div></td>
                            <td class="cpx12black"> 
                              <div align="center"><a href="JobList.asp?Mode=EditInfo&ID=<%=ID%>" class="cpx12black"><%=EducationalLevel %></a></div></td>
                            <td class="cpx12black"> 
                              <div align="center"><%=SPECIALTY%></div></td>                            
                          </tr>
                          <%
	 rs.movenext
     next
end if
%>

            </table></td>
        </tr>
      </table><form name="Pageform" method="post">
<input name="jobname" type="hidden" value="<%= jobname %>"><p align="right"><% If thispage>1 Then %> <a href="javascript:goPage(1)" class="a1">首页</a> 
        <a href="javascript:goPage(<%= thispage-1 %>)" class="a1">上一页</a> 
        <% Else %>
        首页 上一页 
        <% End If %> <% If thispage<rs.pagecount Then %> <a href="javascript:goPage(<%= thispage+1 %>)" class="a1">下一页</a> 
        <a href="javascript:goPage(<%= rs.pagecount %>)" class="a1">尾页</a> 
        <% Else %>
        下一页 尾页 
        <% End If %></p></form></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
