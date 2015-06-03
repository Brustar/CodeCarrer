<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
    title = request("TITLE")
    startdate = request("STARTDATE")
    endDate = request("ENDDATE")
	Enterprise = request("Enterprise")
    cateid = request("ID")
    thispage=1
    if request("thispage")<>empty then thispage = Cint(request("thispage"))
%>
<html>
<head>
<title>信息编辑管理</title>
<meta http-equiv="Content-Type" content="text/html charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
<SCRIPT LANGUAGE=javascript>
function submitForm(){
  document.FrmReference.submit();
}

function PopDate(txt){
	var splashWin=window.open("../include/SelectDate.htm",'tip','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0');
	splashWin.resizeTo(230,236);
	DateValue=txt;
}

function goPage(page){
	document.Pageform.action="ReferenceList.asp?thispage="+page;
	document.Pageform.submit();
}
</SCRIPT>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" >
<table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
  <tr>
    <td width="100%">
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td bgcolor="#0C89A7"  valign="middle" > <p class="unnamed1" align="center">产 
              品 宣 传 册 管 理 </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td width="100%" bgcolor="#E6E6E6">
          <table border=0 cellpadding=0 cellspacing=0 width="100%" align="center">
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
  <form name="FrmReference" method="post">
    <input type=hidden name=currentpages value="1">
    <tr>
                              <td class="cpx12black" height=65>产品名称： 
                                <input name="TITLE" size=25 value="<%=title%>" class="text1">
        &nbsp;
      </td>
      <input type=hidden name=byMode value="">
      <td class="cpx12black" height=65>
        日期：从
        <input type="text" name=STARTDATE value="<%=startdate%>" onClick="PopDate(this);" size=10 class="text1" readonly></input>
        到
        <input type="text" name=ENDDATE value="<%=endDate%>" onClick="PopDate(this);"size=10 class="text1" readonly></input> 
               </td>
      <td class="cpx12black" height=35>
        &nbsp;类别：
<select name="id">
<option></option>
<%getSelectTree "ProductCate","Catename","",session("language")%>
</SELECT>
                                    <a href="javascript:submitForm()" class="cpx12black"><img src="../images/button_search.gif" alt="查询" width="33" height="19" border="0" align="absmiddle"></a> 
                                  </td>
    </tr>
  </form>
</table>
                           </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <a href="ReferenceEdit.asp?Mode=NewInfo&rightsID=<%=rightsID%>&CompanyID=<%=companyid%>" class="cpx12black"><img src="../images/button_add.gif" border="0" alt="新增" align="absmiddle"></a>&nbsp;&nbsp;
<table border="0" cellspacing="8" cellpadding="0" width="100%">
                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table border="0" width="100%" cellpadding="3" cellspacing="1">
                        <tr bgcolor="#C8C8C8" align=center>
                          
                      <td width="288" class="cpx12black">资料名称</td>
                          <td width="121" class="cpx12black">类别</td>
                          
                      <td width="182" class="cpx12black">下载地址</td>
                          <td width="144" class="cpx12black">
                            <div align="center">发布日期</div>
                          </td>
                          <td width="60" class="cpx12black" >审批标识</td>
                        </tr>
<%
'页面显示
	set rs=server.CreateObject ("adodb.recordset") 
	sql="select * from Reference where 1=1"
	if TITLE<>"" then sql=sql & " and ReferenceName like '" & TITLE & "%'"
	if startdate<>"" and endDate<>"" then sql=sql & " and modified<'" & endDate & "' and modified>='"&startdate&"'"
	if cateid<>"" then sql=sql & " and cateid = " & cateid
	if Enterprise<>"" then sql=sql & " and Enterprise=" & Enterprise
	sql=sql & " and english=" & session("language")
	sql=sql & " order by modified desc"
	rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=20	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			ReferenceName=rs("ReferenceName")
			cateName=getdata("cateName","ProductCate","id",rs("cateid"))
			URL=rs("URL")
			modified=rs("modified")
			isCheck=rs("isCheck")
			ID=rs("ID")
%>
<tr bgcolor="#FFFFFF" align=left>
  <td width="288">
    <a href="ReferenceEdit.asp?Mode=EditInfo&ReferenceID=<%=ID%>&rightsID=<%=rightsID%>&CompanyID=<%=companyid%>" class="cpx12black">
    <%=ReferenceName%></a>
  </td>
  <td width="121" class="cpx12black">
    <div align="center"><%=cateName%></div>
  </td>
  <td width="182" class="cpx12black">
    <div align="center"><%=URL%></div>
  </td>
  <td width="144" class="cpx12black">
    <div align="center"><%=modified%></div>
  </td>
  <td width="60" align=center>
    <%
	if isCheck=1 then 
		res("通过")
	elseif isCheck=2 then 
		res("不通过") 
	else 
		res("未审批")
	end if
	%>
  </td>
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
<form name="Pageform" method="post">
<input name="title" type="hidden" value="<%= title %>">
<input name="cateID" type="hidden" value="<%= cateID %>">
<input name="startDate" type="hidden" value="<%= startDate %>">
<input name="endDate" type="hidden" value="<%= endDate %>">
<input name="Enterprise" type="hidden" value="<%= Enterprise %>">				
                  <tr>
                    <td align="right" class="cpx12black">					
<!-- #include FILE="../include/goPage.asp" -->
                    </td>
                  </tr></form>
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
    </td>
  </tr>
</table>
</body>
</html>
<% 
 closeRS(rs)
closeConn() %>