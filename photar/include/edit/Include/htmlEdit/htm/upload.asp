<%response.contentType="text/html; charset=gb2312"%>
<TITLE>�ϴ�ͼƬ</TITLE>
<META HTTP-EQUIV="Content-Type" Content="text/html; Charset=gb2312">
<STYLE>
    BODY {background: #FFFFE5; border: none; font: 9pt PMingLiU}
    INPUT, TEXTAREA {font:9pt PMingLiU;color: #000000}
</STYLE>

<script>

var L_RTEUCUPLOADDESC_TEXT = "���Դ����ĵ�������ͼƬ��������������ť����ѡ��Ȼ����\"����ͼƬ\"��";

function _CState() {
    
}

var g_state = new _CState();

</SCRIPT>

<BODY SCROLL=NO>
<DIV STYLE="width: 100%">
<P>
<SCRIPT>
var bAdded = false
with (document) {
    write(L_RTEUCUPLOADDESC_TEXT) 
	//write(parent.L_RTEUCTITLE_TEXT)
    write('<FORM ENCTYPE="multipart/form-data" ID=fUpload ACTION="'  + parent.g_state.CS_URL + '" METHOD=post>')
	//write('<FORM ENCTYPE="multipart/form-data" ID=fUpload ACTION="upload_act.asp" METHOD=post>')
    if (navigator.appVersion.indexOf("MSIE 4")==-1)
        write('<INPUT TYPE=FILE NAME=PhotoFile STYLE="WIDTH: 100%">')
    else
        write('<INPUT TYPE=FILE NAME=PhotoFile STYLE="WIDTH: 100%">')
    write('<INPUT TYPE=HIDDEN NAME="ID_Community" VALUE="">')
    write('<INPUT TYPE=HIDDEN NAME="Step" VALUE="post">') 
	//write('<INPUT TYPE=submit NAME="ok" VALUE="ȷ��">')
	write('</FORM>')
}
</SCRIPT>
</DIV>
</BODY>