<!-- #include FILE="database.asp" -->
<!-- #include FILE="SelectTree.asp" -->
<%
Private Function getString(theStart)
 dim stemp
	if (theStart<>empty) then
		stemp=trim(theStart)
		'stemp=replace(stemp,"""", "&quot;")
		stemp=replace(stemp,"'", "&#039;")
		stemp=replace(stemp,"<", "&lt;")
		stemp=replace(stemp,">", "&gt;")		
	end if
 getString=stemp
End function

Private Function ParseString(theStart)
 dim stemp
	if (theStart<>empty) then
		stemp=trim(theStart)
		stemp=replace(stemp,"""", "&quot;")
		stemp=replace(stemp,"'","&#039;")		
	end if
 ParseString=stemp
End function

Private Function UnParseString(theStart)
 dim stemp
	if (theStart<>empty) then
		stemp=trim(theStart)
		stemp=replace(stemp, "&quot;","""")
		stemp=replace(stemp,"&#039;","'")		
	end if
 UnParseString=stemp
End function

Private Function getData(selectedField,tableName,whereField,whereValue)
		dim sql
		temp= ""
		tmpArray=split(selectedField,",") 				
		if selectedField="" or tableName="" or whereField="" or whereValue="" then getData=""
		sql ="select distinct "	& selectedField	& " from "& tableName& " where "& whereField
		if instr(whereValue,",") > 0 then
			sql =sql& " in (" & whereValue & ")"
		 else 		
			sql =sql& " = '" & whereValue & "'"
		end if
		'resend sql
		set rec=conn.execute(sql)
			while not rec.eof
				for i = 0 to ubound(tmpArray) 
					temp =temp& "$" & rec(i)
				next
				rec.movenext			
			wend
		if len(temp) > 1 then temp = mid(temp,2,len(temp))
		closers(rec)
		getData=temp
End function

Private Function getTextData(selectedField,tableName,whereField,whereValue)
		dim sql
		temp= ""
		tmpArray=split(selectedField,",") 				
		if selectedField="" or tableName="" or whereField="" or whereValue="" then getTextData=""
		sql ="select "	& selectedField	& " from "& tableName& " where "& whereField
		if instr(whereValue,",") > 0 then
			sql =sql& " in (" & whereValue & ")"
		 else 		
			sql =sql& " = '" & whereValue & "'"
		end if
		'resend sql
		set rec=conn.execute(sql)
			while not rec.eof
				for i = 0 to ubound(tmpArray) 
					temp =temp& "$" & rec(i)
				next
				rec.movenext			
			wend
		if len(temp) > 1 then temp = mid(temp,2,len(temp))
		closers(rec)
		getTextData=temp
End function

Private Function getSingleData(selectedField,tableName)
		dim sql
		temp= ""
		tmpArray=split(selectedField,",") 				
		if selectedField="" or tableName="" then getSingleData=""
		sql ="select "	& selectedField	& " from "& tableName
		'resend sql
		set rec=conn.execute(sql)
			while not rec.eof
				for i = 0 to ubound(tmpArray) 
					temp =temp& "$" & rec(i)
				next
				rec.movenext			
			wend
		if len(temp) > 1 then temp = mid(temp,2,len(temp))
		closers(rec)
		getSingleData=temp
End function

Private Function gotSelect(tableName,tableField,selected,sqlWhere)
	dim sql,temp,SelectValue,SelectName
	temp= ""		
	if selected <> "" then hasSelect = true
	sql="select "& tableField & " from " & tableName
	if sqlWhere<>"" then sql = sql&" where " & sqlWhere

	set rs=conn.execute (sql)
	while not rs.eof
		SelectValue=rs(0)
		SelectName=rs(1)
		temp = temp & "<option value ='"
		temp = temp & SelectValue
		temp = temp & "'"
		if selected<>"" then 
			if cstr(SelectValue)=cstr(selected) then temp = temp&" selected"
			temp = temp & ">"
			if hasSelect then temp =temp& "&nbsp;&nbsp;"
				temp =temp&SelectName
				temp =temp& ("</option>\n")
		else
			temp = temp & ">"
			temp =temp&SelectName
			temp =temp& ("</option>\n")
		end if
		rs.movenext	
	wend
	rs.close
	set rs=nothing
	gotSelect=temp
End function

Private Function getSelect(tableName,tableField,selected)
	dim sql,temp,SelectValue,SelectName
	temp= ""		
	if selected <> "" then hasSelect = true
	sql="select "& tableField & " from " & tableName
	set rs=conn.execute (sql)
	while not rs.eof
		SelectValue=rs(0)
		SelectName=rs(1)
		temp = temp & "<option value ='"
		temp = temp & SelectValue
		temp = temp & "'"
		if selected<>"" then 
			if Cstr(SelectValue)=Cstr(selected) then temp = temp&" selected"
			temp = temp & ">"
			if hasSelect then temp =temp& "&nbsp;&nbsp;"
				temp =temp&SelectName
				temp =temp& ("</option>\n")
		else
			temp = temp & ">"
			temp =temp&SelectName
			temp =temp& ("</option>")
		end if
		rs.movenext	
	wend
	rs.close
	set rs=nothing
	res temp
End function

function IsInArray(str,target) '判断target是否在str里面
	if instr(str,",")>0 then
		temp=split(str,",")
		for i=0 to ubound(temp)
			if target=Cint(temp(i)) then IsInArray="checked"
		next
	end if
End function

function IsChecked(str)
	if str then
		IsChecked="checked"
	end if
End function

function parse(s)
	if len(s)=1 then s = "0" & s
	parse=s
End function

function getFileString()	
	dim file_name,file_name_str
	file_name_str=cstr(rnd(5)*1000000)
   	file_name=left(file_name_str,6)
    file_name=year(now)&parse(month(now))&parse(day(now))&parse(hour(now))&parse(minute(now))&parse(second(now))&"_"&file_name
	getFileString=file_name
End function

function upstring(str,l)
	dim temp
	temp=str
	if len(str)>l then temp=left(str,l)&"..."
	upstring=temp
end function

function time_array(t)
Dim tArray
tArray = Split(t, " ", -1, 1) 
time_array=tArray(0)
end function

function Timg(url)	
	if instr(request.ServerVariables("REMOTE_ADDR"),"211.147.225.34")>0 then
		url="../web/big5/"+url
	end if
	Timg=url
end function

function cutImg(str)	
	'res(instr(str,"<IMG"))
	if instr(str,"<IMG")>0 then	
		'str=left(0,instr(str,"<IMG"))&right(instr(str,">"),len(str))
		str=replace(str,"<", "&lt;")
		str=replace(str,">", "&gt;")
	end if
	cutImg=str
end function

Sub ResEnd(sql)
	res(sql)
	response.End()
End Sub

Sub Res(sql)
	response.Write(sql)
End Sub

Sub ShowMsg(txt)
	res("<SCRIPT LANGUAGE=javascript>alert('" & txt & "');history.back();</script>")
End Sub

Sub GoMsg(txt,URL)
	res("<SCRIPT LANGUAGE=javascript>alert('" & txt & "');location.href='" & URL & "';</script>")
End Sub
%>