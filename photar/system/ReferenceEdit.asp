<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ID = request("ReferenceID")
     mode = request("Mode")
	 if mode="EditInfo" then
	 	sql="select * from Reference where id="& ID
		set rs=conn.execute(sql)
		if not rs.eof then
			ReferenceName=rs("ReferenceName")
			EnterprisePro=rs("EnterprisePro")
			modified=rs("modified")
			content=rs("content")
			Enterprise=rs("Enterprise")
			cateid=rs("cateid")
			URL=rs("URL")
			ischeck=rs("ischeck")
		end if
	 end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<link rel="stylesheet" href="../include/style.css" type="text/css">

<script src="../include/edit/system/News/edit.js"></script>
<SCRIPT LANGUAGE=javascript>
<!--
function checkform(mode){
  submit_message();
  if(mode=="Del"){
    temp=window.confirm("你确定要删除此资料吗？");
    if (temp){
      editForm.action="ReferenceSave.asp?mode="+mode;
      editForm.submit();
    }

  }
  if(mode=="Edit"){
    editForm.action="ReferenceSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="New"){
    if(editForm.ReferenceName.value==""){
      alert("请输入资料名!");
      editForm.ReferenceName.focus();
      return;
    }
    editForm.action="ReferenceSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="Pass"){
          editForm.action="ReferenceSave.asp?mode="+mode;
	      editForm.submit();
  }
  if(mode=="NotPass"){
          editForm.action="ReferenceSave.asp?mode="+mode;
          editForm.submit();
  }
}

function UploadFile(txt){
  window.open("../include/upload.asp","UploadFile","width=450,height=80,scrollbars=yes");
  FileValue=txt;
}
//-->
</SCRIPT>
</head>
<body bgcolor="#0C89A7" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0">
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#0C89A7" align="center">
  <tr>
	<td bgcolor="#E6E6E6">
		<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="red">*</font>为必填项
		<br>
      <table border=0 cellpadding="2" cellspacing="1" width="100%">
		<tr>
		  <td colspan=2 align=center><strong><font size="4">信 息 发 布</font></strong></td>
		</tr>
        <tr>
          <td valign="top">
<form name="editForm" method="post">
              <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
                <tr> 
                  <td align=right class=k_105pt width=110><font size="2"><strong>产品名称：</strong></font></td>
                  <td width="775"> <input type=text name="ReferenceName" size=50 maxlength=150 value="<%=ReferenceName%>"  class="text1"> 
                    <font color="red">*</font></td>
                </tr>
                <tr> 
                  <td align=right class=k_105pt><font size="2"><strong>产品宣传册：</strong></font></td>
                  <td><input name="Url" type=text class="text1" value="<%=Url%>" size="30">
                    &nbsp;&nbsp <input type="button" name="btattache" value="浏览..." onclick="UploadFile(Url)" class="button"></td>
                </tr>                
                <tr> 
                  <td align=right class=k_105pt><font size="2"><strong>类别：</strong></font></td>
                  <td align="left"> <select name="cateid">
                      <%getSelectTree "ProductCate","Catename",cateid,session("language")%>
                    </SELECT> </td>
                </tr>
                <tr> 
                  <td valign="top" align="right" class=k_105pt width=110> <font size="2"><strong><br>
                    描述： </strong></font></td>
                  <td align="left"> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= content %>"> 
                    <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
                    <IFRAME STYLE="border: none" NAME=EditBox src="../include/edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
                  </td>
                </tr>
                <tr> 
                  <td align=right class=k_105pt> <font size="2"><strong>创建日期： 
                    </strong></font></td>
                  <%if mode="NewInfo" then 
	  		nowstr=now
		else
			nowstr=modified
		end if
	  %>
                  <td width="120" align=left class=k_105pt> <%=nowstr%> </td>
                </tr>
                <tr> 
                  <td align=right class=k_105pt> <font size="2"><strong>审批状态： 
                    </strong></font></td>
                  <td align=left class=k_105pt> <%
        select case ISPUBLISH
            case 0
				res("未审批")
            case 1
				res("通过")
            case 2
				res("不通过")
        end select
%> </td>
                </tr>
                <tr> 
                  <td valign="top"><font size="2">&nbsp;</font></td>
                  <td>
				   <input type="Hidden" name=english value="<%= session("language") %>">
				   <input type=hidden name="MyBody" value=""> <input type="hidden" name="ID" value="<%=ID%>"> 
                    <input type="hidden" name="isCheck" value="<%=isCheck%>"> 
                    <!-- #include FILE="../include/Buttons.asp" --> </td>
                </tr>
              </table>
</form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%
    CloseConn()
%>