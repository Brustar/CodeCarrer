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
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1024" height="200">
              <param name="movie" value="flash/about.swf">
              <embed src="flash/about.swf" width="1024" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
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
                <td colspan="3" background="images/xuxian_hei.gif" bgcolor="E7E7E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="30" colspan="3" bgcolor="E7E7E7">&nbsp;&nbsp;<strong>图片专区：</strong></td>
              </tr>
<% 
thispage=1
if request("thispage")<>empty then thispage = Cint(request("thispage"))
sql="select * from advertisement where ischeck=1 and english=0 and cateid=2 order by modified"
set rs=server.CreateObject ("adodb.recordset") 
rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=12	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
	if i mod 3=1 then 
 %>	
                 <tr><% End If %> 
                  <td bgcolor="E7E7E7"> <div align="center"> 
                      <table width="100" height="100" border="0" cellpadding="3" cellspacing="0" bgcolor="#CCCCCC">
                        <tr> 
                          <td><table width="100" height="100" border="0" cellpadding="1" cellspacing="0" bgcolor="#FFFFFF">
                              <tr> 
                                <td><div align="center"><a href="sell2_show.asp?id=<%= rs("id") %>"><img 
                                src="../uploadfiles/<%= rs("LogoURL") %>" width=100 height=100 hspace="1" vspace="1" border="0" alt="<%= rs("SiteName") %>"></a></div></td>
                              </tr>
                            </table></td>
                        </tr>
                      </table>
                      <table width="110" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td height="3"><img src="../images/spacer.gif" width="1" height="1"></td>
                        </tr>
                      </table>
                      <table width="110" border="0" cellpadding="0" cellspacing="0" bgcolor="#999999">
                        <tr> 
                          <td><table width="110" border="0" cellspacing="1" cellpadding="0">
                              <tr> 
                                <td height="25" valign="middle" bgcolor="#FFFFFF"> 
                                  <div align="center"><FONT size=-1><a href="sell2_show.asp?id=<%= rs("id") %>"><%= rs("SiteName") %></a></FONT></div></td>
                              </tr>
                            </table></td>
                        </tr>
                      </table> 
                    </div></td>             
			 <% if i mod 3=0 then %></tr>
<%	end if
i=i+1				
 rs.movenext
  next
end if
 %>					  
              <tr> 
                <td colspan="3" bgcolor="E7E7E7">&nbsp;</td>
              </tr>              <tr> 
                <td colspan="3" bgcolor="E7E7E7"><form name="Pageform" method="post">
<p align="right"><% If thispage>1 Then %> <a href="javascript:goPage(1)" class="a1">首页</a> 
        <a href="javascript:goPage(<%= thispage-1 %>)" class="a1">上一页</a> 
        <% Else %>
        首页 上一页 
        <% End If %> <% If thispage<rs.pagecount Then %> <a href="javascript:goPage(<%= thispage+1 %>)" class="a1">下一页</a> 
        <a href="javascript:goPage(<%= rs.pagecount %>)" class="a1">尾页</a> 
        <% Else %>
        下一页 尾页 
        <% End If %></p></form></td>
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
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<% rs.close %>
<!--#include file="bottom.asp"-->
</body>
</html>
