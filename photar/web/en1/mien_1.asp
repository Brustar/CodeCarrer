<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���Ƽ�</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<% field=request("field")
	  if field=empty then field="honor"
	 select case field
		case "honor"
			leftprompt="�������"
		case "visualize"
			leftprompt="����չʾ"		
		case "publicAct"
			leftprompt="����"
	 end select 
 %>
<table width="1024" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="1024" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1024" height="200">
              <param name="movie" value="flash/mien.swf">  
              <embed src="flash/mien.swf" width="1024" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false"></embed></object></td>
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
          <td><a href="mien.asp"><img src=<%=Timg("images/fengbiao_20.gif")%> width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F7F7F7" onMouseOver="bgColor = '#F6FFED'" onMouseOut="bgColor = '#F7F7F7'"> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td><a href="mien.asp?field=honor">�������</a></td>
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
                <td><a href="mien.asp?field=visualize">����չʾ</a></td>
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
                <td><font color="393939"><a href="mien.asp?field=publicAct">����</a></font></td>
              </tr>
            </table></td>
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
      </table></td>
    <td width="1" bgcolor="9C9A9C"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
    <td width="613" valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="images/d_tiao.gif">����<a href="index.asp" class="a1">��ҳ</a> 
            <font color="0071BD">&gt;</font> <a href="mien.asp" class="a1">�����</a> <font color="0071BD">&gt;</font> 
            <a href="mien1.asp"></a><a href="mien.asp?Field=<%= field %>"><%= leftprompt %></a></td>
        </tr>
      </table>
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><font color="005D73" class="font14"><strong><br>
            <%= leftprompt %>:</strong></font> 
            <hr size="1"></td>
        </tr>
      </table>
       <table width="100%" border="0" cellspacing="0" cellpadding="8">
        <tr>
          <td> 
            <p class="fonthr-18"><font color="#666666"><%= UnParseString(gettextdata(field,"siteinit","1","1")) %></font>
            </p>
            <p class="fonthr-18">&nbsp; </p></td>
        </tr>
      </table>     
    </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
