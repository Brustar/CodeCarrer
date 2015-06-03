<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ProductName = getString(request("ProductName"))'标题
     model = getString(request("model"))
     content = ParseString(request("content"))'内容
     ProductPicture= request("ProductPicture")
     CateID = request("CateID")'类别
	 CompanyID = request("CompanyID")
	 ID=request("ID")
	 mprice = getString(request("mprice"))
	 if not isnumeric(mprice) or request("mprice")=empty then mprice=0
	 uprice = getString(request("uprice"))
	 if not isnumeric(uprice) or request("uprice")=empty then uprice=0
	 english=request("english")
     mode=request("mode")
    if mode <> empty then
      '**************** Write SQL ******************
      if mode="New" then
		sql="insert into Productinfo(ProductName,model,content,ProductPicture,CateID,mprice,uprice,english) values('"
		sql=sql & ProductName&"','"&model&"','"&content&"','"&ProductPicture&"',"&CateID&","&mprice&","&uprice&","&english&")"		
	  elseif mode="Edit" then     
		sql="update Productinfo set ProductName='"&ProductName&"',model='"&model&"',content='"&content&"',ProductPicture='"
		sql=sql & ProductPicture&"',CateID="&CateID&",mprice="&mprice&",uprice="&uprice&" where id="&ID
	  elseif mode="Del" then
	  	sql="delete Productinfo where id="& ID
      elseif mode="Pass" then
	  	sql="update Productinfo set ischeck=1 where id="& ID
      elseif mode="NotPass" then
	  	sql="update Productinfo set ischeck=2 where id="& ID
	  elseif mode="Favorite" then
	  	sql="update Productinfo set isFavorite=1 where id="& ID
	  elseif mode="Commend" then
	  	sql="update Productinfo set isFavorite=1,isCommend=1 where id="& ID
	  elseif mode="Cancle" then
	  	sql="update Productinfo set isFavorite=0,isCommend=0 where id="& ID
	  end if
	  res sql
	  conn.execute(sql)
	end if
    CloseConn()
    response.Redirect("ProductList.asp")
%>