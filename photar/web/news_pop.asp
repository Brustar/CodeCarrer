<!--#include file="../include/StringParse.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="600" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr> 
    <td height="20" valign="bottom" bgcolor="004DBD"> <div align="center"><font color="#FFFFFF" class="font14"><strong><%= getdata("subject","newsinfo","id",request("id")) %></strong></font></div></td>
  </tr>
  <tr> 
    <td height="25"> 
      <% img=getdata("ImgURL","newsinfo","id",request("id")) %>
      <div align="center"><font color="#006699">
        <!-- [<%'= left(modified,instr(modified," ")-1) %>] -->
        </font></div></td>
  </tr>
  <tr> 
    <td class="fonthr-18"> 
      <% if img<>"$" then %>
      <img src="../uploadfiles/<%= img %>" align="left"> 
      <% End If %>
      <p><font color="#666666"><%= UnParseString(getTextData("content","newsinfo","id",request("id"))) %></font></p></td>
  </tr>
</table>
</td>
  </tr>
</table>
</body>
</html>
