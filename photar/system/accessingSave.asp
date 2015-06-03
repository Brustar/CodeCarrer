<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     accessingName = getString(request("accessingName"))'±êÌâ
     MediaName = getString(request("MediaName"))
	 telephone = getString(request("telephone"))
	  accessingDate = getString(request("accessingDate"))
	  Email = getString(request("Email"))
     content = ParseString(request("content"))'ÄÚÈÝ
	 ID=request("ID")	 
     mode=request("mode")
	 english=request("english")
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then
		sql="insert into accessing(accessingName,MediaName,content,Email,accessingDate,telephone,english) values('"
		sql=sql & accessingName&"','"&MediaName&"','"&content&"','"&Email&"','"&accessingDate&"','"&telephone&"',"&english&")"		
	  elseif mode="Edit" then     
		sql="update accessing set accessingName='"&accessingName&"',MediaName='"&MediaName&"',content='"&content
		sql=sql & "',Email='"&Email&"',telephone='"&telephone&"',accessingDate='"&accessingDate&"' where id="&ID
	  elseif mode="Del" then
	  	sql="delete accessing where id="& ID
	  elseif mode="Pass" then
	  	sql="update accessing set ischeck=1 where id="& ID
      elseif mode="NotPass" then
	  	sql="update accessing set ischeck=2 where id="& ID
	  end if
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("accessing.asp")
%>

