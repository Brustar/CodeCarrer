<%
function getRight(moduleID)
	dim myCount,mySql,parentID,showID,cateID
	recordCount=0
	lengh=0
	parentID=request("parentID")
	showID=request("showID")
	myCount="select count(*) as counts from moduleinfo where parentid=" & moduleID
	set RsCount=conn.execute(myCount)
	if RsCount.eof then recordCount=RsCount("counts")
	closers(RsCount)
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
	mySql="select * from moduleinfo where parentid=" & moduleID
	set RsChild=conn.execute(mySql)
	while not RsChild.eof
		dim moduleName,isModule,flag,rightsID,groupString
		moduleName=RsChild("modulename")
		moduleID=RsChild("ID")
  		if isModule="0" then
    		img="../images/file.gif"
  		else
    		img="../images/filea.gif"
  		end if
  		groupString = moduleID
%>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="cpx12black">
                                    <table width="75%" border="0" cellspacing="0" cellpadding="0" height="5">
                                      <tr>
                                        <td></td>
                                      </tr>
                                    </table>
                  <img src="<%=img%>" width="27" height="13" align="absmiddle">
               <%if flag="1" and isModule="0" then%>
                  <a href="SysRightFunction.asp?moduleID=<%=moduleID%>&rightsID=<%=rightsID%>" class="cpx12black">
                                        <%=moduleName%>
                  </a>
                  <%else%>
                                        <%=moduleName%>
                  <%end if%>
                  <%if flag="1" then%>
                     <INPUT type="checkbox" name="RightID" value="<%=groupString%>" checked onclick="Do_It('<%=groupString%>')" <%=IsInArray(RightID,moduleID)%>>
                  <%else%>
                     <INPUT type="checkbox" name="RightID" value="<%=groupString%>" onclick="Do_It('<%=groupString%>')" <%=IsInArray(RightID,moduleID)%>>
                  <%end if%>

                <%
                 myCounts="select count(id) as counts from moduleinfo where parentid=" & moduleID
                 set count=conn.execute(myCounts)
                 if not count.eof then reCount=count("counts")
                 if reCount<>0 then getright(moduleID)
                %>
              </td>
                                      </tr>
                                    </table>


<%
	RsChild.movenext
wend
closeRs(RsChild)
if recordCount<>0 then
%>
       </td>
  </tr>
</table>
<%
end if
end function
%>