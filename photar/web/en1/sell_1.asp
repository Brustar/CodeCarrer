<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���Ƽ�</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
	   <% field=request("field")
	  if field=empty then field="promotion"
	 select case field
		case "promotion"
			leftprompt="�����"
		case "sale"
			leftprompt="Ӫ<q>������"
		case "salebook"
			leftprompt="�����ֲ�"
		case else
			leftprompt="�����"
	 end select 
	   %> 
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/sell.swf">
              <param name="quality" value="high">
              <param name="wmode" value="transparent">
              <param name="menu" value="false">
              <embed src="flash/sell.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent" menu="false"></embed></object></td>
        </tr>
      </table>
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
          <td><a href="sell.asp"><img src=<%=Timg("images/fengbiao_30.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr>
          <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F7F7F7" onMouseOver="bgColor = '#F6FFED'" onMouseOut="bgColor = '#F7F7F7'">
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td><a href="sell.asp?field=sale">Ӫ<q>���</a></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F7F7F7" onMouseOver="bgColor = '#F6FFED'" onMouseOut="bgColor = '#F7F7F7'"> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td><a href="producthandbook.asp">��Ʒ�ƹ�</a></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F7F7F7" onMouseOver="bgColor = '#F6FFED'" onMouseOut="bgColor = '#F7F7F7'"> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td><a href="sell.asp?field=build">Ʒ�ƽ���</a></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F7F7F7" onMouseOver="bgColor = '#F6FFED'" onMouseOut="bgColor = '#F7F7F7'"> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td><a href="sell.asp?field=salebook">�����ֲ�</a></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F7F7F7" onMouseOver="bgColor = '#F6FFED'" onMouseOut="bgColor = '#F7F7F7'"> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td> <a href="#">Ӫ<q>����̳</a></td>
              </tr>
            </table></td>
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
          <td height="36" background="images/d_tiao.gif">����<a href="index.asp" class="a1">��ҳ</a> 
            <font color="0071BD">&gt;</font> <a href="sell.asp" class="a1">���Ӫ<q>��</a> 
            <font color="0071BD">&gt;</font> <a href="sell.asp?Field=<%= field %>"><%= leftprompt %></a></td>
        </tr>
      </table>
      <br>
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><font color="005D73" class="font14"><strong><%= leftprompt %>:</strong></font></td>
        </tr>
      </table><br>

      <table width="599" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src=<%=Timg("images/info_top.gif")%> width="599" height="8"></td>
        </tr>
        <tr>
          <td background="images/info_d.gif"><div align="center">
<%= gettextdata(field,"siteinit","1","1") %>
            </div></td>
        </tr>
        <tr>
          <td><img src=<%=Timg("images/info_down.gif")%> width="599" height="8"></td>
        </tr>
      </table> <p>&nbsp;</p></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
