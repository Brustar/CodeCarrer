<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>丰达科技</title>
<link href="index.css" rel="stylesheet" type="text/css">
<script language="javascript">
	function check_input(){
		if(document.Frm.subject.value==""||document.Frm.subject.length==0){
			alert('请输入标题！');
			document.Frm.subject.focus();
			return false;
		}
		if(document.Frm.username.value==""||document.Frm.username.length==0){
			alert('请输入姓名！');
			document.Frm.username.focus();
			return false;
		}
		if(document.Frm.email.value==""||document.Frm.email.length==0){
			alert('请输入Email！');
			document.Frm.email.focus();
			return false;
		}
		if(document.Frm.telephone.value==""||document.Frm.telephone.length==0){
			alert('请输入电话！');
			document.Frm.telephone.focus();
			return false;
		}
	}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<% 
subject=request("subject")
if subject<>empty then
	username=request("username")
	cateid=request("cateid")
	telephone=request("telephone")
	email=request("email")
	fromwhere=request("fromwhere")
	address=request("address")
	content=request("content")
	sql="insert into feedbackinfo(subject,username,cateid,telephone,email,fromwhere,address,content) values('"&subject&"','"&username&"','"&cateid&"','"&telephone&"','"&email&"','"&fromwhere&"','"&address&"','"&content&"')"
	'res sql
	conn.execute(sql)
	GoMsg "恭喜您提交成功，我们会及时给您回复，谢谢！","index.asp"
end if
 %>
<table width="1004" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/about.swf">
              <param name="quality" value="high">
              <param name="menu" value="false">
              <param name="wmode" value="transparent">
              <embed src="flash/about.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="4" bgcolor="E7E3E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1" bgcolor="C8C8C8"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="36" background="images/d_tiao.gif">　　<a href="index.asp" class="a1">首页</a> 
            <font color="0071BD">&gt;</font> <a href="server.asp">客户服务</a></td>
        </tr>
      </table>
      <br>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="178" valign="top"> 
            <table width="168" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src=<%=Timg("images/server_left_top.gif")%> width="168" height="10"></td>
              </tr>
              <tr>
                <td bgcolor="CECECE"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td height="30"><strong>用户专区</strong></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#FFFFFF"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                    </tr>
                    <tr> 
                      <td> <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="13%"><img src=<%=Timg("images/server_biao.gif")%> width="20" height="20"> 
                            </td>
                            <td width="87%"><a href="user.asp">资料下载</a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#FFFFFF"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                    </tr>
                    <tr> 
                      <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="13%"><img src=<%=Timg("images/server_biao.gif")%> width="20" height="20"> 
                            </td>
                            <td width="87%"><a href="server1.asp">服务网络</a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#FFFFFF"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                    </tr>
                    <tr> 
                      <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td width="13%"><img src=<%=Timg("images/server_biao.gif")%> width="20" height="20"> 
                            </td>
                            <td width="87%"><a href="server2.asp">客户反馈</a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#FFFFFF"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src=<%=Timg("images/server_left_middle.gif")%> width="168" height="20"></td>
              </tr>
              <tr>
                <td bgcolor="EFEBEF"><div align="center"><img src=<%=Timg("images/example10.jpg")%> width="139" height="262"></div></td>
              </tr>
              <tr>
                <td><img src=<%=Timg("images/server_left_bottom.gif")%> width="168" height="10"></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
          <td width="600" valign="top"><img src=<%=Timg("images/server_lady.jpg")%> width="600" height="80">
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><DIV align=center><FONT color=#ff0000>注意：标有*号的内容为必填内容</FONT><BR>
                  </DIV>
                  <BR> <TABLE 
      style="BORDER-RIGHT: rgb(200,200,200) 1px double; BORDER-TOP: rgb(200,200,200) 1px double; BORDER-LEFT: rgb(200,200,200) 1px double; BORDER-BOTTOM: rgb(200,200,200) 1px double" 
      cellSpacing=8 cellPadding=0 width=499 align=center bgColor=#f2f8ff 
      border=0>
                    <TBODY>
                      <TR> 
                        <TD class=p11> <P><FONT face="楷体_GB2312, 黑体, 隶书"></FONT><SPAN 
            class=p9>　请填写以下反馈表单，谢谢！ </SPAN></P>
                          <FORM name=Frm onsubmit="return check_input()" action="" method=post>
                            <P class=p9>主　题： 
                              <INPUT name=subject 
            style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" 
            size=48 maxlength="100">
                              <FONT color=#ff0000>*反馈信息的主题</FONT><BR>
                              类　型： 
                              <SELECT name=cateid>
                                <option value="1" selected>产品咨询</option>
                                <option value="2">服务咨询</option>
                                <option value="3">给公司的建议</option>
                                <option value="4">购买及合作意向</option>
                              </SELECT>
                              <FONT 
            color=#ff0000>*请选择反馈信息的类型</FONT> <BR>
                              <BR>
                              姓　名： 
                              <INPUT 
            name=username 
            style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" maxlength="50">
                              <FONT color=#ff0000>*必须填写</FONT> <BR>
                              E-mail： 
                              <INPUT 
            name=email 
            style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" maxlength="50">
                              <FONT color=#ff0000>*请填写有效E-mail以方便我们与您联系</FONT> 
                              <BR>
                              来　自： 
                              <INPUT 
            name=fromwhere 
            style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" maxlength="50">
                              如：广东惠州<BR>
                              地　址： 
                              <INPUT name=address 
            style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" 
            size=48 maxlength="100">
                              <BR>
                              电　话： 
                              <INPUT 
            name=telephone 
            style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" maxlength="50">
                              <font color=#ff0000>*必须填写</font> <BR>
                              <BR>
                              反馈信息：<FONT color=#ff0000>[<FONT 
            color=#666666>请注意适当使用<FONT face="Arial, Helvetica, sans-serif" 
            color=#ff0000>Enter</FONT>键来换行</FONT>]</FONT><BR>
                              　　　　 
                              <TEXTAREA style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" name=content rows=10 cols=56></TEXTAREA>
                              <BR>
                              <BR>
                              　　　　 
                              <INPUT style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" type=submit value=" 提 交 信 息 " name=Submit>
                              　　 
                              <INPUT style="BORDER-RIGHT: rgb(88,88,88) 1px double; BORDER-TOP: rgb(88,88,88) 1px double; FONT-WEIGHT: normal; FONT-SIZE: 9pt; BORDER-LEFT: rgb(88,88,88) 1px double; LINE-HEIGHT: normal; BORDER-BOTTOM: rgb(88,88,88) 1px double; FONT-STYLE: normal; FONT-VARIANT: normal" type=reset value=" 重 新 填 写 " name=Reset>
                            </P>
                          </FORM></TD>
                      </TR>
                    </TBODY>
                  </TABLE></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table> </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
