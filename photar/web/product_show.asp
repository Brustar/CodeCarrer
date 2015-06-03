<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="form1" method="post" action="index.asp">
  <tr>
    <td height="38" bgcolor="EFEBEF"><table width="778" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td width="310"> <div align="left"><img src=<%=Timg("images/pro.gif")%> width="108" height="34"></div></td>
            <td width="310"><div align="right"><img src=<%=Timg("images/search0.gif")%> width="22" height="17">&nbsp;产品查询：</div></td>
            <td width="100"> <input type="text" name="textfield" class="input0"> 
            </td>
            <td width="59"> <button type="submit" class="button-search"><img src=<%=Timg("images/search_button.gif")%> width="58" height="18"></button></td>
          </tr>
        </table></td>
  </tr></form>
</table> -->
<table width="778" height="155" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/produce.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
              <embed src="flash/produce.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
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
    <td width="145" valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
            &gt;<font color="0071BD">&nbsp; </font><a href="product.asp">产品中心</a> &gt;<font color="0071BD"> 
            传真机产品</font> </td>
        </tr>
      </table>
      <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><p align="center">&nbsp;</p>
            <p align="center"><img src="../uploadfiles/<%= getdata("productpicture","productinfo","id",request("id")) %>" width="300" height="200"><br>
              <br>
            </p></td>
        </tr>
        <tr>
          <td>产品型号：<%= getdata("model","productinfo","id",request("id")) %> 　　　 <br>
            产品说明： <%= UnParseString(gettextdata("content","productinfo","id",request("id"))) %></td>
        </tr>
      </table>
      <p>&nbsp;</p>
      </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
