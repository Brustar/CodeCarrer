<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     mode = "EditInfo"
	 types=request("types")
	 select case types
	 	case "ContactInfo"
			leftprompt="��ϵ����"
		case "About"
			leftprompt="��˾���"
		case "manufacture"
			leftprompt="��﹤ҵ԰"
		case "Culture"
			leftprompt="��ҵ�Ļ�"
		case "technology"
			leftprompt="��������"
		case "SiteMap"
			leftprompt="��������"
		case "management"
			leftprompt="��������"
		case "station"
			leftprompt="��˾��λ"
		case "JobStratagem"
			leftprompt="���֮��"
		case "honor"
			leftprompt="�������"
		case "visualize"
			leftprompt="����չʾ"
		case "build"
			leftprompt="Ʒ�ƽ���"
		case "sale"
			leftprompt="Ӫ���"
		case "salenet"
			leftprompt="Ӫ������"
		case "servernet"
			leftprompt="��������"
		case "market"
			leftprompt="���й�˾����"
		case "users"
			leftprompt="��˾�ܲ�"
		case "CEOsign"
			leftprompt="�����Ŷ�"
		case "publicAct"
			leftprompt="����"
		case "tactic"
			leftprompt="Ʒ��ս��"
		case "salebook"
			leftprompt="�����ֲ�"
		case "Companyinfo"
			leftprompt="��˾�ſ�"
		case "StockStatu"
			leftprompt="�ɱ�״��"
		case "FinancialData"
			leftprompt="���²�������"
		case else
			leftprompt="���ڷ��"
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
    temp=window.confirm("��ȷ��Ҫɾ����������");
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
      alert("��������վ����!");
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
		<font color="red">*</font>Ϊ������
		<br>
      <table border=0 cellpadding="2" cellspacing="1" width="100%">
		<tr>
		  <td colspan=2 align=center><strong><font size="4">�� Ϣ �� ��</font></strong></td>
		</tr>
        <tr>
          <td valign="top">
<form name="editForm" method="post">
  <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%"> 
    <tr>
      <td valign="top" align="right" class=k_105pt width=139> <font size="2"><strong><br>
        <%= leftprompt %>�� </strong></font></td>
                  <td align="left"> <INPUT TYPE=hidden NAME=PageHtml VALUE="<%= content %>"> 
        <INPUT TYPE=hidden NAME=content> <INPUT type=hidden name=PageBackground value=""> 
        <IFRAME STYLE="border: none" NAME=EditBox src="../include/edit/Include/htmlEdit/htm/_rte.htm" WIDTH="100%" HEIGHT="400" scrolling="no"></IFRAME> 
      </td>
    </tr>
    <tr>
                  <td align=right class=k_105pt> <font size="2"><strong>�޸����ڣ� 
                    </strong></font></td>
        <td width="748" align=left class=k_105pt> <%=now%> </td>     
    </tr>
    <tr>
      <td valign="top"><font size="2">&nbsp;</font></td>
      <td>
<input type=hidden name="types" value="<%= types %>">
<input type="button" name="bt2" value="�޸�" class="text3" onClick="checkform('Edit')">
<input type="button" name="btBack" value="����" class="text3" onClick="javascript:history.back();">
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