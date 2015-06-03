<% conn.close %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="1" bgcolor="CECFCE"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src=<%= Timg("images/bottom.gif") %> width="451" height="65" border="0" usemap="#Map"> 
      <map name="Map">
	  <fjtignoreurl>
<area shape="rect" coords="321,9,367,24" href="en/index.asp">
 		<area shape="rect" coords="321,9,367,24" href="http://fjt.51big5.com/gate/big5/www.chinaphotar.com/web'"/>
</fjtignoreurl>	  		
<% if instr(request.ServerVariables("REMOTE_ADDR"),"211.147.225.34")>0 then %>        
		<fjtignoreurl>
		<area shape="rect" coords="266,10,307,26" href="http://www.chinaphotar.com/web"/>
 		<area shape="rect" coords="266,10,307,26" href="http://fjt.51big5.com/gate/big5/www.chinaphotar.com/web'"/>
</fjtignoreurl>
<% Else %>
  <area shape="rect" coords="266,10,307,26" href="http://fjt.51big5.com/gate/big5/www.chinaphotar.com/web">
<% End If %>
      <area shape="rect" coords="136,9,186,26" href="contact.asp" target="_blank">
        <area shape="rect" coords="202,9,252,25" href="map.asp" target="_blank">
      </map></td>
  </tr>
</table>
