<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���Ƽ�</title>
<link href="index.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=javascript>
function PopDate(txt){
	var splashWin=window.open("../include/SelectDate.htm",'tip','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0');
	splashWin.resizeTo(230,236);
	DateValue=txt;
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<% 
accessingName = getString(request("accessingName"))
MediaName = getString(request("MediaName"))
telephone = getString(request("telephone"))
accessingDate = getString(request("accessingDate"))
Email = getString(request("Email"))
content = ParseString(request("content"))
if accessingName<>empty then
sql="insert into accessing(accessingName,MediaName,content,Email,accessingDate,telephone,english) values('"
sql=sql & accessingName&"','"&MediaName&"','"&content&"','"&Email&"','"&accessingDate&"','"&telephone&"',0)"
conn.execute(sql)
CloseConn()
GoMsg "ԤԼ�ɹ���","index.asp"
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
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="34" valign="top" background="images/title2.gif"> <table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="5%"><img src=<%=Timg("images/biao3.gif")%> width="26" height="26" hspace="5"></td>
          <td width="83%"><img src=<%=Timg("images/jz.gif")%> width="77" height="20"></td>
          <td width="3%" valign="bottom"><a href="index.asp"><img src=<%=Timg("images/gotop.gif")%> width="18" height="18" hspace="5" vspace="2" border="0"></a></td>
          <td width="9%" valign="bottom"><strong><a href="index.asp"><font color="397D94">�ص���ҳ</font></a></strong></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="5"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="200" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
        </tr>
      </table>
      <table width="196" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><img src=<%=Timg("images/reporter_top0.gif")%> width="196" height="12"></td>
        </tr>
        <tr> 
          <td bgcolor="F0EBF1"><table width="170" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="25"><strong>��Ŀ����</strong></td>
              </tr>
              <tr> 
                <td height="1" background="images/xuxian_hei.gif"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
              <tr> 
                <td><br> <a href="accessing.asp"><img src=<%=Timg("images/reporter_1.gif")%> width="170" height="81" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="reporter.asp"><img src=<%=Timg("images/reporter_2.gif")%> width="170" height="62" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="image.asp"><img src=<%=Timg("images/reporter_3.gif")%> width="170" height="63" border="0"></a></td>
              </tr>
            </table>
            <p>&nbsp; </p></td>
        </tr>
        <tr> 
          <td><img src=<%=Timg("images/reporter_down0.gif")%> width="196" height="12"></td>
        </tr>
      </table></td>
    <td valign="top" bgcolor="E7E7E7">
<table width="581" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" bgcolor="#FFFFFF">
<div align="right"><img src=<%=Timg("images/reporter.gif")%> width="573" height="147"></div></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="8" bgcolor="#FFFFFF"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
              </tr>
            </table>
            <table width="573" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td><img src=<%=Timg("images/reporter_top1.gif")%> width="580" height="17"></td>
              </tr>
              <tr> 
                <td valign="top" bgcolor="E7E7E7"> 
                  <form name="FrmLogin" action="" method="post">
                    <p><strong>&nbsp;&nbsp;<font color="#666666" class="font14">ԤԼ�ɷ�:</font></strong></p>
                    <table width="95%" align="center" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                      <tr> 
                        <td bgcolor="#D8D8D8"> <br />
                          <table width="90%" border="0" align="center" cellpadding="8" cellspacing="0">
                            <tr> 
                              <td><div align="right"><font color="#FF0000">*</font>������</div></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td><div align="right">�ɷ����⣺<br>
                                </div></td>
                              <td><input name="accessingName" type="text" id="accessingName">
                                <font color="#FF0000">*</font></td>
                            </tr>
                            <tr> 
                              <td><div align="right">ý������ <br>
                                </div></td>
                              <td><input name="MediaName" type="text" id="MediaName">
                                <font color="#FF0000">*</font></td>
                            </tr>
                            <tr> 
                              <td><div align="right">�ɷ����ڣ� <br>
                                </div></td>
                              <td><input name="accessingdate" type="text" id="accessingdate" onClick="PopDate(this);" readonly>
                                <font color="#FF0000">*</font></td>
                            </tr>
                            <tr> 
                              <td><div align="right">�绰�� <br>
                                </div></td>
                              <td><input name="Telephone" type="text" id="Telephone">
                                <font color="#FF0000">*</font></td>
                            </tr>
                            <tr> 
                              <td><div align="right">�����ʼ���</div></td>
                              <td><input name="Email" type="text" id="Email">
                                <font color="#FF0000">*</font></td>
                            </tr>
                            <tr> 
                              <td><p align="right">�ɷ�˵����</p></td>
                              <td><textarea name="content" cols="45" rows="6" id="content"></textarea>
                                <font color="#FF0000">*</font></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><input type="submit" name="Submit" value="����">
                                �� 
                                <input type="button" name="Submit2" value="����" onClick="javascript:history.back()"></td>
                            </tr>
                          </table>
                          <br></td>
                      </tr>
                    </table>
                    <p>&nbsp;</p>
                  </FORM></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
</body>
</html>
