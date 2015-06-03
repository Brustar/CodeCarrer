<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ReferenceName = getString(request("ReferenceName"))'标题
     URL = getString(request("URL"))'作者
	 EnterprisePro = getString(request("EnterprisePro"))
     content = ParseString(request("content"))'内容
     Enterprise = getString(request("Enterprise"))
     cateid = request("CateID")'类别
	 ID=request("ID")
	 english=request("english")
     mode=request("mode")
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then
		sql="insert into Reference(ReferenceName,URL,content,cateid,english) values('"&ReferenceName&"','"&URL&"','"&content&"',"&cateid&","&english&")"		
	  elseif mode="Edit" then     
		sql="update Reference set ReferenceName='"&ReferenceName&"',URL='"&URL&"',content='"&content&"',cateid="&cateid&" where id="&ID
	  elseif mode="Del" then
	  	sql="delete Reference where id="& ID
      elseif mode="Pass" then
	  	sql="update Reference set ischeck=1 where id="& ID
      elseif mode="NotPass" then
	  	sql="update Reference set ischeck=2 where id="& ID
	  end if
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("ReferenceList.asp?rightsID="+rightsID + "&CompanyID=" + companyid)
%>

