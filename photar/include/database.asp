<% 
Dim DBType,Conn,StrConn,rs
DBType=1       '0ΪAccess���ݿ⣬1ΪMSSQL���ݿ� 

If(DBType=0) Then
'********************************ACCESS���ݿ�*************************************
Dim DbFolderName,DbFolder_Path,SiteFolder
DbFolderName="ArticleData"   '���ݿ������ļ�������
DbFolder_Path = Server.MapPath(DbFolderName)   '���ݿ�����·��
SiteFolder="Article"                    'ϵͳ���ڸ�Ŀ¼����

   If Session("RootDir") = "" Then 
        Session("RootDir") = Mid(DbFolder_Path, 1, InStr(1,DbFolder_Path,SiteFolder,1) -1) & SiteFolder 
   End if
   Set Conn = Server.CreateObject("Adodb.Connection")
   StrConn = "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Session("RootDir") & "\"& DbFolderName & "\Data.mdb"  '���ӵ����ݿ�
   Conn.Open StrConn
'**********************************************************************************

ElseIf(DBType=1) Then
   Dim DBUserID,DBPassWord,DBName,DBIP
   '�޸�������Ϣ���ʺ������վ
   DBUserID="sa"  '���ݿ��½��cw97131
   DBPassWord="sa"  '���ݿ�����f5g6c0n9
   DBName="photar" '���ݿ�����cw97131_db
   DBIP="localhost" '���ݿ����ڵ�ַ������Ǳ������ݿ���Ϊ��(localhost)218.30.96.87

   Set Conn=Server.CreateObject("Adodb.Connection")
   StrConn = "PROVIDER=SQLOLEDB.1;Data Source="&DBIP&";Initial Catalog="&DBName&";Persist Security Info=True;User ID="&DBUserID&";Password="&DBPassWord&";Connect Timeout=30"
    'StrConn = "Driver={sql server};server="&DBIP&";database="&DBName&";uid="&DBUserID&";pwd="&DBPassWord&";" 
   Conn.Open StrConn
'**********************************************************************************
Else
'***********************���ݿ����ô���*************************************************
   Response.Write"���ݿ����ô�������ϵ����Ա��"
   Response.End
End If

Private Function CloseConn() 
	if conn<>empty then
		Conn.close
		set Conn=nothing
	end if
End function

Private Function CloseRs(rs)
	if not(rs is nothing) then 
		rs.close
		set rs=nothing
	end if
End function
%>
