<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<%
     mode = request("Mode")
     rightsID = request("rightsID")
     ID = request("ID")
	 sql="select * from feedbackinfo where id="& ID
	 set record=conn.execute(sql)
%>
<HTML>
<HEAD>
<title>ϵͳ����</title>

<meta http-equiv="Context-Language" content="zh-cn"><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../include/style.css" type="text/css">
</HEAD>
<BODY leftmargin="0" topMargin="10" marginwidth="0" marginheight="0" bgcolor="#0C89A7">

  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
    <form action="NewsCateSave.jsp" method=POST  name=form1>
	<tr>
      <td width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="200">
              <p align="center" class="unnamed1"><span class="unnamed1">������Ϣ�鿴</span>
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
                <td bgcolor="#E6E6E6" width="100%" align="center"><br>
<% if not record.eof then
	Subject=record("Subject")
	email=record("email")
	id=record("id")
 %>
                  <table width="85%" border=1 cellspacing=0 cellpadding=5 bordercolordark="#ffffff" bordercolorlight="#484848" bgcolor="#FFFFFF">
                     <tr>
                      <td width="18%" align="right"><span class="fontpx12"><font color="#646464">���⣺</font></span></td>
                      <td width="82%" align="left">&nbsp;&nbsp;<%=subject %></td>
                    </tr>
                    <tr>
                      <td width="18%" align="right"><span class="fontpx12"><font color="#646464">������</font></span></td>
                      <td width="82%" align="left">&nbsp;&nbsp;<%=record("username") %></td>
                    </tr>
                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">Email��</font></span>
                      </td>
                      <td align="left">&nbsp;&nbsp;<%=email %></td>
                    </tr>
                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">�绰��</font></span></td>
                      <td align="left">&nbsp;&nbsp;<%=record("telephone") %></td>
                    </tr>
                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">���ԣ�</font></span></td>
                      <td align="left">&nbsp;&nbsp;<%=record("fromwhere")%></td>
                    </tr>
                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">��ַ��</font></span></td>
                      <td align="left">&nbsp;&nbsp;<%=record("address") %></td>
                    </tr>
 <% 
 cateid=record("cateid")
 if cateid=1 then
 	catename="��ƷͶ��"
 elseif cateid=2 then
 	catename="����Ͷ��"
 elseif cateid=2 then
 	catename="����˾�Ľ���"
 elseif cateid=2 then
 	catename="���򼰺�������"
 end if
  %>
                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">���</font></span></td>
                      <td align="left">&nbsp;&nbsp;<%=catename %></td>
                    </tr>
                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">�������ݣ�</font></span></td>
                      <td align="left">&nbsp;&nbsp;<%=record("content") %></td>
                    </tr>              

                    <tr>
                      <td align="right"><span class="fontpx12"><font color="#646464">�������ڣ�</font></span></td>
                      <td align="left">&nbsp;&nbsp; <%=record("Modified")%></td>
                    </tr>
                  </table>
<% End If %>
                  <table width="70%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right"><INPUT onclick='document.execCommand("print")' type=button value="�� ӡ" name=Submit class="button"> 
<INPUT onclick='document.execCommand("saveAs")' type=button value="���Ϊ" name=Sub class="button"> 
                        <input type="button" value="�ظ�" name=button1 onClick="location.href='answer.asp?id=<%= id %>&email=<%= email %>&subject=<%= subject %>'" class="button">
						<input type="button" value="�� ��" name=button1 onClick="javascript:history.back() ;" class="button">
                        <input type="Hidden" name=mode >
                      </td>
                    </tr>
                  </table>
<%
closers(record)
closeconn
%>
                  <h3 align="center"><br>
                  </h3>
                </td>
              </tr>
            </table>
          </center>
        </div>
      </td>
    </tr></form>
  </table>
</BODY>
</HTML>