<!--#include file="upload_5xsoft.inc"-->
<!--#include file="StringParse.asp"-->
<%
   set uploadFile=new upload_5xSoft '����д�ļ�����   
   file_name=getFileString()
   path = Server.mappath("../uploadfiles")
   res path
   for each formName in uploadFile.file  '�г������ϴ��˵��ļ�
		set file=uploadFile.file(formName)  '����һ���ļ�����
		if file.FileSize>0 then
			img_str=file_name & mid(file.fileName,InStrRev(file.fileName, "."))
			img=path & "\" & img_str
			img=Cstr(img)
	    	file.SaveAs img   ' �����ļ�
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