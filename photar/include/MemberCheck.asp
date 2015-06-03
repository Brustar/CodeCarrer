<% 
CheckUser=session("UserID")
If CheckUser=empty or CheckUser=null or CheckUser="" Then %>
<script LANGUAGE=JAVASCRIPT>parent.location='index.asp';</script>
<%end if%>