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
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/lan_di.gif','images/lan_di0.gif')">
<!--#include file="top.asp"-->
<% cateid=request("cateid")
'res(cateid)
	if cateid=empty or cateid=11 then 
		cateidfield="Company News"
	else 
		cateidfield="Latest products" 
	end if
 %>

<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
        <param name="movie" value="flash/news.swf">
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
<table width="1004" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="168" valign="top"> <table width="166" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="166" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="index.asp" class="a7"><strong>Index</strong></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="info.asp" class="a7"><strong>About Photar</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="product.asp" class="a7"><strong>Photar Products</strong></a></td>
              </tr>
            </table>
            </td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><a href="mien.asp" class="a7"><strong><img src="images/biao7.gif" width="13" height="13" hspace="10" border="0"></strong></a><a href="news.asp" class="a7"><strong>Photar 
            News</strong></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="25" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="18" valign="bottom"><img src="images/biao5.gif" width="3" height="5" hspace="5"><font color="393939"><a href="news.asp?cateid=11" class="a6">Company news</a></font></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><font color="393939"><a href="news.asp?cateid=13" class="a6">Latest products</a></font></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="mien.asp" class="a7"><strong>Photar Image</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a><a href="mien.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="sell.asp" class="a7"><strong>Photar Marketing</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a><a href="mien.asp" class="a7"></a><a href="sell.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="invest.asp" class="a7"><strong>Investor</strong></a><a href="sell.asp" class="a7"></a></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <td width="836" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="11" height="36" background="images/d_tiao.gif"><img src="images/yin_left0.gif" width="11" height="36"></td>
          <td width="740" background="images/d_tiao.gif">　<a href="index.asp" class="a1">Index</a> 
            <font color="0071BD">&gt;</font> <a href="news.asp" class="a1">Photar 
            News </a> <font color="0071BD">&gt;</font> <%= cateidfield %></td>
          <td width="85" background="images/d_tiao.gif">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="11" background="images/yin_left1.gif">&nbsp;</td>
          <td valign="top"><br> 
            <table width="90%" border="0" align="center" cellpadding="8" cellspacing="0">
              <tr> 
                <td> <p class="fonthr-18"> 
                    <% 
thispage=1
if request("thispage")<>empty then thispage = Cint(request("thispage"))
cateid=request("cateid")
if cateid=empty then cateid=1
set rs=server.CreateObject ("adodb.recordset") 
sql="select * from newsinfo where isCheck=1 and english=0 and cateid="&cateid&" and cateid<>3 order by modified desc"
 %>
                  </p>
                  <table width="80%" border="0" cellpadding="0" cellspacing="0">
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
 %>
                  <table width="85%" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td width="75%">
<div align="center">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td width="81%"><font color="217994"><%= subject %>&nbsp;&nbsp;</font><font color="#666666">(<%= time_array(createDate) %>)</font></td>
                              <td width="19%"><font color="#FF3333"> 
                                <%'= left(createDate,instr(createDate," ")-1) %>
                                </font></td>
                            </tr>
                          </table>
                          <div align="left"><font color="#666666" class="fonthr-18"><br>
                            　<%= cutImg(upstring(UnParseString(rs("content")),100)) %></font> </div>
                          <p align="right"><font color="217994"></font></p>
                        </div></td>
                      <td width="25%"> <p align="center"><font color="217994">&nbsp; 
                        <div align="center"> 
                          <div align="left"><img src=<%=ImgURL%> width="80" height="80"></div>
                        </div>
                        <p align="center"><a href="news_show.asp?id=<%= id %>" class="a1">...(Detail)</a>&nbsp;&nbsp;&nbsp;&nbsp;</p>
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
 %>
                  <form name="Pageform" method="post">
                    <input name="cateID" type="hidden" value="<%= cateID %>">
                    <p align="center"> 
                      <% If thispage>1 Then %>
                      <a href="javascript:goPage(1)" class="a1">首页</a> <a href="javascript:goPage(<%= thispage-1 %>)" class="a1">上一页</a> 
                      <% Else %>
                      首页 上一页 
                      <% End If %>
                      <% If thispage<rs.pagecount Then %>
                      <a href="javascript:goPage(<%= thispage+1 %>)" class="a1">下一页</a> 
                      <a href="javascript:goPage(<%= rs.pagecount %>)" class="a1">尾页</a> 
                      <% Else %>
                      下一页 尾页 
                      <% End If %>
                    </p>
                  </form>
                  <p class="fonthr-18">&nbsp; </p>
                  </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
<!--#include file="bottom.asp"-->
