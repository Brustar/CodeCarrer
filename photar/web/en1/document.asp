<% field=request("field")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<table width="778" height="155" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="778" height="155">
              <param name="movie" value="flash/invest.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
              <embed src="flash/invest.swf" width="778" height="155" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1"><img src="images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="4" bgcolor="E7E3E7"><img src="images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1" bgcolor="C8C8C8"><img src="images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src="images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="34" background="images/title0.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="4%"><img src="images/biao2.gif" width="26" height="26" hspace="5"></td>
          <td width="83%"><img src="images/tzj.gif" width="77" height="20"></td>
          <td width="0%" valign="bottom"><a href="index.asp"><img src="images/gotop.gif" width="18" height="18" hspace="5" vspace="1" border="0"></a></td>
          <td width="13%" valign="bottom"><strong><a href="index.asp"><font color="397D94">回到首页</font></a></strong></td>
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
                <td width="1" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
                <td width="180" valign="top" bgcolor="E6F9FF">
<p>&nbsp;</p>
                  <p><br>
                  </p></td>
                <td width="1" background="images/xuxian_hei0.gif"><img src="images/blank.gif" width="1" height="1"></td>
                <td valign="top"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td height="30"><font color="397D94">董事长、总裁 <%= getdata("SiteName","siteinit","1","1") %> </font></td>
                    </tr>
                    <tr> 
                      <td height="25"><img src="images/invest_arrow.gif" width="11" height="10" hspace="4"><font color="397D94">档案</font></td>
                    </tr>
                    <tr> 
                      <td><img src="images/invest_iner_bg.gif" width="545" height="4"></td>
                    </tr>
                    <tr> 
                      <td class="fonthr-18"><img src="../uploadfiles/<%= getdata("sitelogo","siteinit","1","1") %>" width="67" height="83" hspace="8" align="left"><%= gettextdata(field,"siteinit","1","1") %>
                      </td>
                    </tr>
                    <tr> 
                      <td height="17">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><img src="images/invest_arrow.gif" width="11" height="10" hspace="4"><font color="397D94">总裁签名</font></td>
                    </tr>
                    <tr> 
                      <td><img src="images/invest_iner_bg.gif" width="545" height="4"></td>
                    </tr>
                    <tr> 
                      <td><%= gettextdata("CEOsign","siteinit","1","1") %></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>            
                  </table></td>
                <td width="1" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
            </table> </td>
        </tr>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
