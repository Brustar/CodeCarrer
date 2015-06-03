<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     mode = "EditInfo"
	 types=request("types")
	 select case types
	 	case "ContactInfo"
			leftprompt="联系我们"
		case "About"
			leftprompt="公司简介"
		case "manufacture"
			leftprompt="丰达工业园"
		case "Culture"
			leftprompt="企业文化"
		case "technology"
			leftprompt="技术领先"
		case "SiteMap"
			leftprompt="国内销售"
		case "management"
			leftprompt="国际销售"
		case "station"
			leftprompt="公司地位"
		case "JobStratagem"
			leftprompt="丰达之歌"
		case "honor"
			leftprompt="载誉丰达"
		case "visualize"
			leftprompt="形象展示"
		case "build"
			leftprompt="品牌建设"
		case "sale"
			leftprompt="营销活动"
		case "salenet"
			leftprompt="营销网络"
		case "servernet"
			leftprompt="服务网络"
		case "market"
			leftprompt="上市公司形象"
		case "users"
			leftprompt="公司总部"
		case "CEOsign"
			leftprompt="管理团队"
		case "publicAct"
			leftprompt="公益活动"
		case "tactic"
			leftprompt="品牌战略"
		case "salebook"
			leftprompt="促销手册"
		case "Companyinfo"
			leftprompt="公司概况"
		case "StockStatu"
			leftprompt="股本状况"
		case "FinancialData"
			leftprompt="最新财务资料"
		case else
			leftprompt="关于丰达"
	 end select 
	 if session("language")=1 then 
	 	table="SiteInitEn"
	else
		table="SiteInit"
	end if
	 if mode="EditInfo" then
	 	sql="select * from " & table
		set rs=conn.execute(sql)
		if not rs.eof then content=rs(types)
	 end if
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
<script src="../include/edit/system/news/edit.js"></script>
<SCRIPT LANGUAGE=javascript>
<!--
function checkform(mode){
  submit_message();
  if(mode=="Del"){
    temp=window.confirm("你确定要删除此新闻吗？");
    if (temp){
      editForm.action="SiteInitSave.asp?mode="+mode;
      editForm.submit();
    }

  }
  if(mode=="Edit"){
    editForm.action="SiteInitSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="New"){
    if(editForm.SiteName.value==""){
      alert("请输入网站名称!");
      editForm.SiteName.focus();
      return;
    }
    editForm.action="SiteInitSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="Pass"){
          editForm.action="SiteInitSave.asp?mode="+mode;
	      editForm.submit();
  }
  if(mode=="NotPass"){
          editForm.action="SiteInitSave.asp?mode="+mode;
          editForm.submit();
  }
}
//-->
</SCRIPT>
</head>
<body bgcolor="#0C89A7" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0">
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#0C89A7" width="90%" align="center">
  <tr>
	<td width="100%" bgcolor="#E6E6E6">
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
      <td valign="top" align="right" class=k_105pt width=139> <font size="2"><strong><br>
        <%= leftprompt %>： </strong></font></td>
                  <td align="left"> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= content %>"> 
        <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
        <IFRAME STYLE="border: none" NAME=EditBox src="../include/edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
      </td>
    </tr>
    <tr>
                  <td align=right class=k_105pt> <font size="2"><strong>修改日期： 
                    </strong></font></td>
        <td width="748" align=left class=k_105pt> <%=now%> </td>     
    </tr>
    <tr>
      <td valign="top"><font size="2">&nbsp;</font></td>
      <td>
<input type=hidden name="types" value="<%= types %>">
<input type="button" name="bt2" value="修改" class="text3" onClick="checkform('Edit')">
<input type="button" name="btBack" value="返回" class="text3" onClick="javascript:history.back();">
      </td>
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
	closers(rs)
    CloseConn()
%>