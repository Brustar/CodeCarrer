<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     SiteName = getString(request("SiteName"))'БъЬт
	 IsIndex=0
     URL = getString(request("URL"))
     sort=0
	 if request("sort")<>empty then sort = getString(request("sort"))	 
	 LogoURL = getString(request("LogoURL"))
	 Content = ParseString(request("Content"))
	 if request("IsIndex")<>empty then IsIndex=request("IsIndex")
	 ID=request("ID")
	 english=request("english")
	 cateid=request("cateid")
     mode=request("mode")
     if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then	
		sql="insert into Advertisement(SiteName,URL,sort,LogoURL,IsIndex,content,english,cateid) values('"&SiteName&"','"&URL&"',"&sort&",'"&LogoURL&"',"&IsIndex&",'"&content&"',"&english&","&cateid&")"		
	  elseif mode="Edit" then     
		sql="update Advertisement set SiteName='"&SiteName&"',URL='"&URL&"',sort="&sort&",LogoURL='"&LogoURL&"',IsIndex="&IsIndex&",content='"&content&"',cateid="&cateid&" where id="&ID
	  elseif mode="Del" then
	  	sql="delete Advertisement where id="& ID
      elseif mode="Pass" then
	  	sql="update Advertisement set ischeck=1 where id="& ID
      elseif mode="NotPass" then
	  	sql="update Advertisement set ischeck=0 where id="& ID
	  end if
	  'resend(sql)
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("AdvertisementList.asp")
%>

