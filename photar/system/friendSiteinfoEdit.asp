<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     ID = request("ID")
     mode = request("Mode")
	 if mode="EditInfo" then
	 	sql="select * from FriendSiteinfo where id="& ID
		set rs=conn.execute(sql)
		if not rs.eof then
			SiteName=rs("SiteName")
			modified=rs("modified")
			URL=rs("URL")
			LogoURL=rs("LogoURL")
			IsIndex=rs("IsIndex")
			ischeck=rs("ischeck")
			Sort=rs("Sort")
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
    temp=window.confirm("��ȷ��Ҫɾ��������������");
    if (temp){
      editForm.action="FriendSiteInfoSave.asp?mode="+mode;
      editForm.submit();
    }

  }
  if(mode=="Edit"){
  	var Surl=editForm.URL.value;
	if(Surl.toLowerCase().substring(0,7)!="http://"){
	 	editForm.URL.value="http://"+editForm.URL.value;
	}
  	var iOrder=editForm.Sort.value;
    if(iOrder.length>0){
      for(var i=0;i<iOrder.length;i++){
        if(iOrder.charCodeAt(i)<48||iOrder.charCodeAt(i)>57){
          alert("�������зǷ��ַ�!");
          editForm.Sort.focus();
          return false;
        }
      }
    }
    editForm.action="FriendSiteInfoSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="New"){
   	var Surl=editForm.URL.value;
	if(Surl.toLowerCase().substring(0,7)!="http://"){
	 	editForm.URL.value="http://"+editForm.URL.value;
	}
    if(editForm.SiteName.value==""){
      alert("������������!");
      editForm.SiteName.focus();
      return;
	}	
	var iOrder=editForm.Sort.value;
    if(iOrder.length>0){
      for(var i=0;i<iOrder.length;i++){
        if(iOrder.charCodeAt(i)<48||iOrder.charCodeAt(i)>57){
          alert("�������зǷ��ַ�!");
          editForm.Sort.focus();
          return false;
        }
      }
    }    
    editForm.action="FriendSiteInfoSave.asp?mode="+mode;
    editForm.submit();
  }
  if(mode=="Pass"){
          editForm.action="FriendSiteInfoSave.asp?mode="+mode;
	      editForm.submit();
  }
  if(mode=="NotPass"){
          editForm.action="FriendSiteInfoSave.asp?mode="+mode;
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
<table border="0" cellspacing="0" cellpadding="0" bgcolor="#0C89A7" width="90%" align="center">
  <tr>
	<td width="100%" bgcolor="#E6E6E6">
		<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="red">*</font>Ϊ������
		<br>
      <table border=0 cellpadding="2" cellspacing="1" width="100%">
		<tr>
		  <td colspan=2 align=center><strong><font size="4">�� �� �� �� �� Ϣ</font></strong></td>
		</tr>
        <tr>
          <td valign="top">
<form name="editForm" method="post">
  <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
    <tr>
                  <td align=right class=k_105pt width=129><font si??ze="2"><strong>��������</strong></font></td>
      <td width="758"> <input type=text name="SiteName" size=50 maxlength=150 value="<%=SiteName%>"  class="text1">
        <font color="red">*</font></td>
    </tr>
    <tr>
                  <td align=right class=k_105pt width=129><font size="2"><strong>���ӵ�ַ��</strong></font></td>
                  <td width="758"> <font color="red">
                    <input type=text name="URL" size=50 maxlength=50 value="<%=URL%>" class="text1">
                    *</font></td>
    </tr> 
    <tr >
                  <td align=right class=k_105pt width=129><font size="2"><strong>�Ƿ���ҳ�Ƽ���</strong></font></td>
                  <td><input type="checkbox" name="IsIndex" value="1" <% =IsChecked(IsIndex) %>>
                  </td>
    </tr>    
    <tr>
                  <td align=right class=k_105pt width=129><font size="2"><strong>����</strong></font></td>
      <td><input type=text name="Sort" size=5 maxlength=5 value="<%=Sort%>" class="text1">
      </td>
    </tr>
    <tr>
                  <td align=right class=k_105pt><font size="2"><strong>Logoͼ�꣺</strong></font></td>
      <td align=left class=k_105pt> <input name="LogoUrl" type=text class="text1" value="<%=LogoUrl%>" size="30" readonly>&nbsp;&nbsp
  <input type="button" name="btattache" value="���..." onclick="UploadFile(LogoUrl)" class="button"></td>
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
        <td width="758" align=left class=k_105pt> <%=nowstr%> </td>     
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
<!-- #include FILE="../include/Buttons.asp" -->
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