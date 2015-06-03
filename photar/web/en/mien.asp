<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="index.css" rel="stylesheet" type="text/css">
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
<% field=request("field")
	  if field=empty then field="honor"
	 select case field
		case "honor"
			leftprompt="Photar Honour"
		case "visualize"
			leftprompt="Our Image"		
		case "publicAct"
			leftprompt="Public Activity"
		case "JobStratagem"
			leftprompt="Song Of Photar"
	 end select 
 %>
<table border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/mien.swf">  
              <embed src="flash/mien.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false"></embed></object></td>
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
            </table>
          </td>
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
            <a href="product.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di0.gif" style="cursor: hand;" onMouseOver="background='images/lan_di.gif'" onMouseOut="background='images/lan_di0.gif'">
<table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="news.asp" class="a7"><strong>Photar News</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><a href="mien.asp" class="a7"><strong><img src="images/biao7.gif" width="13" height="13" hspace="10" border="0">Photar 
            Image</strong></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="25" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="18" valign="bottom"><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="mien.asp?field=honor" class="a6">Photar Honour</a></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> 
            <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="mien.asp?field=visualize" class="a6">Our Image</a></td>
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
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><font color="393939"><a href="mien.asp?field=publicAct" class="a6">Public activity</a></font></td>
              </tr>
            </table></td>
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
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a><a href="mien.asp" class="a7"></a><a href="sell.asp" class="a7"></a><a href="invest.asp" class="a7"></a></td>
        </tr>
      </table></td>
    <td width="836" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="11" height="36" background="images/d_tiao.gif"><img src="images/yin_left0.gif" width="11" height="36"></td>
          <td width="740" background="images/d_tiao.gif">&nbsp;&nbsp;<a href="index.asp" class="a1">Index</a> 
            <font color="0071BD">&gt;</font> <a href="mien.asp" class="a1">Photar Image</a> 
            <font color="0071BD">&gt;</font> <a href="mien1.asp"></a><a href="mien.asp?Field=<%= field %>"><%= leftprompt %></a></td>
          <td width="85" background="images/d_tiao.gif">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="11" background="images/yin_left1.gif">&nbsp;</td>
          <td valign="top"><br>
            <table width="95%" border="0" align="center" cellpadding="8" cellspacing="0">
              <tr> 
                <td> <p class="fonthr-18"><font color="#666666"><%= UnParseString(gettextdata(field,"siteiniten","1","1")) %></font> 
                  </p>
                  <p class="fonthr-18">&nbsp; </p></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
