<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
	   <% field=request("field")
	  if field=empty then field="promotion"
	 select case field
		case "promotion"
			leftprompt="促销活动"
		case "sale"
			leftprompt="营<q>销网络"
		case "salebook"
			leftprompt="促销手册"
		case else
			leftprompt="促销活动"
	 end select 
	   %>
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td)%> 
      <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/sell.swf">
              <param name="quality" value="high">
              <param name="wmode" value="transparent">
              <param name="menu" value="false">
              <embed src="flash/sell.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent" menu="false"></embed></object></td>
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
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="sell.asp?field=sale">营<q>销活动</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="producthandbook.asp">产品推广</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="sell.asp?field=build">品牌建设</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"><a href="sell.asp?field=salebook">促销手册</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="35"><img src=<%=Timg("images/biao1.gif")%> width="35" height="22"></td>
                <td bgcolor="F7F7F7"> <a href="sell.asp?field=bbs">营<q>销论坛</a></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td><a href="job.asp"><img src=<%=Timg("images/fengbiao_4.gif")%> width="164" height="30" border="0"></a></td>
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
          <td height="36" background="images/d_tiao.gif">　　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="sell.asp" class="a1">丰达营<q>销</a> 
            <font color="0071BD">&gt;</font> 产品宣传册</td>
        </tr>
      </table>
      <br>
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><font color="005D73" class="font14"><strong>产品宣传册:</strong></font></td>
        </tr>
      </table><br>
      <table width="599" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src=<%=Timg("images/info_top.gif")%> width="599" height="8"></td>
        </tr>
        <tr> 
          <td background="images/info_d.gif"><div align="center"> 
              <TABLE cellSpacing=0 cellPadding=4 width="99%" align=center 
border=0>
                <TBODY>
                  <TR> 
                    <TD width="29%" height=119 rowSpan=2> <DIV align=center><IMG alt="产品图" 
                  width=120 
                  height=80 border=0></DIV></TD>
                    <TD class=td1 align=left width="55%" height=30><A class=td2 
                  href="http://china.samsung.com.cn/news/view_news.asp?id=8035&amp;sm=menu1&amp;tp=news_qy"><font color="005D73"><strong>传真机：</strong>(资料名称</font></A><font color="005D73">)</font></TD>
                    <TD class=td2 align=right width="16%" height=30> <DIV align=center><font color="#999999">(2005-09-19)</font></DIV></TD>
                  </TR>
                  <TR> 
                    <TD class="fonthr-18" vAlign=top colSpan=2 height=75>　　内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="80%" height="30"><div align="center"><img src=<%=Timg("images/list.gif")%> width="9" height="17">&nbsp;<a href="#" class="a1">资料下载地址</a></div></td>
                          <td width="20%">详细内容...</td>
                        </tr>
                      </table></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </div></td>
        </tr>
        <tr> 
          <td><img src=<%=Timg("images/info_down.gif")%> width="599" height="8"></td>
        </tr>
      </table>
      <br>
      <table width="599" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src=<%=Timg("images/info_top.gif")%> width="599" height="8"></td>
        </tr>
        <tr> 
          <td background="images/info_d.gif"><div align="center"> 
              <TABLE cellSpacing=0 cellPadding=4 width="99%" align=center 
border=0>
                <TBODY>
                  <TR> 
                    <TD width="29%" height=119 rowSpan=2> <DIV align=center><IMG alt="产品图" 
                  width=120 
                  height=80 border=0></DIV></TD>
                    <TD class=td1 align=left width="55%" height=30><A class=td2 
                  href="http://china.samsung.com.cn/news/view_news.asp?id=8035&amp;sm=menu1&amp;tp=news_qy"><font color="005D73"><strong>传真机：</strong>(资料名称</font></A><font color="005D73">)</font></TD>
                    <TD class=td2 align=right width="16%" height=30> <DIV align=center><font color="#999999">(2005-09-19)</font></DIV></TD>
                  </TR>
                  <TR> 
                    <TD class="fonthr-18" vAlign=top colSpan=2 height=75>　　内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="80%" height="30"><div align="center"><img src=<%=Timg("images/list.gif")%> width="9" height="17">&nbsp;<a href="#" class="a1">资料下载地址</a></div></td>
                          <td width="20%">详细内容...</td>
                        </tr>
                      </table></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </div></td>
        </tr>
        <tr> 
          <td><img src=<%=Timg("images/info_down.gif")%> width="599" height="8"></td>
        </tr>
      </table>
      <br>
      <table width="599" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src=<%=Timg("images/info_top.gif")%> width="599" height="8"></td>
        </tr>
        <tr> 
          <td background="images/info_d.gif"><div align="center"> 
              <TABLE cellSpacing=0 cellPadding=4 width="99%" align=center 
border=0>
                <TBODY>
                  <TR> 
                    <TD width="29%" height=119 rowSpan=2> <DIV align=center><IMG alt="产品图" 
                  width=120 
                  height=80 border=0></DIV></TD>
                    <TD class=td1 align=left width="55%" height=30><A class=td2 
                  href="http://china.samsung.com.cn/news/view_news.asp?id=8035&amp;sm=menu1&amp;tp=news_qy"><font color="005D73"><strong>传真机：</strong>(资料名称</font></A><font color="005D73">)</font></TD>
                    <TD class=td2 align=right width="16%" height=30> <DIV align=center><font color="#999999">(2005-09-19)</font></DIV></TD>
                  </TR>
                  <TR> 
                    <TD class="fonthr-18" vAlign=top colSpan=2 height=75>　　内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="80%" height="30"><div align="center"><img src=<%=Timg("images/list.gif")%> width="9" height="17">&nbsp;<a href="#" class="a1">资料下载地址</a></div></td>
                          <td width="20%">详细内容...</td>
                        </tr>
                      </table></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </div></td>
        </tr>
        <tr> 
          <td><img src=<%=Timg("images/info_down.gif")%> width="599" height="8"></td>
        </tr>
      </table>
      <br>
      <table width="599" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src=<%=Timg("images/info_top.gif")%> width="599" height="8"></td>
        </tr>
        <tr> 
          <td background="images/info_d.gif"><div align="center"> 
              <TABLE cellSpacing=0 cellPadding=4 width="99%" align=center 
border=0>
                <TBODY>
                  <TR> 
                    <TD width="29%" height=119 rowSpan=2> <DIV align=center><IMG alt="产品图" 
                  width=120 
                  height=80 border=0></DIV></TD>
                    <TD class=td1 align=left width="55%" height=30><A class=td2 
                  href="http://china.samsung.com.cn/news/view_news.asp?id=8035&amp;sm=menu1&amp;tp=news_qy"><font color="005D73"><strong>传真机：</strong>(资料名称</font></A><font color="005D73">)</font></TD>
                    <TD class=td2 align=right width="16%" height=30> <DIV align=center><font color="#999999">(2005-09-19)</font></DIV></TD>
                  </TR>
                  <TR> 
                    <TD class="fonthr-18" vAlign=top colSpan=2 height=75>　　内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="80%" height="30"><div align="center"><img src=<%=Timg("images/list.gif")%> width="9" height="17">&nbsp;<a href="#" class="a1">资料下载地址</a></div></td>
                          <td width="20%">详细内容...</td>
                        </tr>
                      </table></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </div></td>
        </tr>
        <tr> 
          <td><img src=<%=Timg("images/info_down.gif")%> width="599" height="8"></td>
        </tr>
      </table>
      <br> </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
