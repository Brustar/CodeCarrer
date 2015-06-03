<%
function getTree(moduleID,childName)
dim groupID,sql
groupID=session("groupID")
if session("grade")=1 then '超级管理员
	sql="select * from Moduleinfo where parentID=" & moduleID
else
	sql="select * from Moduleinfo where parentID=" & moduleID & " and id in("&rightid&")"
end if
Set rsChild=conn.execute(sql)
%>
<div class=child id=<%=childName%>>
  <table border="0" cellpadding="0" cellspacing="0"  width=100%>
   <tr><td>
   <%
	 h = 0
     while not rsChild.eof
                h=h+1
               dim moduleName,gFunctions,functions,rightsID,isModule
               moduleName=rsChild("modulename")
			   parentid=rsChild("parentid")
               URL=rsChild("URL")
               moduleID=rsChild("ID")
				if parentid=0 then
					functions=""
				else
					functions=URL
				end if

               dim parentName,parent,childName1
               parentName="KB" &h&"Parent"
               parent="KB"&h
               childName1="KB"&h&"Child"
				if parentid=0 then
%>
             <div class=parent id=<%=parentName%>>
             <a href="#" onClick="expandIt('<%=parent%>'); return false" >
             <table width="100%" cellpadding="0" cellspacing="0" border="0" height="19">
               <tr>
                  <td height="19" width="143" background="../images/new_bu_3.gif" class="cpx12black" valign="middle" align="left">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                     <tr>
                       <td class="shadow1" align="left" height="19">&nbsp;&nbsp;&nbsp;&nbsp;<%=moduleName%></td>
                     </tr>
                   </table>
                   </td>

               </tr>
             </table>
             </a></div>
<% 
getTree moduleID,childName
else 
%>
              <tr>
                  <td height="19" background="../images/new_bu_3.gif" width="143" align="left">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="19">
                      <tr>
                        <td class="shadow2" align="left" height="19"><a href="<%=functions%>" class="cpx12black" target=mainright >&nbsp;&nbsp;&nbsp;&nbsp;<%=moduleName%></a></td>
                      </tr>
                   </table>
                   </td>

               </tr>
<% end if
	rsChild.movenext
wend
    rsChild.close()
	set rsChild=nothing
          %>

</td></tr>
</table>
</div>
<% End function %>