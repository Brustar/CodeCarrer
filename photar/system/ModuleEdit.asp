<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
  dim parentID,rootID,moduleID,isModule,mode,functions,moduleName,sql
  parentID=request("parentID")
  moduleID=request("moduleID")
  mode=request("mode") 
  if mode=empty then mode="0"  
  functions=getString(request("functions"))
  moduleName=getString(request("moduleName"))
  if moduleName =empty then moduleName=""  
  if functions=empty then functions=""
  if mode="New" then
  	sql="insert into ModuleInfo(moduleName,parentID,URL) values('" & moduleName & "'," & parentID & ",'" & functions & "')"
	conn.execute sql
	response.Redirect("moduleList.asp")	
  elseif mode="Edit" then
  	sql="update ModuleInfo set moduleName='" & moduleName & "',parentID=" & parentID & ",URL='" & functions & "' where id=" & moduleID
	conn.execute sql
	response.Redirect("moduleList.asp")
  elseif mode="Del" then
  	sql="delete ModuleInfo where id=" & moduleID
	strsql="delete ModuleInfo where parentid=" & moduleID
	conn.execute sql
	conn.execute strsql
	response.Redirect("moduleList.asp")
  end if
if moduleID <>empty and len(moduleID) > 0 then
    sql="select * from moduleinfo where id=" & moduleID
    set record = conn.execute(sql)
    moduleName = record("modulename")
    functions = record("URL")
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
                        temp=window.confirm("你确定要删除此模块吗？");
                        if (temp)
                        {
                                form1.mode.value=mode;
                                form1.submit();
                        }
                }
                else
                {
                        if (form1.moduleName.value=="" || form1.functions.value=="")
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
<form action="ModuleEdit.asp" method=POST  name=form1>
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
    <tr>
      <td width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td bgcolor="#0C89A7" background="../images/oa_menu_from1_01.gif" valign="middle" width="200">
              <p class="unnamed1" align="center"><span class="unnamed1">系统模块设置</span>
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
                      <td align="center"><span class="fontpx12"><font color="#646464">模块名称：</font></span>
                        <input  name="moduleName" class="button1" value="<%=moduleName%>">
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">模块代号：</font></span>
                        <input name="functions" class="button1" value="<%=functions%>">
                      </td>
                    </tr>
      <!--               <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">是否公共：</font></span>
                      <%'if isPublic="1" then%>
                        <input type="radio" value="1" name="IsPublic" checked>是
                        <input type="radio" value="0" name="IsPublic">否
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <%'else%>
                        <input type="radio" value="1" name="IsPublic" >是
                        <input type="radio" value="0" name="IsPublic" checked>否
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <%'end if%>
                      </td>
                    </tr>
                    <tr>
                      <td align="center"><span class="fontpx12"><font color="#646464">是否可定制：</font></span>
                     <%'if isOrder="1" then%>
                        <input type="radio" value="1" name="isOrder" checked>是
                        <input type="radio" value="0" name="isOrder">否
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <%'else%>
                        <input type="radio" value="1" name="isOrder">是
                        <input type="radio" value="0" name="isOrder" checked>否
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <%'end if%>
                      </td>
                    </tr> -->
<%
    if mode="NewModule" then
%>
                    <!-- <input type="Hidden" name=isModule value="<%'=request("isModule")%>">
                    <input type="Hidden" name=rootID value="<%'=request("rootID")%>"> -->
                    <input type="Hidden" name=parentID value="<%=request("parentID")%>">
<% else %>
                    <input type="Hidden" name=moduleID value="<%=record("ID")%>">
                    <!-- <input type="Hidden" name=isModule value="<%'=record("ISMODULE")%>">
                    <input type="Hidden" name=rootID value="<%'=record("ROOTID")%>"> -->
                    <input type="Hidden" name=parentID value="<%=record("PARENTID")%>">
<% end if %>
                  </table>
                  <p>

                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right">
                      <%if mode="NewModule" then%>
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