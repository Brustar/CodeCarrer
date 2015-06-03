<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<% 
     mode=request("mode")
	 secretary = getString(request("secretary"))'标题
	 secretaryPic = getString(request("secretaryPic"))
	 secretaryinfo = ParseString(request("secretaryinfo"))
	 secretaryMail = getString(request("secretaryMail"))
	  if session("language")=1 then 
	 	table="SiteInitEn"
	else
		table="SiteInit"
	end if
	 if mode <> empty then
	 	sql="update "&table&" set secretary='"&secretary&"',secretaryPic='"&secretaryPic&"',secretaryinfo='"&secretaryinfo&"',secretaryMail='"&secretaryMail&"'"
	 	conn.execute(sql)
	 end if
	 CloseConn()
	 txt="修改成功!"
	 URL="init.asp"
	 GoMsg txt,URL
 %>