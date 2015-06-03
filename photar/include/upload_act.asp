<!--#include file="upload_5xsoft.inc"-->
<!--#include file="StringParse.asp"-->
<%
   set uploadFile=new upload_5xSoft '生成写文件对象   
   file_name=getFileString()
   path = Server.mappath("../uploadfiles")
   res path
   for each formName in uploadFile.file  '列出所有上传了的文件
		set file=uploadFile.file(formName)  '生成一个文件对象
		if file.FileSize>0 then
			img_str=file_name & mid(file.fileName,InStrRev(file.fileName, "."))
			img=path & "\" & img_str
			img=Cstr(img)
	    	file.SaveAs img   ' 保存文件
		end if
%>
      <script>
	  sHTML = '<%= img_str %>';
	  opener.FileValue.value=sHTML;
	  self.close();
	  </script>
<%  		   
		set file=nothing
   next 
%>