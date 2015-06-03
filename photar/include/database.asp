<% 
Dim DBType,Conn,StrConn,rs
DBType=1       '0为Access数据库，1为MSSQL数据库 

If(DBType=0) Then
'********************************ACCESS数据库*************************************
Dim DbFolderName,DbFolder_Path,SiteFolder
DbFolderName="ArticleData"   '数据库所在文件夹名称
DbFolder_Path = Server.MapPath(DbFolderName)   '数据库所在路径
SiteFolder="Article"                    '系统所在根目录名称

   If Session("RootDir") = "" Then 
        Session("RootDir") = Mid(DbFolder_Path, 1, InStr(1,DbFolder_Path,SiteFolder,1) -1) & SiteFolder 
   End if
   Set Conn = Server.CreateObject("Adodb.Connection")
   StrConn = "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Session("RootDir") & "\"& DbFolderName & "\Data.mdb"  '连接到数据库
   Conn.Open StrConn
'**********************************************************************************

ElseIf(DBType=1) Then
   Dim DBUserID,DBPassWord,DBName,DBIP
   '修改以下信息以适合你的网站
   DBUserID="sa"  '数据库登陆名cw97131
   DBPassWord="sa"  '数据库密码f5g6c0n9
   DBName="photar" '数据库名称cw97131_db
   DBIP="localhost" '数据库所在地址，如果是本地数据库则为：(localhost)218.30.96.87

   Set Conn=Server.CreateObject("Adodb.Connection")
   StrConn = "PROVIDER=SQLOLEDB.1;Data Source="&DBIP&";Initial Catalog="&DBName&";Persist Security Info=True;User ID="&DBUserID&";Password="&DBPassWord&";Connect Timeout=30"
    'StrConn = "Driver={sql server};server="&DBIP&";database="&DBName&";uid="&DBUserID&";pwd="&DBPassWord&";" 
   Conn.Open StrConn
'**********************************************************************************
Else
'***********************数据库设置错误*************************************************
   Response.Write"数据库设置错误，请联系管理员！"
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
