<!--#include file="upload_5xsoft.inc"-->
<%
   set uploadFile=new upload_5xSoft '����д�ļ�����
   Randomize
   file_name_str=cstr(rnd(5)*1000000)
   file_name=left(file_name_str,6)
   path = Server.mappath("../../../Img/news/")
   for each formName in uploadFile.file  '�г������ϴ��˵��ļ�
		set file=uploadFile.file(formName)  '����һ���ļ�����
	    if file.FileSize>0 then file.SaveAs path & "\" & file_name & file.FileName   ' �����ļ�
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