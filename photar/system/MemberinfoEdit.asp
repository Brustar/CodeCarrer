<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ID = request("ID")
     mode = request("Mode")
	 res(id)
	 if mode="EditInfo" then
	 	sql="select * from memberinfo where id="& ID
		set rs=conn.execute(sql)
		if not rs.eof then
			UserName=rs("UserName")
			modified=rs("modified")
			TrueName=rs("TrueName")
			PorC=rs("PorC")
			Email=rs("Email")
			ischeck=rs("ischeck")
			telephone=rs("telephone")
			company=rs("company")
			QQID=rs("QQID")
			password=rs("password")
		end if
	 end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<link rel="stylesheet" href="../include/style.css" type="text/css">
<SCRIPT LANGUAGE=javascript>
<!--
function checkform(mode){
  if(mode=="Del"){
    temp=window.confirm("��ȷ��Ҫɾ���˻�Ա��");
    if (temp){
      editForm.action="MemberInfoSave.asp?mode="+mode;
      editForm.submit();
    }

  }
  if(mode=="Edit"){
    editForm.action="MemberInfoSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="New"){
    if(editForm.UserName.value==""){
      alert("�������û���!");
      editForm.UserName.focus();
      return;
    }
    editForm.action="MemberInfoSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="Pass"){
          editForm.action="MemberInfoSave.asp?mode="+mode;
	      editForm.submit();
  }
  if(mode=="NotPass"){
          editForm.action="MemberInfoSave.asp?mode="+mode;
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
		  <td colspan=2 align=center><strong><font size="4">�� Ա �� Ϣ</font></strong></td>
		</tr>
        <tr>
          <td valign="top">
<form name="editForm" method="post">
  <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
    <tr>
                  <td align=right class=k_105pt width=110><font si??ze="2"><strong>�û�����</strong></font></td>
      <td width="775"> <input type=text name="UserName" size=50 maxlength=150 value="<%=UserName%>"  class="text1" <% if mode="EditInfo" then res("readonly")%>>
        <font color="red">*</font></td>
    </tr>
    <tr>
      <td align=right class=k_105pt width=110><font size="2"><strong>���룺</strong></font></td>
      <td width="775"> <input type=password name="password" size=50 maxlength=150 value="<%=password%>" class="text1">
        <font color="red">*</font></td>
    </tr> 
    <tr >
                  <td align=right class=k_105pt width=110><font size="2"><strong>��ʵ������</strong></font></td>
      <td><input type=text name="TrueName" size=50 maxlength=50 value="<%=TrueName%>" class="text1">
      </td>
    </tr>
    <tr>
                  <td align=right class=k_105pt><font size="2"><strong>�����ʼ���</strong></font></td>
      <td><input type=text name="Email" size=50 maxlength=20 value="<%=Email%>" class="text1"></td>
    </tr>    <tr>
                  <td align=right class=k_105pt width=110><font size="2"><strong>�绰��</strong></font></td>
      <td align="left"><input name=telephone size=50 maxlength=50 value="<%=telephone%>" class="text1"></td>
    </tr>
    <tr>
                  <td align=right class=k_105pt width=96><font size="2"><strong>QQ�ţ�</strong></font></td>
      <td><input type=text name="QQID" size=50 maxlength=50 value="<%=QQID%>" class="text1">
      </td>
    </tr>
    <tr>
                  <td align=right class=k_105pt><font size="2"><strong>���ڹ�˾��</strong></font></td>
      <td align=left class=k_105pt><input type=text name="Company" size=50 maxlength=50 value="<%=Company%>" class="text1"></td>
    </tr>
	<tr>
                  <td align=right class=k_105pt><font size="2"><strong>��Ա���</strong></font></td>
      <td align="left">
<select name="PorC" class="text1">
<option value="1" <% If PorC=1 Then res("selected")%>>��ҵ�û�</option>
<option value="0" <% If PorC=0 Then res("selected")%>>�����û�</option>
</SELECT>
      </td>
    </tr>
    <tr>
      <td align=right class=k_105pt> <font size="2"><strong>�������ڣ�
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
                  <td align=right class=k_105pt> <font size="2"><strong>״̬�� </strong></font></td>
      <td align=left class=k_105pt>
<%
        restxt="δ���"
		if IsCheck then
			restxt="����"
        else
			restxt="����"				
        end if
		res(restxt)
%>
     </td>
    </tr>
    <tr>
      <td valign="top"><font size="2">&nbsp;</font></td>
      <td>

<input type=hidden name="MyBody" value="">
<input type="hidden" name="ID" value="<%=ID%>">
<input type="hidden" name="IsCheck" value="<%=IsCheck%>">
<% if mode="NewInfo" then %>
<input type="button" name="bt1" value="����" class="text3" onClick="checkform('New')">
<% Elseif mode="EditInfo" then %>
          <input type="button" name="bt2" value="�޸�" class="text3" onClick="checkform('Edit')">
          <input type="button" name="bt3" value="ɾ��" class="text3" onClick="checkform('Del')">
          <input type="button" name="bt4" value="����" class="text3" onClick="checkform('Pass')">
          <input type="button" name="bt5" value="����" class="text3" onClick="checkform('NotPass')">
<% End If %>
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
    CloseConn()
%>