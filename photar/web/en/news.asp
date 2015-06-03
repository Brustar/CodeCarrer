<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=javascript>
function goPage(page){
	document.Pageform.action="News.asp?thispage="+page;
	document.Pageform.submit();
}
</SCRIPT>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
        <param name="movie" value="flash/news.swf">
        <param name="quality" value="high">
        <param name="wmode" value="transparent">
        <param name="menu" value="false">
        <embed src="flash/news.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent" menu="false"></embed></object> 
    </td>
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
          <td><a href="product.asp"><img src=<%=Timg("images/fengbiao_5.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><a href="news.asp"><img src=<%=Timg("images/fengbiao_10.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr>
          <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><font color="393939"><a href="news.asp">企业新闻</a></font></td>
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
                <td bgcolor="F7F7F7"><font color="393939"><a href="news.asp?cateid=2">产品新闻</a></font></td>
              </tr>
            </table></td>
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
          <td>&nbsp;</td>
        </tr>
      </table> </td>
    <td width="1" bgcolor="9C9A9C"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
    <td width="613" valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="images/d_tiao.gif">　　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="news.asp" class="a1">丰达新闻</a> 
            <font color="0071BD">&gt;</font> <a href="news.asp">企业新闻</a></td>
        </tr>
      </table>
      <br>
<% 
thispage=1
if request("thispage")<>empty then thispage = Cint(request("thispage"))
cateid=request("cateid")
if cateid=empty then cateid=1
set rs=server.CreateObject ("adodb.recordset") 
sql="select * from newsinfo where isCheck=1 and english=0 and cateid="&cateid&" order by modified desc"
 %>	 
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><font color="005D73" class="font14"><strong><%= getdata("catename","newscate","id",cateid) %>:</strong></font>
            <hr size="1"></td>
        </tr>
      </table>      
<% 
rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=8	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			subject=rs("subject")
			resource=rs("source")
			createDate=rs("modified")
			ID=rs("ID")
			ImgURL=rs("ImgURL")
			if isnull(ImgURL) or ImgURl=empty or ImgURL=null or len(ImgURL)=0 then ImgURL="images/example8.jpg"
 %><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="25%"><div align="center"><img src=<%=ImgURL%> width="80" height="80"></div></td>
          <td width="75%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="81%"><font color="217994"><%= subject %></font></td>
                <td width="19%"><font color="#FF3333"><%'= left(createDate,instr(createDate," ")-1) %></font></td>
              </tr>
            </table></font>
            <font color="#666666" class="fonthr-18"><br>
            　<%= upstring(rs("content"),100) %></font> 
            <p align="right"><font color="217994"><a href="news_show.asp?id=<%= id %>" class="a1">详细...</a>&nbsp;&nbsp;&nbsp;&nbsp;<br>
              </font></p></td>
        </tr>
        <tr bgcolor="#666666"> 
          <td height="1" colspan="2"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
		<tr> 
          <td height="10" colspan="2">&nbsp;</td>
        </tr>		
		</table>
<% 
	 rs.movenext
  next
end if
 %><form name="Pageform" method="post">
<input name="cateID" type="hidden" value="<%= cateID %>"><p align="right"><% If thispage>1 Then %> <a href="javascript:goPage(1)" class="a1">首页</a> 
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
</body>
</html>
<!--#include file="bottom.asp"-->
