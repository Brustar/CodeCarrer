<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     JobName = getString(request("JobName"))'±êÌâ
     EducationalLevel = getString(request("EducationalLevel"))
     content = ParseString(request("content"))'ÄÚÈÝ
     specialty= getString(request("specialty"))
	 requireNumber= getString(request("requireNumber"))
     Salary=getString(request("Salary"))
	 ID=request("ID")
	 english=request("english") 
     mode=request("mode")
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then
		sql="insert into Jobinfo(JobName,EducationalLevel,requirement,specialty,Salary,requireNumbe,englishr) values('"
		sql=sql & JobName&"','"&EducationalLevel&"','"&content&"','"&specialty&"','"&Salary&"','"&requireNumber&"',"&english&")"		
	  elseif mode="Edit" then     
		sql="update Jobinfo set JobName='"&JobName&"',EducationalLevel='"&EducationalLevel&"',requirement='"&content&"',specialty='"
		sql=sql & specialty&"',Salary='"&Salary&"',requireNumber='"&requireNumber&"' where id="&ID
	  elseif mode="Del" then
	  	sql="delete Jobinfo where id="& ID
	  end if
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("JobList.asp")
%>

