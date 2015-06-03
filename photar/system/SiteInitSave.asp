<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<% 
     mode=request("mode")
	 types=request("types")
	 content = ParseString(request("Content"))
	 if session("language")=1 then 
	 	table="SiteInitEn"
	else
		table="SiteInit"
	end if
	 if mode <> empty then
	 	sql="update "&table&" set "&types&"='"&content&"'"
	 	conn.execute(sql)
	 end if
	 CloseConn()
	 txt="ÐÞ¸Ä³É¹¦!"
	 URL="SiteInit.asp?types=" & types
	 GoMsg txt,URL
 %>