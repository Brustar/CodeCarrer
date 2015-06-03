<!--#include file="upload_5xsoft.inc"-->
<%
   set uploadFile=new upload_5xSoft '生成写文件对象
   Randomize
   file_name_str=cstr(rnd(5)*1000000)
   file_name=left(file_name_str,6)
   path = Server.mappath("../../../Img/news/")
   for each formName in uploadFile.file  '列出所有上传了的文件
		set file=uploadFile.file(formName)  '生成一个文件对象
	    if file.FileSize>0 then file.SaveAs path & "\" & file_name & file.FileName   ' 保存文件
        img="<img src=../../../Img/news/" & file_name & file.FileName & ">"		
	    img_str=cstr(img)
%>
      <script>
	  sHTML="";
	  sHTML += '<%= img_str %>';
	  parent.closePickerWindow(sHTML, "", -1);
	  </script>
<%  		   
		set file=nothing
   next 
%>