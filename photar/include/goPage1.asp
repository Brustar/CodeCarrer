 <% If thispage>1 Then %> 
<div align="center"><a href="javascript:goPage(1)">��ҳ</a> <a href="javascript:goPage(<%= thispage-1 %>)">��һҳ</a> 
  <% Else %>
  ��ҳ ��һҳ 
  <% End If %>
  <% If thispage<rs.pagecount Then %>
  <a href="javascript:goPage(<%= thispage+1 %>)">��һҳ</a> 
  <a href="javascript:goPage(<%= rs.pagecount %>)">βҳ</a> 
  <% Else %>
  ��һҳ βҳ 
  <% End If %>
  <% If rs.recordcount>0 Then %>
  &nbsp;&nbsp; �ܼ�¼��:<font color="#FF0000"><%= rs.recordcount %></font> | ��ҳ��:<font color="#FF0000"><%= rs.pagecount %></font> | ÿҳ<font color="#FF0000"><%= rs.pagesize %></font>��¼ | ת����<input type=text size=2 name=thispage value=<%=thispage%>>ҳ 
  <input type=button value="GO" onClick="goPage(thispage.value)">
  <% End If %>
</div>
