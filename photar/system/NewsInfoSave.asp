<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     title = request("txtTitle")'����
     author = getString(request("txtAuthor"))'����
     content = ParseString(request("content"))'����
     source = getString(request("txtResource"))
     cateid = request("CateID")'���
	 ID=request("ID")
	 english=request("english")
	 ImgUrl=request("ImgUrl")
	 happendate=request("happendate")
     mode=request("mode")
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then
		sql="insert into newsinfo(subject,author,content,source,cateid,english,ImgUrl,happendate) values('"
		sql=sql&title&"','"&author&"','"&content&"','"&source&"',"&cateid&","&english&",'"
		sql=sql & ImgUrl & "','" & happendate & "')"
		elseif mode="Edit" then     
		sql="update newsinfo set subject='"&title&"',author='"&author&"',content='"&content&"',source='"&source
		sql=sql&"',cateid="&cateid&",ImgUrl='"&ImgUrl&"',happendate='" & happendate & "' where id="&ID
		elseif mode="Del" then
	  	sql="delete newsinfo where id="& ID
		elseif mode="Pass" then
	  	sql="update newsinfo set ischeck=1 where id="& ID
		elseif mode="NotPass" then
	  	sql="update newsinfo set ischeck=2 where id="& ID
	  end if
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("NewsList.asp?rightsID="+rightsID + "&CompanyID=" + companyid)
%>

