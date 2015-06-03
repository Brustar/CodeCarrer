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
'回复邮件
Dim cm
Set cm=Server.CreateObject("CDO.Message")
'创建对象
cm.From="zhi-chu@netease.com"
'设置发信人的邮箱
cm.To="yeals2@hotmail.com"
'设置收信人的邮箱
cm.Subject="丰达公司的反馈"
'设定邮件的主题
'cm.TextBody="http://www.knowsky.com/rss/"
'上面是使用普通的文本格式发送邮件，只能是文字，不能支持html，所以这里不用

cm.HtmlBody="我们已经收到你的主题为'"&subject&"'的反馈,衷心谢谢你诚恳的建议。"

'上面就是你构建的html正文，这样发出的邮件就比只有文字的好看多了。不要说你不会html吧

'cm.AddAttachment Server.MapPath("test.zip")
'如果有需要发送附件的话就用上面的方法把文件附加进去。

cm.Send
'最后当然是执行发送了
Set cm=Nothing
'发送成功后即时释放对象

gomsg "发送邮件成功。","feedbacklist.asp"
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
     <th width="32%" align="right" scope="row">主题：</th>
     <td width="68%" align="left"><%= subject %></td>
  </tr>
   <tr>
     <th align="right" valign="top" scope="row">回复内容：</th>
     <td><textarea name="content" cols="60" rows="15"></textarea>
     &nbsp;</td>
   </tr>
      <tr align="center">
     <td colspan="2">
       <input type="submit" name="Submit" value="提交"> 
       &nbsp;&nbsp;<input type="button" name="Submit" value="返回" onClick="history.back()">
     </td>
   </tr></form>
 </table>   
<br></td>
    </tr>
  </table>
 </body>