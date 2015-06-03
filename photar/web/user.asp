<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="en/index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
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
    <td height="1"><img src="en/images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="4" bgcolor="E7E3E7"><img src="en/images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1" bgcolor="C8C8C8"><img src="en/images/blank.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="1004" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="en/images/d_tiao.gif">　　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="server.asp">用户专区</a></td>
        </tr>
      </table>
      <br>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="178" valign="top"> 
            <table width="168" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src=<%=Timg("images/server_left_top.gif")%> width="168" height="10"></td>
              </tr>
              <tr>
                <td bgcolor="CECECE"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="30"><strong>用户专区</strong></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"><img src="en/images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr>
                      <td>
<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="13%"><img src=<%=Timg("images/server_biao.gif")%> width="20" height="20"> 
                            </td>
                            <td width="87%"><a href="user.asp">资料下载</a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"><img src="en/images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr>
                      <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="13%"><img src=<%=Timg("images/server_biao.gif")%> width="20" height="20"> 
                            </td>
                            <td width="87%"><a href="server1.asp">服务网络</a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"><img src="en/images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr>
                      <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="13%"><img src=<%=Timg("images/server_biao.gif")%> width="20" height="20"> 
                            </td>
                            <td width="87%"><a href="server2.asp">客户反馈</a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"><img src="en/images/blank.gif" width="1" height="1"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src=<%=Timg("images/server_left_middle.gif")%> width="168" height="20"></td>
              </tr>
              <tr>
                <td bgcolor="EFEBEF"><div align="center"><img src=<%=Timg("images/example10.jpg")%> width="139" height="262"></div></td>
              </tr>
              <tr>
                <td><img src=<%=Timg("images/server_left_bottom.gif")%> width="168" height="10"></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
          <td width="826" valign="top"><img src=<%=Timg("images/server_lady.jpg")%> width="600" height="80"> 
            <table width="80%" border="0" cellpadding="10" cellspacing="0">
              <tr>
                <td height="60"><strong class="font14">资料下载</strong></td>
              </tr>
              <tr>
                <td><% 
thispage=1
if request("thispage")<>empty then thispage = Cint(request("thispage"))
set rs=server.CreateObject ("adodb.recordset") 
sql="select * from Reference where english=0 and ischeck=1 order by modified desc"
rs.open sql,conn,1,3
	if not rs.eof then
		rs.pagesize=6	
		rs.Absolutepage=thispage
		if thispage>rs.PageCount then thispage=rs.PageCount
   		for i=1 to rs.pagesize  
       		if rs.eof then exit for
			ReferenceName=rs("ReferenceName")
			cateName=getdata("cateName","ProductCate","id",rs("cateid"))
			pictrue=getdata("productpicture","productinfo","model",rs("ReferenceName"))			
			if pictrue<>empty then 
				pictrue=mid(pictrue,InStrRev(pictrue, "$")+1)
			else
				pictrue="20051122161456_705547.jpg"
			end if
			URL=rs("URL")
			modified=rs("modified")
			isCheck=rs("isCheck")
			ID=rs("ID")
			content=rs("content")
 %>	  
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
                    <TD width="29%" height=119 rowSpan=2> <DIV align=center><IMG src="../uploadfiles/<%= pictrue %>" alt="产品图" 
                  width=120 
                  height=80 border=0></DIV></TD>
                    <TD class=td1 align=left width="55%" height=30><A class=td2 
                  href="http://china.samsung.com.cn/news/view_news.asp?id=8035&amp;sm=menu1&amp;tp=news_qy"><font color="005D73"><strong><%= cateName %>：</strong>(<%= ReferenceName %></font></A><font color="005D73">)</font></TD>
                    <TD class=td2 align=right width="16%" height=30> <DIV align=center><font color="#999999">(<%= left(modified,instr(modified," ")-1) %>)</font></DIV></TD>
                  </TR>
                  <TR> 
                    <TD class="fonthr-18" vAlign=top colSpan=2 height=75>　　<%= content %>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="80%" height="30"><div align="right"><img src=<%=Timg("images/list.gif")%> width="9" height="17">&nbsp;<a href="../uploadfiles/<%= URL %>" class="a1">资料下载</a></div></td>
                          <td width="20%"><!-- <a href="detail.asp?id=<%= id %>">详细内容...</a> --></td>
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
<% 
	 rs.movenext
     next
end if
 %><form name="Pageform" method="post">
<input name="cateID" type="hidden" value="<%= cateID %>"><p align="right"><% If thispage>1 Then %> <a href="javascript:goPage(1)" class="a1">首页</a> 
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
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table> </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
