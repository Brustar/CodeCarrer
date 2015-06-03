<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     SiteName = getString(request("SiteName"))'БъЬт
	 IsIndex=0
     URL = getString(request("URL"))
     sort = getString(request("sort"))
	 if trim(sort)="" then sort=0
	 LogoURL = getString(request("LogoURL"))
	 if request("IsIndex")<>empty then IsIndex=request("IsIndex")
	 ID=request("ID")
     mode=request("mode")
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then	
		sql="insert into FriendSiteinfo(SiteName,URL,sort,LogoURL,IsIndex) values('"&SiteName&"','"&URL&"',"&sort&",'"&LogoURL&"',"&IsIndex&")"		
	  elseif mode="Edit" then     
		sql="update FriendSiteinfo set SiteName='"&SiteName&"',URL='"&URL&"',sort="&sort&",LogoURL='"&LogoURL&"',IsIndex="&IsIndex&" where id="&ID
	  elseif mode="Del" then
	  	sql="delete FriendSiteinfo where id="& ID
      elseif mode="Pass" then
	  	sql="update FriendSiteinfo set ischeck=1 where id="& ID
      elseif mode="NotPass" then
	  	sql="update FriendSiteinfo set ischeck=0 where id="& ID
	  end if
	  'resend(sql)
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("FriendSiteList.asp")
%>

