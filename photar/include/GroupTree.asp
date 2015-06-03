<%
function getGroup(parentID)
	dim myCount,mySql,cateID
	recordCount=0
	lengh=0
	myCount="select count(*) as counts from groupinfo where parentid=" & parentID
	Set RsCount=conn.execute(myCount)
	if not RsCount.eof then recordCount=RsCount("counts")
	closeRS(RsCount)
	lengh=7+23*recordCount
	if recordCount<>0 then
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr height="<%=lengh%>">
    <td width="18">&nbsp;</td>
    <td background="../images/line_bg.gif" width="1" valign="bottom"></td>
    <td>
<%
end if
mySql="select * from groupinfo where parentID=" & parentID
Set RsChild=conn.execute(mySql)
while not RsChild.eof
	dim groupName,groupID,gradeID
	groupID=RsChild("id")
 	groupName=RsChild("groupName")
 	flag=getdata("groupName","groupinfo","parentid",groupID)
 if trim(flag)<>"" then
   img="../images/file.gif"
 else
   img="../images/filea.gif"
 end if 

%>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="cpx12black">
                                    <table width="75%" border="0" cellspacing="0" cellpadding="0" height="5">
                                      <tr>
                                        <td></td>
                                      </tr>
                                    </table>

                <img src="<%= img %>" width="27" height="13" align="absmiddle">
                <a HREF="RightList.asp?groupID=<%=groupID%>&parentID=<%=parentID%>" class="cpx12black"><%=groupName%></a> &nbsp;&nbsp;&nbsp; <a HREF="UserGroupEdit.asp?mode=NewGroup&parentID=<%=groupID%>&gradeID=<%=gradeID%>"><img SRC="../images/fileb.gif" border="0" alt="添加权限组" WIDTH="11" HEIGHT="13" align="absmiddle"></a>&nbsp; 
            <a HREF="UserGroupEdit.asp?groupID=<%=groupID%>" class="cpx12black"><img SRC="../images/pen.gif" border="0" alt="修改" height="13" align="absmiddle"></a>&nbsp; 
            <a HREF="UserList.asp?groupID=<%=groupID%>&groupName=<%=groupName%>"><img SRC="../images/man.gif" border="0" alt="用户列表" height="13" align="absmiddle"></a> 
            <%
                 dim myCounts
                 myCounts="select count(id) as counts from groupinfo where parentid='" & groupID & "'"
                 Set count=conn.execute(myCounts)
                 if not count.eof then reCount=count("counts")
                 if reCount<>0 then getGroup(groupID)
				 closeRS(Count)
%>
              </td>
                                      </tr>
                                    </table>


<%
	RsChild.movenext
wend
closeRS(RsChild)
if recordCount<>0 then
%>
       </td>
  </tr>
</table>
<%
end if
end function
%>