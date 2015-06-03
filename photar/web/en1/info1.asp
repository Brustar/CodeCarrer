<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
	   <% field=request("field")
	  if field=empty then field="about"
	 select case field
	 	case "ContactInfo"
			leftprompt="联系我们"
		case "about"
			leftprompt="公司简介"
		case "manufacture"
			leftprompt="丰达工业园"
		case "Culture"
			leftprompt="企业文化"
		case "technology"
			leftprompt="技术领先"
		case "SiteMap"
			leftprompt="网站地图"
		case "management"
			leftprompt="规模经营"
		case "station"
			leftprompt="公司地位"
		case "JobStratagem"
			leftprompt="人才战略"
		case "honor"
			leftprompt="载誉丰达"
		case "visualize"
			leftprompt="形象展示"
		case "promotion"
			leftprompt="促销活动"
		case "sale"
			leftprompt="营<q>销网络"
			response.Redirect("info7.asp")
		case "market"
			leftprompt="上市公司形象"
		case "tactic"
			leftprompt="品牌战略"
		case "CEOsign"
			leftprompt="管理团队"
	 end select 
	   %>
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/about.swf"> 
              <embed src="flash/about.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="1" bgcolor="C8C8C8"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="1004" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="168" valign="top">
<table width="166" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="166" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="29" background="images/lan_di.gif"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><a href="index.asp" class="a7"><strong>丰达首页</strong></a></td>
              </tr>
            </table>
            
          </td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><img src="images/biao7.gif" width="13" height="13" hspace="10"><a href="info.asp" class="a7"><strong>关于丰达</strong></a></td>
        </tr>
        <tr> 
          <td height="29" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="18" valign="bottom"><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=about" class="a6">公司简介</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=CEOsign" class="a6">管理团队</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=management" class="a6">规模经营</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=manufacture" class="a6">丰达工业园</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=technology" class="a6">技术领先</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=Culture" class="a6">企业文化</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"> <table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=sale" class="a6">营<q>销网络</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei1.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="22" onMouseOver="bgColor = '#E7FAFF'" onMouseOut="bgColor = '#ffffff'"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src="images/biao5.gif" width="3" height="5" hspace="5"><a href="info.asp?field=tactic" class="a6">品牌战略</a></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="29" background="images/lan_di.gif"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="product.asp" class="a7"><strong>丰达产品</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="news.asp" class="a7"><strong>丰达新闻</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="mien.asp" class="a7"><strong>丰达风采</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a></a><a href="mien.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="sell.asp" class="a7"><strong>丰达营<q>销</strong></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a><a href="mien.asp" class="a7"></a><a href="sell.asp" class="a7"></a></td>
        </tr>
        <tr> 
          <td height="2"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="29" background="images/lan_di.gif"><table width="135" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="invest.asp" class="a7"><strong>投资者关系</strong></a><a href="sell.asp" class="a7"></a></td>
              </tr>
            </table>
            <a href="product.asp" class="a7"></a><a href="news.asp" class="a7"></a><a href="mien.asp" class="a7"></a><a href="sell.asp" class="a7"></a><a href="invest.asp" class="a7"></a></td>
        </tr>
      </table></td>
    <td width="836" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="11" height="36" background="images/d_tiao.gif"><img src="images/yin_left0.gif" width="11" height="36"></td>
          <td width="740" background="images/d_tiao.gif">　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="info.asp" class="a1">关于丰达</a> 
            <font color="0071BD">&gt;</font> <a href="info.asp?Field=<%= field %>"><%= leftprompt %></a></td>
          <td width="85" background="images/d_tiao.gif"><a href="flash/GB.wmv" class="a1">视频简介</a></td>
        </tr>
      </table> 
      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="11" background="images/yin_left1.gif">&nbsp;</td>
          <td valign="top"><br> <table width="95%" border="0" align="center" cellpadding="8" cellspacing="0">
              <tr> 
                <td> <p class="fonthr-18"><font color="#666666"><%= UnParseString(gettextdata(field,"siteinit","1","1")) %></font></p>
                  <p class="fonthr-18">&nbsp; </p></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
    </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
