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
              <param name="movie" value="flash/about.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
              <embed src="flash/about.swf" width="778" height="155" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
        </tr>
      </table></td>
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
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="34" valign="top" background="images/title2.gif"> 
      <table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="5%"><img src=<%=Timg("images/biao3.gif")%> width="26" height="26" hspace="5"></td>
          <td width="92%"><img src=<%=Timg("images/jz.gif")%> width="77" height="20"></td>
          <td width="1%">&nbsp;</td>
          <td width="1%">&nbsp;</td>
          <td width="1%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="200" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
      </table>
      <table width="196" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src=<%=Timg("images/reporter_top0.gif")%> width="196" height="12"></td>
        </tr>
        <tr>
          <td bgcolor="F0EBF1"><table width="170" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="25"><strong>栏目链接</strong></td>
              </tr>
              <tr>
                <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr>
                <td><br>
                  <a href="accessing.asp"><img src=<%=Timg("images/reporter_1.gif")%> width="170" height="81" border="0"></a></td>
              </tr>
              <tr>
                <td><a href="reporter.asp"><img src=<%=Timg("images/reporter_2.gif")%> width="170" height="62" border="0"></a></td>
              </tr>
              <tr>
                <td><a href="image.asp"><img src=<%=Timg("images/reporter_3.gif")%> width="170" height="63" border="0"></a></td>
              </tr>
            </table>
            <p><br>
            </p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp; </p></td>
        </tr>
        <tr>
          <td><img src=<%=Timg("images/reporter_down0.gif")%> width="196" height="12"></td>
        </tr>
      </table></td>
    <td valign="top"><table width="581" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top"><div align="right"><img src=<%=Timg("images/reporter.gif")%> width="573" height="147"></div></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="8"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
            </table>
            <table width="573" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="2"><img src=<%=Timg("images/reporter_top1.gif")%> width="580" height="17"></td>
              </tr>
              <tr> 
                <td colspan="2" background="images/xuxian_hei.gif" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="30" colspan="2" bgcolor="E7E7E7">&nbsp;&nbsp;<strong>图片专区：</strong></td>
              </tr>
			  <% id=request("id") %>
              <tr> 
                <td bgcolor="E7E7E7"><img src="../../uploadfiles/<%= getdata("LogoURL","advertisement","id",id) %>" alt="<%= getdata("SiteName","advertisement","id",id) %>" hspace="15" border="0"></td>
                <td bgcolor="E7E7E7">&nbsp;</td>
              </tr> <tr> 
                <td colspan="2" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2" bgcolor="E7E7E7">&nbsp;&nbsp;&nbsp;&nbsp;<%= gettextdata("content","advertisement","id",id) %></td>
              </tr>
             
              <tr> 
                <td colspan="2" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td height="17" colspan="2" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
