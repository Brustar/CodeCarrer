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
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/about.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
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
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="34" valign="top" background="images/title2.gif"> <table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="5%"><img src=<%=Timg("images/biao3.gif")%> width="26" height="26" hspace="5"></td>
          <td width="83%"><img src=<%=Timg("images/jz.gif")%> width="77" height="20"></td>
          <td width="3%" valign="bottom"><a href="index.asp"><img src=<%=Timg("images/gotop.gif")%> width="18" height="18" hspace="5" vspace="2" border="0"></a></td>
          <td width="9%" valign="bottom"><strong><a href="index.asp"><font color="397D94">回到首页</font></a></strong></td>
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
            <table width="573" border="0" align="right" cellpadding="0" cellspacing="0" bgcolor="E7E7E7">
              <tr> 
                <td colspan="3"><img src=<%=Timg("images/reporter_top1.gif")%> width="580" height="17"></td>
              </tr>
              <tr> 
                <td colspan="3" bgcolor="E7E7E7"><table width="560" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="25"><strong>媒体报道：</strong></td>
                          </tr>
                 <% 
sql="select * from newsinfo where isCheck=1 and english=0 and cateid=7 order by modified desc"
set rs=conn.execute(sql)
while not rs.eof
 %>
        <tr> 
          <td height="30">&nbsp;<img src=<%=Timg("images/biao0.gif")%> width="3" height="5"><font color="0071BD">&nbsp;<font color="397B90"><a href="news_show.asp?id=<%= id %>" class="a1"><%= subject %></a> (<%= left(createDate,instr(createDate," ")-1) %>)</font></font></td>
        </tr>
        <% rs.movenext
wend
 %>
                          <tr> 
                            <td height="20"><div align="right"><a href="news.asp?cateid=7" class="a1">更多&gt;&gt;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
                          </tr>
                        </table></td>
                      <td width="1" bgcolor="#999999"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                      <td width="195"> <div align="center"></div></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3" background="images/xuxian_hei.gif" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="30" colspan="3" bgcolor="E7E7E7">&nbsp;&nbsp;<strong>图片专区：</strong></td>
              </tr>
<% 
sql="select top 12 * from advertisement where ischeck=1 and english=0 order by modified"
set rs=conn.execute(sql)
i=0
while not rs.eof
	if i mod 3=0 then 
 %>				
                <tr><% End If %>
                  
                <td bgcolor="E7E7E7"><a href="img_show.asp?id=<%= rs("id") %>"><img src="../uploadfiles/<%= rs("LogoURL") %>" alt="<%= rs("SiteName") %>" width="140" height="98" hspace="12" vspace="12" border="0"></a></td>
                <% if i mod 3=2 then %></tr>
<%	end if
i=i+1				
 rs.movenext
wend
rs.close
 %>					  
              <tr> 
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3" align="right" bgcolor="E7E7E7"><a href="image.asp" class="a1">更多&gt;&gt;</a>&nbsp;&nbsp;</td>
              </tr>
              <tr> 
                <td bgcolor="E7E7E7">&nbsp;</td>
                <td bgcolor="E7E7E7">&nbsp;</td>
                <td bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
