<!--#include file="../include/database.asp"-->
<link href="index.css" rel="stylesheet" type="text/css">
<TABLE WIDTH=105 BORDER=0 CELLPADDING=0 CELLSPACING=0><TR>
<TD><table width="210" border="0" align="center" cellpadding="0" cellspacing="0"><tr>
<td><img src=<%=Timg("images/right_up.gif")%> width="210" height="57"></td>
</tr>
<tr><td background="images/right_middle.gif"><table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr> 
<td colspan="2"><div align="center"><img src=<%=Timg("images/right_news.gif")%> width="84" height="19"></div></td>
</tr>
<tr> 
<td height="5" colspan="2"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
</tr>
<% 
sql="select top 6 id,subject from newsinfo where isCheck=1 and english=0 and cateid=3 order by modified desc"
set rs=conn.execute(sql)
while not rs.eof
	rid=rs("id")
	rsubject=rs("subject")
 %>
<tr> 
<td width="13%" height="25" valign="bottom"> <div align="left"><img src=<%=Timg("images/right_leaf.gif")%> width="20" height="18"></div></td>
<td width="87%" valign="bottom">&gt;&gt; <a href="news_show.asp?id=<%= rid %>" target="_blank"><font color="00515A"><%= rsubject %></font></a></td>
</tr>
<tr> 
<td height="1" colspan="2" background="images/right_d.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
</tr>
<% 
	rs.movenext
wend
rs.close
 %>
 </table></td></tr>
 <tr>
<td><img src=<%=Timg("images/right_down.gif")%> width="210" height="18"></td>
</tr>
</table></TD></TR></TABLE>