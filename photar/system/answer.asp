<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<% 
id=request("id")
email=request("email")
subject=request("subject")
content=request("content")
if content<>empty then
sql="update feedbackinfo set ischeck=1 where id="& id
conn.execute sql
'�ظ��ʼ�
Dim cm
Set cm=Server.CreateObject("CDO.Message")
'��������
cm.From="zhi-chu@netease.com"
'���÷����˵�����
cm.To="yeals2@hotmail.com"
'���������˵�����
cm.Subject="��﹫˾�ķ���"
'�趨�ʼ�������
'cm.TextBody="http://www.knowsky.com/rss/"
'������ʹ����ͨ���ı���ʽ�����ʼ���ֻ�������֣�����֧��html���������ﲻ��

cm.HtmlBody="�����Ѿ��յ��������Ϊ'"&subject&"'�ķ���,����лл��ϿҵĽ��顣"

'��������㹹����html���ģ������������ʼ��ͱ�ֻ�����ֵĺÿ����ˡ���Ҫ˵�㲻��html��

'cm.AddAttachment Server.MapPath("test.zip")
'�������Ҫ���͸����Ļ���������ķ������ļ����ӽ�ȥ��

cm.Send
'���Ȼ��ִ�з�����
Set cm=Nothing
'���ͳɹ���ʱ�ͷŶ���

gomsg "�����ʼ��ɹ���","feedbacklist.asp"
end if
 %>
 <link rel="stylesheet" href="../include/style.css" type="text/css">
 <body bgcolor="#0C89A7" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0">
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
	<tr bgcolor="#FFFFFF">
      <td width="100%">
<br>
<table width="85%" border=1 align="center" cellpadding=5 cellspacing=0 bordercolorlight="#484848" bordercolordark="#ffffff" bgcolor="#FFFFFF">
 <form name="form1" method="post" action=""><tr align=center>
     <th width="32%" align="right" scope="row">���⣺</th>
     <td width="68%" align="left"><%= subject %></td>
  </tr>
   <tr>
     <th align="right" valign="top" scope="row">�ظ����ݣ�</th>
     <td><textarea name="content" cols="60" rows="15"></textarea>
     &nbsp;</td>
   </tr>
      <tr align="center">
     <td colspan="2">
       <input type="submit" name="Submit" value="�ύ"> 
       &nbsp;&nbsp;<input type="button" name="Submit" value="����" onClick="history.back()">
     </td>
   </tr></form>
 </table>   
<br></td>
    </tr>
  </table>
 </body>