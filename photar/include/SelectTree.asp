<% 
Private Function getSelectTree(tableName,tableField,selected,english)
	dim sql,temp,SelectValue,SelectName
	temp= ""		
	sql="select id,"& tableField & " from " & tableName & " where ParentID=0 and english=" & english
	set TreeRs=conn.execute (sql)
	while not TreeRs.eof
		SelectValue=TreeRs(0)
		SelectName=TreeRs(1)
		temp = "<option value ='"
		temp = temp & SelectValue
		temp = temp & "'"
		if selected<>"" then 
			if cint(SelectValue)=cint(selected) then temp = temp&" selected"
			temp = temp & ">"
			temp =temp&SelectName
			temp =temp& ("</option>\n")
		else
			temp = temp & ">"
			temp =temp & SelectName
			temp =temp & ("</option>")
		end if
		res(temp)
		getTree tableName,tableField,selected,SelectValue,""
		TreeRs.movenext	
	wend
	closeRs(TreeRs)	
End function 

Private Function getTree(tableName,tableField,selected,ParentID,nbsp)
	dim sql,temp,SelectValue,SelectName
	temp= ""	
	sql="select id,"& tableField & " from " & tableName & " where ParentID=" & ParentID
	set TreeRs=conn.execute (sql)
	while not TreeRs.eof
		nbsp = nbsp & "&nbsp;&nbsp;"
		SelectValue=TreeRs(0)
		SelectName=TreeRs(1)
		temp = "<option value ='"
		temp = temp & SelectValue
		temp = temp & "'"
		if selected<>"" then 
			if cint(SelectValue)=cint(selected) then temp = temp&" selected"
			temp = temp & ">" & nbsp 
			temp =temp&SelectName
			temp =temp& ("</option>\n")
		else
			temp = temp & ">" & nbsp 
			temp =temp&SelectName
			temp =temp& ("</option>")
		end if
		res(temp)
		getTree tableName,tableField,selected,SelectValue,nbsp
		TreeRs.movenext	
	wend
	nbsp = ""	
End function

function showTable(table,fieldName,Url)
	sql="select id,"&fieldName&" from "&table&" where isCheck=1 order by modified desc"
	set rs=conn.execute(sql)	
 %>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
<% do while not rs.eof %>
 <tr>
 <% for i=1 to 4 
 if rs.eof then exit for
 %> 
 <td height="18"><div align="left"><a href="<%= Url %>?id=<%= rs(0) %>" class="a2" title="<%= rs(1) %>"><%=upstring(rs(1),4) %></a></div></td>
 <% 
 rs.movenext
 next %>
 </tr>
<% loop 
closers(rs)
%>
</table>
 <% 
end function
%>