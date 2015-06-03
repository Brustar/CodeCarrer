<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
dim groupID,parentID,SelStr,UnSelStr,sql,rightID
groupID=request("groupID")
parentID=request("parentID")
rightID=request("rightID")
SelStr=request("SelStr")
UnSelStr=request("UnSelStr")
sql="update groupinfo set rightid='" & RightID & "' where id="& groupid
conn.execute sql
closeConn()
response.Redirect("UserGroupList.asp")
%>