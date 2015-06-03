<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<% field=request("field")
	  if field=empty then field="ContactInfo"
	 select case field
	 	case "ContactInfo"
			leftprompt="Contact Us"
		case "users"
			leftprompt="Compnay"
		case "SiteMap"
			leftprompt="National Sell"
		case "management"
			leftprompt="International Sell"
	 end select 
	   %>
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/about.swf">
              <embed src="flash/about.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
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
<table width="1004" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="images/d_tiao.gif">&nbsp;&nbsp;&nbsp;<a href="index.asp" class="a1">Index</a> 
            <font color="0071BD">&gt;</font> <%= leftprompt %></td>
        </tr>
      </table>
      <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="190" valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><div align="center"><img src=<%=Timg("images/index_left0.gif")%> width="177" height="53" border="0"></div></td>
              </tr>
              <tr> 
                <td><div align="center"><img src=<%=Timg("images/index_left1.gif")%> width="177" height="53" border="0"></div></td>
              </tr>
              <tr> 
                <td><div align="center"><img src=<%=Timg("images/index_left3.gif")%> width="177" height="53" border="0"></div></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table>
            <table width="177" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"><a href="sell2.asp"><img src=<%=Timg("images/flash_adv_up.gif")%> width="177" height="23" border="0"></a></div></td>
              </tr>
              <tr> 
                <td background="images/flash_adv_d.gif"><div align="center"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td height="6"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                      </tr>
                    </table>
                    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="140" height="140">
                      <param name="movie" value="flash/asd.swf">
                      <param name="quality" value="high">
                      <embed src="flash/asd.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="140" height="140"></embed></object>
                  </div></td>
              </tr>
              <tr> 
                <td><img src=<%=Timg("images/flash_adv_down.gif")%> width="177" height="15"></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> <div align="center"> </div></td>
              </tr>
            </table></td>
          <td width="1" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"> 
          </td>
          <td width="588" valign="top">
<p>&nbsp;</p><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><font color="005D73" class="font14"><strong><%= leftprompt %>:</strong></font> 
                  <p class="fonthr-18"><font color="#666666"><%= UnParseString(gettextdata(field,"siteiniten","1","1")) %></font></p>
                  <p class="fonthr-18"></p></td>
              </tr>
            </table>
            &nbsp; </td>
        </tr>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
