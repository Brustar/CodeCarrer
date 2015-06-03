<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
  dim parentID,rootID,NewsCateID,isNewsCate,mode,functions,NewsCateName,sql
  parentID=request("parentID")
  NewsCateID=request("NewsCateID")
  mode=request("mode") 
  english=request("english")
  if mode=empty then mode="0"  
  functions=getString(request("functions"))
  NewsCateName=getString(request("NewsCateName"))
  if NewsCateName =empty then NewsCateName=""  
  if functions=empty then functions=""
  if mode="New" then
  	sql="insert into NewsCate(CateName,parentID,english) values('" & NewsCateName & "'," & parentID & ","&english&")"
	conn.execute sql
	response.Redirect("NewsCateList.asp")	
  elseif mode="Edit" and NewsCateID<>6 and NewsCateID<>4 and NewsCateID<>7 and NewsCateID<>8 then '不修改公司公告
  	sql="update NewsCate set CateName='" & NewsCateName & "',parentID=" & parentID & " where id=" & NewsCateID
	conn.execute sql
	response.Redirect("NewsCateList.asp")
  elseif mode="Del" and NewsCateID<>6 and NewsCateID<>4 and NewsCateID<>7 and NewsCateID<>8 then '不删除公司公告
  	sql="delete NewsCate where id=" & NewsCateID & "or parentid=" & NewsCateID
	conn.execute sql
	response.Redirect("NewsCateList.asp")
  elseif NewsCateID=6 or NewsCateID=4 or NewsCateID=7 or NewsCateID=8 then
	ShowMsg("此栏目为保护栏目！")
  end if
if NewsCateID <>empty and len(NewsCateID) > 0 then
    sql="select * from NewsCate where id=" & NewsCateID
    set record = conn.execute(sql)
    NewsCateName = record("CateName")
end if
%>
<HTML>
<HEAD>
<title>系统管理</title>
<SCRIPT LANGUAGE=javascript>
<!--
        function checkform(mode){
                if (mode=="Del")
                {
                        temp=window.confirm("你确定要删除此新闻栏目吗？");
                        if (temp)
                        {
                                form1.mode.value=mode;
                                form1.submit();
                        }
                }
                else
                {
                        if (form1.NewsCateName.value=="")
                        {
                                window.alert("输入不可为空！");
                        }
                        else{
                        form1.mode.value=mode;
                        form1.submit();
                        }
                }

        }   
//-->
</SCRIPT>

<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link rel="stylesheet" href="../include/style.css" type="text/css">
</HEAD>
<BODY leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" bgcolor="#0C89A7">
<form action="NewsCateEdit.asp" method=POST  name=form1>
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
    <tr>
      <td width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td bgcolor="#0C89A7" background="../images/oa_menu_from1_01.gif" valign="middle" width="200">
              <p class="unnamed1" align="center"><span class="unnamed1">新闻栏目设置</span> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td width="100%" bgcolor="#E6E6E6">
        <div align="center">
          <center>
            <table border=0 cellpadding=0 cellspacing=0 width="100%">
              <tr>
                <td colspan=3 bgcolor="#FFFFFF"> <img src="../images/oa_menu_from3_01.gif" width=218 height=1></td>
              </tr>
              <tr>
                <td width="7" background="../images/oa_menu_from3_02.gif">
                  <img border="0" src="../images/tls.gif" width="7" height="1"></td>
                <td bgcolor="#E6E6E6" width="100%" align="center">
                  <h3 align="center"><br>
                  </h3>

                  <table width="75%" border=1 cellspacing=0 cellpadding=5 bordercolordark="#ffffff" bordercolorlight="#484848" bgcolor="#FFFFFF">
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">栏目名称：</font></span> 
                        <input  name="NewsCateName" class="button1" value="<%=NewsCateName%>">
                      </td>
                    </tr>

<%
    if mode="NewNewsCate" then
%>
                    <input type="Hidden" name=parentID value="<%=request("parentID")%>">
<% else %>
                    <input type="Hidden" name=NewsCateID value="<%=record("ID")%>">
                    <input type="Hidden" name=parentID value="<%=record("PARENTID")%>">
<% end if %>
                  </table>
                  <p>

                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right">
                      <%if mode="NewNewsCate" then%>
                        <input type="button" value="新 增" name=button1 onClick="javascript:checkform('New')" class="button">
                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() " class="button">
                      <%else%>
                        <input type="button" value="修 改" name=button1 onClick="javascript:checkform('Edit')" class="button">
                        <input type="button" value="删 除" name=button1 onClick="javascript:checkform('Del')" class="button">
                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() " class="button">
                      <%end if%>
                        <input type="Hidden" name=mode>
						 <input type="Hidden" name=english value="<%= session("language") %>">
                      </td>
                    </tr>
                  </table>
            <h3 align="center"><br>
                  </h3>
                </td>
              </tr>
            </table>
          </center>
        </div>
      </td>
    </tr>
  </table>
</form>
</BODY>
</HTML>
<% closeConn() %>