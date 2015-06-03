 <% If thispage>1 Then %> 
<div align="center"><a href="javascript:goPage(1)">首页</a> <a href="javascript:goPage(<%= thispage-1 %>)">上一页</a> 
  <% Else %>
  首页 上一页 
  <% End If %>
  <% If thispage<rs.pagecount Then %>
  <a href="javascript:goPage(<%= thispage+1 %>)">下一页</a> 
  <a href="javascript:goPage(<%= rs.pagecount %>)">尾页</a> 
  <% Else %>
  下一页 尾页 
  <% End If %>
  <% If rs.recordcount>0 Then %>
  &nbsp;&nbsp; 总记录数:<font color="#FF0000"><%= rs.recordcount %></font> | 总页数:<font color="#FF0000"><%= rs.pagecount %></font> | 每页<font color="#FF0000"><%= rs.pagesize %></font>记录 | 转到第<input type=text size=2 name=thispage value=<%=thispage%>>页 
  <input type=button value="GO" onClick="goPage(thispage.value)">
  <% End If %>
</div>
