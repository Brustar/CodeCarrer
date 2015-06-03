<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->

<table height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td> <table width="1004" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
                    <param name="movie" value="flash/produce.swf">
                    <embed src="flash/produce.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
              </tr>
            </table></td>
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
    <td width="145" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="1" bgcolor="B5B6B5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="25"><a href="product1.asp?cateid=1"><img src=<%=Timg("images/pro_1.gif")%> width="114" height="17" border="0"></a></td>
        </tr>
        <tr> 
          <td height="1" bgcolor="B5B6B5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="25"><a href="product1.asp?cateid=3"><img src=<%=Timg("images/pro_3.gif")%> width="114" height="17" border="0"></a></td>
        </tr>
        <tr> 
          <td bgcolor="B5B6B5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="25"><a href="product1.asp?cateid=2"><img src=<%=Timg("images/pro_2.gif")%> width="114" height="17" border="0"></a></td>
        </tr>
        <tr> 
          <td bgcolor="B5B6B5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
        <tr> 
          <td height="25"><a href="product1.asp?cateid=4"><img src=<%=Timg("images/pro_4.gif")%> width="114" height="17" border="0"></a></td>
        </tr>
        <tr>
          <td bgcolor="B5B6B5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
      </table> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src=<%=Timg("images/example3.jpg")%> width="141" height="180"></td>
        </tr>
      </table></td>
    <td width="633" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" valign="bottom"><font color="0071BD">　　</font><a href="index.asp">首页</a> 
            &gt; <a href="product.asp" class="a1">产品中心</a></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><TABLE WIDTH=627 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
              <TR> 
                <TD COLSPAN=3> <IMG src=<%=Timg("images/flash_product_11.gif")%> WIDTH=627 HEIGHT=13 ALT=""></TD>
              </TR>
              <TR> 
                <TD> <IMG src=<%=Timg("images/flash_product_2.gif")%> WIDTH=18 HEIGHT=196 ALT=""></TD>
                <TD width="427" height="196" background="images/flash_product_3.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="62%"><div align="center"><a href="product_show.asp?id=<% =getdata("id","productinfo","isfavorite",1) %>"><img src="../uploadfiles/<% =getdata("productpicture","productinfo","isfavorite",1) %>" width="192" height="162" border="0"></a></div></td>
                      <td width="38%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="30" valign="bottom"><font color="#000000" class="font18"><strong>
                              <% '=getdata("productname","productinfo","isfavorite",1) %>
                              </strong></font></td>
                          </tr>
                          <tr> 
                            <td height="30"><font color="08459C"><strong class="font18">
                              <% '=getdata("model","productinfo","isfavorite",1) %>
                              </strong></font></td>
                          </tr>
                          <tr> 
                            <td><font color="#666666" class="fonthr-18">
                              <% '=upstring(UnParseString(gettextdata("content","productinfo","isfavorite",1)),200) %>
                              </font></td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                  </table>
                </TD>
                <TD> <IMG src=<%=Timg("images/flash_product_4.gif")%> ALT="" WIDTH=182 HEIGHT=196 border="0" usemap="#Map3"></TD>
              </TR>
            </TABLE>
            <map name="Map3">
              <area shape="rect" coords="46,55,138,77" href="product1.asp?cateid=3">
              <area shape="rect" coords="47,90,139,112" href="product1.asp?cateid=2">
              <area shape="rect" coords="47,126,139,148" href="product1.asp?cateid=4">
              <area shape="rect" coords="46,25,138,47" href="product1.asp?cateid=1">
            </map>
            <img src=<%=Timg("images/example4.jpg")%> width="627" height="115" border="0"></td>
        </tr>
      </table> 
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top">
<table width="145" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="3" bgcolor="#045A93"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="20" bgcolor="6B8AFF"><strong>&nbsp;&nbsp;<a href="product1.asp?cateid=1"><font color="#FFFFFF">传真机产品</font></a></strong></td>
              </tr>  <tr> 
                <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
<% 
sql="select top 8 id,catename from productcate where parentid=1"
set rs=conn.execute(sql)
while not rs.eof
 %>		 
              <tr> 
                <td height="18"><font color="FF6521">· </font><a href="product1.asp?cateid=<%= rs("id") %>" class="a2"><%= rs("catename") %></a></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
<% 
rs.movenext
wend
rs.close
 %>
            </table>
          </td>
          <td valign="top"> <table width="145" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="3" bgcolor="#045A93"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="20" bgcolor="6B8AFF"><strong>&nbsp;&nbsp;<a href="product1.asp?cateid=3"><font color="#FFFFFF">迷你音响</font></a></strong></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <% 
sql="select top 8 id,model from productinfo where ischeck=1 and cateid=3"
set rs=conn.execute(sql)
while not rs.eof
 %>		 
              <tr> 
                <td height="18"><font color="FF6521">· </font><a href="product_show.asp?id=<%= rs("id") %>" class="a2"><%= rs("model") %></a></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
<% 
rs.movenext
wend
rs.close
 %>
            </table></td>
          <td valign="top"> <table width="145" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="3" bgcolor="#045A93"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="20" bgcolor="6B8AFF"><strong>&nbsp;&nbsp;<a href="product1.asp?cateid=2"><font color="#FFFFFF">数码产品</font></a></strong></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <% 
sql="select top 8 id,model from productinfo where ischeck=1 and cateid=2"
set rs=conn.execute(sql)
while not rs.eof
 %>		 
              <tr> 
                <td height="18"><font color="FF6521">· </font><a href="product_show.asp?id=<%= rs("id") %>" class="a2"><%= rs("model") %></a></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
<% 
rs.movenext
wend
rs.close
 %>
            </table></td>
          <td valign="top"> <table width="145" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="3" bgcolor="#045A93"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="20" bgcolor="6B8AFF"><strong>&nbsp;&nbsp;<a href="product1.asp?cateid=4"><font color="#FFFFFF">电话机产品</font></a></strong></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <% 
sql="select top 8 id,model from productinfo where ischeck=1 and cateid=4"
set rs=conn.execute(sql)
while not rs.eof
 %>		 
              <tr> 
                <td height="18"><font color="FF6521">· </font><a href="product_show.asp?id=<%= rs("id") %>" class="a2"><%= rs("model") %></a></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_lan.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
<% 
rs.movenext
wend
rs.close
 %>
            </table> </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>

