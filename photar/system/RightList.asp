<!-- #include FILE="../include/StringParse.asp" -->
<!-- #include FILE="../include/UserCheck.asp" -->
<!-- #include FILE="../include/RightTree.asp" -->
<%
dim showID,groupID,sql
showID=request("parentID")
groupID=request("groupID")
RightID=getdata("RightID","Groupinfo","id",groupID)
'response.Write(RightID)
%>
<html>
<head>
<SCRIPT LANGUAGE=javascript>
<!--
        function selectid()
        {
                var length=document.form1.elements.length;
                var chxindex;
                var selItemsString;
                var UnselItemsString;
                selItemsString="";
                UnselItemsString="";
                for (var i=(length-1); i>=0; i--)
                {
                        chxindex = document.form1.elements[i].name.indexOf("che");
                        {
                                if (chxindex>=0)
                                {
                                        if (document.form1.elements(i).checked)
                                        {
                                        if (selItemsString=="")
                                        {
                                                selItemsString=document.form1.elements(i).value;
                                        }
                                        else
                                        {
                                                selItemsString=selItemsString + "," +document.form1.elements(i).value;
                                        }
                                        }else
                                        {
                                        if (UnselItemsString=="")
                                        {
                                                UnselItemsString=document.form1.elements(i).value;
                                        }
                                        else
                                        {
                                                UnselItemsString=UnselItemsString + "," +document.form1.elements(i).value;
                                        }
                                        }
                                }
                        }
                }
                form1.SelStr.value=selItemsString;
                form1.UnSelStr.value =UnselItemsString;
                form1.submit();
        }
        function Do_Select(vdata)
        {
                var length=document.form1.elements.length;
                var checkMark;
                var checkValue;
                var num=vdata.indexOf(",");
                var temp1;
                var temp2;
                var j=0;
                temp2 = vdata.substring(0, num);
                while (num>0)
                {
                        for (var i=(length-1); i>=0; i--)
                        {
                                checkMark = document.form1.elements[i].name.indexOf("check");
                                checkValue = document.form1.elements[i].value;
                                if (checkMark>=0 && checkValue==temp2)
                                {
                                        document.form1.elements(i).checked=true;
                                }
                        }
                        j=num+1;
                        temp1 = vdata.substring(j, vdata.length);
                        num = temp1.indexOf(",")+j;
                        temp2 = vdata.substring(0, num);
                        if (temp1.indexOf(",")< 0)
                        {
                                num = temp1.indexOf(",");
                        }

                }
        }
        function Do_UnSelect(vdata)
        {
                var length=document.form1.elements.length;
                var checkMark;
                var checkValue;

                for (var i=(length-1); i>=0; i--)
                {
                        checkMark = document.form1.elements[i].name.indexOf("check");
                        checkValue = document.form1.elements[i].value;

                        if (checkMark>=0 && checkValue.indexOf(vdata)>=0)
                        {
                                document.form1.elements(i).checked=false;
                        }
                }

        }
        function Do_It(vdata)
        {
                var length=document.form1.elements.length;
                var checkMark;
                var checkValue;

                for (var i=(length-1); i>=0; i--)
                {
                        checkMark = document.form1.elements[i].name.indexOf("check");
                        checkValue = document.form1.elements[i].value;

                        if (checkMark>=0 && checkValue==vdata)
                        {
                                if (document.form1.elements(i).checked)
                                {
                                        Do_Select(vdata);
                                }else{
                                        Do_UnSelect(vdata);
                                }

                        }
                }

        }
//-->
</SCRIPT>

<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>系统管理</title>
<link rel="stylesheet" href="../include/style.css" type="text/css">
</head>
<body bgcolor="#0C89A7" leftmargin="0" topMargin="10" marginwidth="0" marginheight="0">
  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="95%" align="center">
      <tr>
        <td width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%">
            <tr>
              <td bgcolor="#0C89A7" valign="middle" width="200">
                <p class="unnamed1" align="center"><span class="unnamed1">系统权限组的模块设置</span>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td width="100%" bgcolor="#E6E6E6">
           <table width="85%" border="0" cellspacing="0" cellpadding="0" align="center">
            <form name=form1 action=RightEdit.asp method=post>
            <input type="hidden" name="SelStr">
            <input type="hidden" name="UnSelStr">
            <input type="hidden" name="groupID" value="<%=groupID%>">
            <input type="hidden" name="parentID" value="<%=showID%>">
              <tr>
                <td width="1" valign="top" background="../images/line_bg.gif"></td>
                <td>
<%
sql="select * from moduleinfo where parentid=0"
set rs=conn.execute(sql)
while not rs.eof
  dim moduleName,isModule,flag,moduleID,rightsID
  moduleName=rs("modulename")
  moduleID=rs("ID")
%>
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="cpx12black">
                        <table width="75%" border="0" cellspacing="0" cellpadding="0" height="5">
                          <tr>
                                                 <td></td>
                          </tr>
                        </table>

                  <img src="../images/file.gif" width="27" height="13" align="absmiddle"><%=moduleName%>
                     <INPUT type="checkbox" name="RightID" value="<%=moduleID%>" onclick="Do_It('<%=moduleID%>')" <%=IsInArray(RightID,moduleID)%>>
				   <% getRight(moduleID) %>
                </td>
                    </tr>
                  </table>

<%
rs.movenext
wend
closers(rs)
%>
                                 </td>
                </tr>
               </form>
               </table>
               <p align="center">
                                        <input type="button" value="提 交" name=button1 onClick="javascript:selectid();" class="button">&nbsp;&nbsp;
                                        <input type="reset" value="重 写" name=button1 onClick="javascript:form1.reset();" class="button">&nbsp;&nbsp;
                                        <input type="button" value="返 回" name=button1 onClick="javascript:history.back() ;" class="button">&nbsp;&nbsp;
               </p>
</body>
</html>
<% closeconn() %>