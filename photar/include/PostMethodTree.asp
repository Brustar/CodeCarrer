<%
function getPostMethod(parentID)
dim myCount,mySql,cateID
recordCount=0
lengh=0
myCount="select count(*) as counts from PostMethod where parentid=" & parentID
set RsCount=conn.execute(myCount)
if not RsCount.eof then recordCount=RsCount("counts")
RsCount.close()
set RsCount=nothing
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
mySql="select * from PostMethod "
mySql=mySql + " where parentID=" & parentID
Set RsChild=conn.execute(mySql)
while not RsChild.eof
 dim img,rootID,isPostMethods
 PostMethodID=RsChild("id")
 PostMethodName=RsChild("Catename")
 parent=RsChild("parentid")
 if parent=0 then
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

             <img src="<%=img%>" width="27" height="13" align="absmiddle">
             <%if parent=0 then%>
                <a HREF="FunctionList.asp?PostMethodID=<%=PostMethodID%>" class="cpx12black"><%=PostMethodName%></a>
                <%else%>
                <%=PostMethodName%>
                <%end if%>
                &nbsp;
                <%if parent=0 then%>
                  <a HREF="PostMethodEdit.asp?mode=NewPostMethod&parentID=<%=PostMethodID%>"><img SRC="../images/a2.gif" border="0" alt="添加子模块" WIDTH="15" HEIGHT="13" align="absmiddle"></a>&nbsp;
                <%end if%>
                <a HREF="PostMethodEdit.asp?PostMethodID=<%=PostMethodID%>" class="cpx12black"><img SRC="../images/pen.gif" border="0" alt="修改" height="13" align="absmiddle"></a>
  				<a HREF="javascript:del(<%=PostMethodID%>)"><img SRC="../images/del.gif" border="0" alt="删除子模块" height="13" align="absmiddle"></a>&nbsp;
				<%
                 dim myCounts
                 myCounts="select count(id) as counts from PostMethod where parentid=" & PostMethodID
                 Set count=conn.execute(myCounts)
                 if not count.eof then reCount=count("counts")
                 if reCount <> 0 then getPostMethod(PostMethodID)
                 count.close()
				 set count=nothing
%>
              </td>
                                      </tr>
                                    </table>


<%
RsChild.movenext
wend
RsChild.close()
if recordCount<>0 then
%>
       </td>
  </tr>
</table>
<%
end if
end function
%>