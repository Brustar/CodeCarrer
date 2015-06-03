<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<% 
     mode=request("mode")
	 SiteName = getString(request("SiteName"))'标题
	 SiteLogo = getString(request("SiteLogo"))
	 ContactInfo = ParseString(request("Content"))
	  if session("language")=1 then 
	 	table="SiteInitEn"
	else
		table="SiteInit"
	end if
	 if mode <> empty then
	 	sql="update "&table&" set SiteName='"&SiteName&"',SiteLogo='"&SiteLogo&"',ContactInfo='"&ContactInfo&"'"
	 	conn.execute(sql)
	 end if
	 CloseConn()
	 txt="修改成功!"
	 URL="init.asp"
	 GoMsg txt,URL
 %>