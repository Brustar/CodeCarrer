<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
    accessingName = request("accessingName")
	res accessingName
    MediaName = request("MediaName")
	accessingdate = request("accessingdate")
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
	document.Pageform.action="accessing.asp?thispage="+page;
	document.Pageform.submit();
}
function PopDate(txt){
	var splashWin=window.open("../include/SelectDate.htm",'tip','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0');
	splashWin.resizeTo(230,236);
	DateValue=txt;
}
</SCRIPT>
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" >
<table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
  <tr>
    <td width="100%">
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td bgcolor="#0C89A7"  valign="middle" > <p class="unnamed1" align="center">预 
                约 采 访 信 息 管 理 </td>

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
              <td colspan=3 bgcolor="#FFFFFF"> <img src="/oa_menu_from3_01.gif" width=218 height=1></td>
            </tr>
            <tr>
              <td width="7" background="/oa_menu_from3_02.gif">
                <img border="0" src="../images/tls.gif" width="7" height="1"></td>
              <td bgcolor="#E6E6E6" width="100%" align="right"> <br>
                <table border="0" cellspacing="8" cellpadding="0" width="100%">
                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table border="0" width="100%" cellpadding="3" cellspacing="1">
                        <tr bgcolor="#e4e4e4">
                           <td bgcolor="#FFFFFF">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
                                  <form name="FrmNews" method="post" action=""><input type=hidden name=currentpages value="1">
                                <tr> 
                                  <td class="cpx12black" height=35>采访主题： 
                                    <input name="accessingName" size=25 value="<%=accessingName%>" class="text1"> 
                                   <input type=hidden name=mode> <input type=hidden name=byMode value="">
                                    &nbsp; </td>
                                  <td height=35 colspan="2" class="cpx12black">&nbsp;媒体名： 
                                    <input name="MediaName" size=25 value="<%=MediaName%>" class="text1"> 
                                    &nbsp; </td>
                                  <td class="cpx12black" height=35>&nbsp;&nbsp;采访日期：
                                    <input type="text" name=accessingdate value="<%=accessingdate%>" onClick="PopDate(this);" size=10 class="text1" readonly> 
                                    <a href="javascript:submitForm('byCate')" class="cpx12black"><img src="../images/button_search.gif" alt="查询" width="33" height="19" border="0" align="absmiddle"></a> 
                                  </td>
                                </tr></form>
                              </table>
                           </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                                <a href="accessingEdit.asp?Mode=NewInfo" class="cpx12black"><img src="../images/button_add.gif" border="0" alt="新增" align="absmiddle"></a>&nbsp;&nbsp;&nbsp;&nbsp;
<table border="0" cellspacing="8" cellpadding="0" width="100%">
                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table width="100%" border="0" cellpadding="3" cellspacing="1">
                          <tr bgcolor="#C8C8C8" align=center> 
                            
                            <td class="cpx12black" align=center>采访主题</td>
                            <td class="cpx12black" align=center>媒体名</td>
                            <td align=center class="cpx12black">采访日期</td>
							<td class="cpx12black" align=center>联系电话</td>
                            <td class="cpx12black" align=center>审批标识</td>
                            
                          </tr>
                          <%
'页面显示
	set rs=server.CreateObject ("adodb.recordset") 
	sql="select * from accessing where 1=1"
	if accessingName<>"" then sql=sql & " and accessingName like '%" & accessingName & "%'"
	if MediaName<>"" then sql=sql & " and MediaName like '%" & MediaName & "%'"
	if accessingdate<>"" then sql=sql & " and accessingdate = " & accessingdate
	sql=sql & " and english=" & session("language")
	sql=sql & " order by modified desc"
	rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=20	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			rsaccessingName=RS("accessingName")
			rsMediaName=RS("MediaName")
			rsaccessingdate=RS("accessingdate")
			telephone=RS("telephone")
			ischeck=RS("ischeck")
			ID=rs("ID")
%>
                          <tr bgcolor="#FFFFFF" align=left>                            
                            <td> <a href="accessingEdit.asp?Mode=EditInfo&ID=<%=ID%>" class="cpx12black"> 
                              <%=rsaccessingName%></a> </td>
                            <td class="cpx12black"> 
                              <div align="center"><%=rsMediaName%></div></td>
                            <td class="cpx12black"> 
                              <div align="center"><%=rsaccessingdate %></div></td>
							  <td class="cpx12black"> 
                              <div align="center"><%=telephone%></div></td>
                            <td> <div align="center"><%
	if isCheck=1 then 
		res("通过")
	elseif isCheck=2 then 
		res("不通过") 
	else 
		res("未审批")
	end if
	%></div></td>
                          </tr>
                          <%
	 rs.movenext
     next
end if
%>
                        </table>
                    </td>
                  </tr>
                </table><table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="Pageform" method="post">
<input name="accessingName" type="hidden" value="<%= accessingName %>">
<input name="MediaName" type="hidden" value="<%= MediaName %>">
<input name="accessingDate" type="hidden" value="<%=accessingDate %>">				
                  <tr>
                    <td align="right" class="cpx12black">
<!-- #include FILE="../include/goPage.asp" -->
                    </td>
                  </tr> </form>
                </table>
                <br>
              </td>
              <td background="../image/oa_menu_from3_04.gif" width="7"><img border="0" src="../images/tls.gif" width="7" height="1">
                　</td>
            </tr>
          </table>
        </center>
      </div>
    </td>
  </tr>   
</table>
</body>
</html>
<% 
closers(rs)
closeconn()
%>