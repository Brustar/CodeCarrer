<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
dim sql,mode,groupID,parentID,groupName,groupName_EN,gradeID
mode=request("mode")
if mode=empty then mode=""
groupID=request("groupID")
gradeID=request("gradeID")
if gradeID=empty then gradeID="1"
parentID=request("parentID")
groupName=getString(request("groupName"))
if groupName=empty then groupName=""
groupName_EN=getString(request("groupName_EN"))
if groupName_EN=empty then groupName_EN=""
if mode="New" then
	sql="insert into Groupinfo(groupName_EN,groupName,parentID) values('"&groupName_EN&"','"&groupName&"','"&parentID&"')"
	response.Write(sql)
	'response.End()
	conn.execute sql
    response.Redirect("UserGroupList.asp")
elseif mode="Edit" then
	sql="update Groupinfo set groupName_EN='"&groupName_EN&"',groupName='"&groupName&"',parentID='"&parentID&"' where id=" & groupID
	conn.execute sql
    response.Redirect("UserGroupList.asp")
elseif mode="Del" then
	sql="delete Groupinfo where id=" & groupID
	strsql="delete Groupinfo where parentid=" & groupID
	conn.execute sql
	conn.execute strsql
    response.Redirect("UserGroupList.asp")    
end if

    if groupID<>empty then
        sql="select * from groupinfo where id=" + groupID
		set record=conn.execute(sql)
		if not record.eof then
        	groupName = record("GROUPNAME")
        	groupName_EN = record("GROUPNAME_EN")
		end if
		closeRs(record)
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
                        temp=window.confirm("你确定要删除此权限组吗？")
                        if (temp)
                        {
                                form1.mode.value=mode;
                                form1.submit();
                        }
                }
                else
                {
                        if (form1.groupName.value=="" || form1.groupName_EN.value=="")
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

<meta http-equiv="Context-Language" content="zh-cn"><meta http-equiv="Content-Type" content="text/html charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
</HEAD>
<BODY leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" bgcolor="#0C89A7">
<form action="UserGroupEdit.asp" method=POST  name=form1>
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
    <tr>
      <td width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="200">
              <p class="unnamed1" align="center"><span class="unnamed1">系统权限组设置</span> 
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
                      <td align="center"><span class="fontpx12"><font color="#646464">权限组名称：</font></span>
                        <input  name="groupName"  class="button1" size="34" maxlength=10 value=<%=groupName%>>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">权限组英文名：</font></span>
                        <input name="groupName_EN" class="button1" size="34"  maxlength=20 value="<%=groupName_EN%>">&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                      </td>
                    </tr>
 <!--                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">网址：</font></span>
                        <input name="htmlUrl" value="<%'=htmlUrl%>" maxlength=100 class="button1" size="34" >
                        &nbsp;&nbsp;&nbsp;
                      </td>
                    </tr> -->
                    <input type="Hidden" name=groupID value="<%=groupID%>">
                    <input type="Hidden" name=parentID value="<%=parentID%>">
                    <input type="hidden" name=gradeID value="<%=gradeID%>">
                  </table>
                  <p>
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right">
                      <%if mode="NewGroup" then%>
                        <input type="button" value="新 增" name=button1 onClick="javascript:checkform('New')" class="button">
                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() " class="button">
                      <%else%>
                        <input type="button" value="修 改" name=button1 onClick="javascript:checkform('Edit')" class="button">
                        <input type="button" value="删 除" name=button1 onClick="javascript:checkform('Del')" class="button">
                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() " class="button">
                      <%end if%>
                        <input type="Hidden" name=mode >
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
<% closeconn() %>