<% 
CheckUser=session("UserName")
If CheckUser=empty or CheckUser=null or CheckUser="" Then %>
<script LANGUAGE=JAVASCRIPT>parent.location='Login.asp';</script>
<%end if%>