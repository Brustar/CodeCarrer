<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<html>
<head>
<title>信息编辑管理</title>
<meta http-equiv="Content-Type" content="text/html charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
<SCRIPT LANGUAGE=javascript>
function submitForm(){
  document.FrmProduct.submit();
}

function PopDate(txt){
	var splashWin=window.open("../include/SelectDate.htm",'tip','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0');
	splashWin.resizeTo(230,236);
	DateValue=txt;
}

function goPage(page){
	document.Pageform.action="ProductList0.asp?thispage="+page;
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
          <td bgcolor="#0C89A7"  valign="middle" >
            <p class="unnamed1" align="center">产 品 信 息 管 理 </td>
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
  <form name="FrmProduct" method="post">
    <input type=hidden name=currentpages value="1">
    <tr>
                              <td class="cpx12black" height=65>&nbsp;产品名： 
                                <input name="ProductName" size=25 value="<%=ProductName%>" class="text1">
        &nbsp;
      </td>
      <input type=hidden name=byMode value="">
      <td class="cpx12black" height=65>
        日期：从
        <input type="text" name=STARTDATE value="<%=startdate%>" onClick="PopDate(this);" size=10 class="text1" readonly></input>
        到
        <input type="text" name=ENDDATE value="<%=endDate%>" onClick="PopDate(this);"size=10 class="text1" readonly></input>
      </td>
                              <td class="cpx12black" height=35> &nbsp;型号： 
                                <input name="Model" size=25 value="<%=Model%>" class="text1"> 
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
                <a href="ProductEdit.asp?Mode=NewInfo&rightsID=<%=rightsID%>&ProductID=<%=Productid%>" class="cpx12black"><img src="../images/button_add.gif" border="0" alt="新增" align="absmiddle"></a>&nbsp;&nbsp;
<table border="0" cellspacing="8" cellpadding="0" width="100%">
                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table width="100%" border="0" cellpadding="3" cellspacing="1">
                    <tr bgcolor="#C8C8C8" align=center> 
                      <td class="cpx12black">产品名</td>
                      <td colspan="2" class="cpx12black">型号</td>
                      <!--<td width="100" class="cpx12black">浏览级别</td>-->
                      <td class="cpx12black"> <div align="center">发布日期</div></td>
                      <td class="cpx12black" >审批标识</td>
                      <td class="cpx12black" >推荐精品 </td>
                    </tr>
<%
    ProductName = request("ProductName")
    startdate = request("STARTDATE")
    endDate = request("ENDDATE")
    Model = request("ID")
        thispage=1
        if request("thispage")<>empty and isnumeric(request("thispage")) then thispage = Cint(request("thispage"))
%>
					<%
'页面显示
	set rs=server.CreateObject ("adodb.recordset") 
	sql="select * from Productinfo where 1=1"
	if ProductName<>"" then sql=sql & " and ProductName like '" & ProductName & "%'"
	if startdate<>"" and endDate<>"" then sql=sql & " and modified<'" & endDate & "' and modified>='"&startdate&"'"
	if Model<>"" then sql=sql & " and Model like '" & Model &"%'"
	sql=sql & " and english=" & session("language")
	sql=sql & " order by modified desc"
	'response.write("<font color=white>"&sql&"</font>")
	rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=20	
		rs.Absolutepage=thispage
	    if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			ProductName1=rs("ProductName")
			'CompanyName=getdata("CompanyName","CompanyInfo","id",RS("CompanyID"))
			Model=rs("Model")
			createDate=rs("modified")
			isCheck=rs("isCheck")
			ID=rs("ID")
			Favorite=rs("isFavorite")
%>
                    <tr bgcolor="#FFFFFF" align=left> 
                      <td> <a href="ProductEdit.asp?Mode=EditInfo&ID=<%=ID%>&rightsID=<%=rightsID%>&ProductID=<%=Productid%>" class="cpx12black"> 
                        <%=ProductName1%></a> </td>           
                      <td class="cpx12black" colspan="2"> <div align="center"><%=Model%></div></td>
                      <td class="cpx12black"> <div align="center"><%=createDate%></div></td>
                      <td align=center> <%
	if isCheck=1 then 
		res("通过")
	elseif isCheck=2 then 
		res("不通过") 
	else 
		res("未审批")
	end if
	%> </td>
                      <td align=center><% If not Favorite Then %> <a href="ProductSave.asp?mode=Favorite&ID=<%=ID%>">精品</a> 
                        <a href="ProductSave.asp?mode=Commend&ID=<%=ID%>">推荐</a> 
                        <% Else %> <a href="ProductSave.asp?mode=Cancle&ID=<%=ID%>">取消精品</a> 
                        <% End If %> </td>
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
<input name="ProductName" type="hidden" value="<%= ProductName %>">
<input name="Model" type="hidden" value="<%= Model %>">
<input name="startDate" type="hidden" value="<%= startDate %>">
<input name="endDate" type="hidden" value="<%= endDate %>">				
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
closeConn() 
%>