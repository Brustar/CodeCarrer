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
			leftprompt="生产制造"
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
		case "users"
			leftprompt="用户专区"
		case "CEOsign"
			leftprompt="CEO姓名、签名"
	 end select 
	   %>
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
    <td width="164" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><a href="index.asp"><img src="images/fengbiao_index.gif" width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="info.asp"><img src="images/fengbiao_00.gif" width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_hei.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=about"><font color="005D73">公司简介</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=CEOsign"><font color="005D73">管理团队</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=management"><font color="005D73">规模经营</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=manufacture"><font color="005D73">丰达工业园</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=technology"><font color="005D73">技术领先</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=Culture"><font color="005D73">企业文化</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=sale"><font color="005D73">营<q>销网络</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src="images/biao1.gif" width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="info.asp?field=tactic"><font color="005D73">品牌战略</font></a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="news.asp"><img src="images/fengbiao_1.gif" width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="mien.asp"><img src="images/fengbiao_2.gif" width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="sell.asp"><img src="images/fengbiao_3.gif" width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="job.asp"><img src="images/fengbiao_4.gif" width="164" height="30" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table></td>
    <td width="1" bgcolor="9C9A9C"><img src="images/blank.gif" width="1" height="1"></td>
    <td width="613" valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="images/d_tiao.gif">　　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="info.asp" class="a1">关于丰达</a> 
            <font color="0071BD">&gt;</font> <a href="info.asp?Field=<%= field %>"><%= leftprompt %></a></td>
          <td background="images/d_tiao.gif"><a href="#" class="a1">视频简介</a></td>
        </tr>
      </table>
      <br>
      <table width="100%" border="0" align="center" cellpadding="20" cellspacing="0">
        <tr>
          <td> <p><font color="#666666" class="fonthr-18"><%= gettextdata(field,"siteinit","1","1") %></font> </p>
            </td>
        </tr>
      </table>
</td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
