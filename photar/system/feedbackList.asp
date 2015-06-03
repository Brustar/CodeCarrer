<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
	cateid = request("cateid")
	subject = request("subject")
	Email = request("Email")
    thispage=1
    if request("thispage")<>empty then thispage = Cint(request("thispage"))
	if request("mode")="Del" then
        IDs=request("ID")
		ID=split(IDs,",")
        for i=0 to ubound(ID)
            sql="delete from feedbackinfo where ID="&ID(i)
            conn.execute(sql)
        next
    end if
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
	document.Pageform.action="?thispage="+page;
	document.Pageform.submit();
}

function allSelected(){
    var els = document.forms[0].elements;
    for(var i = 0;i < els.length;i++){
        if (els[i].type == "checkbox"){
            els[i].checked = true;
        }
    }
}
function reverse(){
    var els = document.forms[0].elements;
    for(var i = 0;i < els.length;i++){
        if (els[i].type == "checkbox"){
            els[i].checked = !els[i].checked;
        }
    }
}
function checkform(mode){
    if(mode=="Del"){
        var canSele = false;
        var els = document.forms[0].elements;
        for(var i = 0;i < els.length;i++){
            if (els[i].type == "checkbox" && els[i].checked){
                canSele =true;
                break;
            }
        }
        if (!canSele){
            alert("请选择一条记录");
            return;
        }
        document.all("mode").value=mode;
        FrmNews.submit();
    }
}
</SCRIPT>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" >
<table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
  <form name="FrmNews" method="post" action="">
  <tr>
    <td width="100%">
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td bgcolor="#0C89A7"  valign="middle" >
            <p class="unnamed1" align="center">反 馈 信 息 管 理 </td>

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
                                  <td class="cpx12black" height=35>&nbsp;主题： 
                                    <input name="subject" size=25 value="<%=subject%>" class="text1"> 
                                    <input type=hidden name=byMode value=""> <input type=hidden name=mode> 
                                    &nbsp; </td>
                                  <td height=35 colspan="2" class="cpx12black">&nbsp;Email： 
                                    <input name="Email" size=25 value="<%=Email%>" class="text1"> 
                                    &nbsp; </td>
                                  <td class="cpx12black" height=35>
								   类　型： 
                              <SELECT name=cateid>
							  	<OPTION value="" selected></OPTION>
                                <OPTION value=1>产品投诉</OPTION>
                                <OPTION value=2>服务投诉</OPTION>
                                <OPTION value=3>给公司的建议</OPTION>
                                <OPTION value=4>购买及合作意向</OPTION>
                              </SELECT>
								  <a href="javascript:submitForm('byCate')" class="cpx12black"><img src="../images/button_search.gif" alt="查询" width="33" height="19" border="0" align="absmiddle"></a> </td>
                                </tr>
                              </table>
                           </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                &nbsp;&nbsp;
<table border="0" cellspacing="8" cellpadding="0" width="100%">
<tr>
                      <td align="right"> <a href="#" onClick="allSelected();return false" class="cpx12black">全选</a>&nbsp;|&nbsp; 
                        <a href="#" onClick="reverse();return false;" class="cpx12black">反向全选</a>&nbsp; 
                        <a href="#" onClick="checkform('Del')"><img src="../images/button_del.gif" border=0></a>&nbsp; 
                      </td>
                    </tr>                  <tr>
                    <td width="100%" bgcolor="#646464" colspan="2">
                      <table border="0" width="100%" cellpadding="3" cellspacing="1">
                        <tr bgcolor="#C8C8C8" align=center>
                          <td width="40" class="cpx12black" align=center>序号</td>
                          <td width="60" class="cpx12black" align=center>主题</td>
                          <td width="160" class="cpx12black" align=center>Email</td>
                          <td width="140" class="cpx12black" align=center>电话</td>
                          <td width="60" class="cpx12black" align=center>类型</td>
                          <td width="160" class="cpx12black" align=center>来自</td>
                          <td width="60" class="cpx12black" align=center>删除</td>
                        </tr>
<%
'页面显示
	set rs=server.CreateObject ("adodb.recordset") 
	sql="select * from feedbackinfo where 1=1"
	if subject<>"" then sql=sql & " and subject like '%" & subject & "%'"
	if Email<>"" then sql=sql & " and Email like '%" & Email & "%'"
	if cateid<>"" then sql=sql & " and cateid = " & cateid
	sql=sql & " order by modified desc"
	rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=20	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			Email=RS("Email")
			subject=RS("subject")
			cateID=rs("cateID")
			telephone=rs("telephone")
			fromwhere=rs("telephone")
			ID=rs("ID")
%>
<tr bgcolor="#FFFFFF" align=left>
  <td width="121" class="cpx12black">
    <div align="center"><%=i%></div>
  </td>
  <td width="288">
    <a href="feedbackView.asp?Mode=EditInfo&ID=<%=ID%>" class="cpx12black">
    <%=subject%></a>
  </td>
  <td width="121" class="cpx12black">
    <div align="center"><%=EMAIL%></div>
  </td>
  <td width="100" class="cpx12black">
    <div align="center"><%=telephone%></div>
  </td>
 <% 
 if cateid=1 then
 	catename="产品投诉"
 elseif cateid=2 then
 	catename="服务投诉"
 elseif cateid=2 then
 	catename="给公司的建议"
 elseif cateid=2 then
 	catename="购买及合作意向"
 end if
  %>
  <td width="182" class="cpx12black">
    <div align="center"><%=catename %></div>
  </td>
  <td width="144" class="cpx12black">
    <div align="center"><%=fromwhere %></div>
  </td>
  <td width="60" align=center>
    <input type="checkbox" name="ID" value="<%=ID%>">
  </td>
</tr>
<%
	 rs.movenext
     next
end if
%>
                      </table>
                    </td>
                  </tr></form>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  				<form name="Pageform" method="post">
<input name="subject" type="hidden" value="<%= subject %>">
<input name="email" type="hidden" value="<%= email %>">
<input name="cateid" type="hidden" value="<%= cateid %>">
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