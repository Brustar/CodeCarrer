<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     UserName = getString(request("UserName"))'标题
	 password= getString(request("password"))
     TrueName = getString(request("TrueName"))'作者
     Email = getString(request("Email"))'内容
     QQID = getString(request("QQID"))
	 telephone = getString(request("telephone"))
	 company = getString(request("company"))
     PorC = request("PorC")'类别
	 ID=request("ID")
     mode=request("mode")
	 txt="这个用户名已存在，请重新输入！"
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then
	  	sql="select id from Memberinfo where username='" & userName & "'"
    	Set rs1=conn.execute(sql)
    	if not rs1.eof then
        	closers(rs1)
        	ShowMsg(txt)
    	else 	
			sql="insert into Memberinfo(UserName,password,TrueName,Email,QQID,telephone,company,PorC) values('"&UserName&"','"&password&"','"&Truename&"','"&Email&"','"&QQID&"','"&telephone&"','"&company&"',"&PorC&")"		
	  	end if
	  elseif mode="Edit" then     
		sql="update Memberinfo set UserName='"&UserName&"',Truename='"&Truename&"',password='"&password&"',Email='"&Email&"',QQID='"&QQID&"',telephone='"&telephone&"',company='"&company&"',PorC="&PorC&" where id="&ID
	  elseif mode="Del" then
	  	sql="delete Memberinfo where id="& ID
      elseif mode="Pass" then
	  	sql="update Memberinfo set ischeck=1 where id="& ID
      elseif mode="NotPass" then
	  	sql="update Memberinfo set ischeck=0 where id="& ID
	  end if
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("MemberList.asp?rightsID="+rightsID + "&CompanyID=" + companyid)
%>

