<%@ page contentType="text/html; charset=gb2312"%>
<%@include file="../../../include/common.jsp" %>
<%
	//==================================================
	// 开始上传图片
	if(ctrl.isStepPost){
		FileUploadHelper fUpload=new FileUploadHelper(request);

		if(fUpload.uploadNameByTime("../../Img/news/")==null) {

%>
<script>
alert("upload error : <%=fUpload.getMessage() %>");

</script>
<%
		return ;
		}
%>
<script>
alert("test upload...");
self.parent.closePickerWindow("<img src=\"../../../images/htmlEdit/clipart/sport/1.gif\">","", -1);

</script>

<%
	return;
	}
%>
<TITLE>上传图片</TITLE>
<META HTTP-EQUIV="Content-Type" Content="text/html; Charset=gb2312">
<STYLE>
    BODY {background: #FFFFE5; border: none; font: 9pt PMingLiU}
    INPUT, TEXTAREA {font:9pt PMingLiU;color: #000000}
</STYLE>

<script>

var L_RTEUCUPLOADDESC_TEXT = "可以从您的电脑新增图片。点击以下按钮进行选择。然后点击\"新增图片\"。";
alert("test: fUpload : <%=param.getString("test") %>");
</script>


<SCRIPT>
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
    write('<FORM ONSUBMIT="alert(\'upload ing...\'); return true" ENCTYPE="multipart/form-data" ID=fUpload ACTION="'  + parent.g_state.CS_URL + '" METHOD=post>')
    if (navigator.appVersion.indexOf("MSIE 4")==-1)
        write('<INPUT TYPE=FILE NAME=PhotoFile STYLE="WIDTH: 100%">')
    else
        write('<INPUT TYPE=FILE NAME=PhotoFile STYLE="WIDTH: 200">')
    write('<INPUT TYPE=HIDDEN NAME="ID_Community" VALUE="">')
    write('<INPUT TYPE=HIDDEN NAME="Step" VALUE="post">')

//	write('<div align=right><INPUT TYPE=SUBMIT VALUE=" 确 定 "></div>')
    
	write('</FORM>')
}
</SCRIPT>
</DIV>
</BODY>