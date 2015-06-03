<% field=request("field")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/invest.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
              <embed src="flash/invest.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="34" background="images/title0.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%"><img src=<%=Timg("images/biao2.gif")%> width="26" height="26" hspace="5"></td>
          <td width="92%"><img src=<%=Timg("images/tzj.gif")%> width="77" height="20"></td>
          <td width="1%">&nbsp;</td>
          <td width="1%">&nbsp;</td>
          <td width="1%">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" valign="top"><table width="778" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="1" bgcolor="#CCCCCC"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                <td width="180" valign="top" bgcolor="E6F9FF">
<p><br>
                    　　·<a href="document.asp?field=<%= field %>">档案</a><br>
                    <br>
                    　　·<a href="news.asp?cateid=7">媒体报道</a><br>
                  </p>
                  <p>&nbsp;</p>
                  <p><br>
                  </p></td>
                <td width="1" background="images/xuxian_hei0.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                <td valign="top"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td height="30"><font color="397D94">董事长、总裁 <%= getdata("SiteName","siteinit","1","1") %> </font></td>
                    </tr>
                    <tr> 
                      <td height="25"><img src=<%=Timg("images/invest_arrow.gif")%> width="11" height="10" hspace="4"><font color="397D94">档案</font></td>
                    </tr>
                    <tr> 
                      <td><img src=<%=Timg("images/invest_iner_bg.gif")%> width="545" height="4"></td>
                    </tr>
                    <tr> 
                      <td class="fonthr-18"><img src="../uploadfiles/<%= getdata("sitelogo","siteinit","1","1") %>" width="67" height="83" hspace="8" align="left"><%= gettextdata(field,"siteinit","1","1") %>
                      </td>
                    </tr>
                    <tr> 
                      <td height="17">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><img src=<%=Timg("images/invest_arrow.gif")%> width="11" height="10" hspace="4"><font color="397D94">总裁签名</font></td>
                    </tr>
                    <tr> 
                      <td><img src=<%=Timg("images/invest_iner_bg.gif")%> width="545" height="4"></td>
                    </tr>
                    <tr> 
                      <td><%= gettextdata("CEOsign","siteinit","1","1") %></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>            
                  </table></td>
                <td width="1" bgcolor="#CCCCCC"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
            </table> </td>
        </tr>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
