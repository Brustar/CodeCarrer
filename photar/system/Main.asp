

<%@ Language=VBScript %>
<%if Session("Userid")="" then
	 Response.Write "?Tè¨2é?′"
	 Response.End 
  end if
%>
<%
 '今天事项的标题信息
 '2001-10-09 Saidy Chen
 'hesigong@sina.com
 function ViewTodayTitle
    Dim v_E_ID,v_Title,v_BeginTime
    Dim Obj,Rs
    Dim v_mode,v_date,v_month,v_year
    
    set Obj = server.CreateObject ("EventDate.DataConnection")
    Set Rs = Obj.ViewDetailToday (session("UserID"))
 %>
    <link rel="stylesheet" href="css/style.css" type="text/css">
 <%
	while Not Rs.EOF
	 Obj.sDetailToday_Return (rs)
	  v_E_ID = Obj.Event_IDViewDetailToday
	  v_Title =Obj.TitleViewDetailToday
	  v_BeginTime =Obj.BeginTimeViewDetailToday 
%>		
    <tr> 
    <td  width="8"></td>
    <td width="5"><img src="img/jt.gif" width="11" height="11"></td>
    <td width="40%" class="cpx12black">
      <% =Now()%>
    </td>
    <td width="47%" class="cpx12black">
       <a href="../personal/eventdate/events.asp?E_ID=<% =v_E_ID%>" class="cpx12black"><%=v_Title%></a>
    </td>
   </tr>
 <%
 	  rs.MoveNext
	wend
	set rs = nothing
	set obj=nothing
end function
%>

<html>
<head>
<script LANGUAGE="javascript">
<!--
function ShowNews(newsid,newscateid)
{
	var win,url
	url="../BusinessMag/NewsInfor/ShowNews.asp?newsid="+newsid+"&newscateid="+newscateid
	win=window.open(url,'','width=550,height=400,scrollbars=1,left=0,top=0')
	win.focus()
}
	function checkform(item)
	{
		var SelectItem;
		var length=document.frmvote.elements.length;
		var radoindex;
		SelectItem="";
		for (var i=(length-1); i>=0; i--)
		{
			radoindex=document.frmvote.elements[i].name.indexOf("rad");
			if (radoindex>=0)
			{
				if (document.frmvote.elements(i).checked)
				{
					if (SelectItem=="")
					{
						SelectItem=document.frmvote.elements(i).value
					}
					else
					{
						SelectItem=SelectItem + document.frmvote.elements(i).value
					}
				}

			}
		}
		if (SelectItem=="")
		{
			window.alert("请选择投票意见");
		}
		else
		{
			var win,url;
			if (item.indexOf(SelectItem)>=0)
			{
				url="../BusinessMag/Vote/VoteOpinion.asp?voteitemid="+SelectItem;
				win=window.open(url,'','width=472,height=400,scrollbars=1,left=10,top=10')
			}
			else
			{
				url="../BusinessMag/Vote/VoteShow.asp?voteitemid="+SelectItem;
				win=window.open(url,'','width=472,height=400,scrollbars=1,left=10,top=10')
			}

		}
	}
	function linktoshow(item)
	{	
		var win,url;
		url="../BusinessMag/Vote/VoteShow.asp?voteitemid="+item+"&show="+"yes";
		win=window.open(url,'','width=472,height=400,scrollbars=1,left=10,top=10')
	}

//-->
</script>

<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>

<body bgcolor="#0C89A7" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
  <tr> 
    <td valign="top" align="center">
      <table width="96%" border="0" cellpadding="0" cellspacing="10">
        <tr> 
          <td valign="top"> 
            <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="100%">
              <tr> 
                <td width="100%"> 
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr> 
                      <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="150"> 
                        <p class="efontpx10" align="center">&nbsp; 
                      </td>
                      <center>
                        <td align="left" background="../img/fomr1.files/oa_menu_from1_02a.gif" bgcolor="#E6E6E6"><img src="../img/fomr1.files/oa_menu_from1_02_new.gif" width="30" height="18"></td>
                        <td width="24"><img src="../img/fomr1.files/oa_menu_from1_05_no.gif" width="24" height="18" alt="关闭窗口"></td>
                      </center>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="100%" bgcolor="#E6E6E6"> 
                  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr> 
                      <td colspan="3" bgcolor="#FFFFFF"> <img src="../img/fomr3.files/oa_menu_from3_01.gif" width="218" height="1"></td>
                    </tr>
                    <tr> 
                      <td width="7" background="../img/fomr3.files/oa_menu_from3_02.gif"> 
                        <img border="0" src="../img/images/tls.gif" width="7" height="1"></td>
                      <td bgcolor="#E6E6E6" width="100%" align="center"> 
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="23">
                          <tr> 
                            <td width="95"><img src="img/lbgg.gif" width="95" height="23"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                          <%
							set objNew=server.CreateObject("ObjChinaskyOA.News")
							set rsNew=objNew.rsGetNewsInfo("ADO","MAIN")
							while not rsNew.eof 
								objNew.DataFromAdo(rsNew)
                        %>
                          <tr> 
                            <td align="right" width="10">&nbsp; </td>
                            <td align="center" width="20"><img src="img/jt.gif" width="11" height="11"></td>
                            <%if objNew.IsNew then%>
                            <td align="left" class="cpx12black"><%=month(objNew.AddDate)%>/<%=day(objNew.AddDate)%>&nbsp;<%=hour(objNew.AddDate)%>:<%=Minute(objNew.AddDate)%></td>
                            <td><a href="javascript:ShowNews(<%=objNew.NewsID%>,<%=objNew.News_Cate_ID%>)" class="cpx12black"><%=objNew.Title%></a>&nbsp;☆New</td>
                            <%else%>
                            <td align="left" class="cpx12black"><%=month(objNew.AddDate)%>/<%=day(objNew.AddDate)%>&nbsp;<%=hour(objNew.AddDate)%>:<%=Minute(objNew.AddDate)%></td>
                            <td><a href="javascript:ShowNews(<%=objNew.NewsID%>,<%=objNew.News_Cate_ID%>)" class="cpx12black"><%=objNew.Title%></a></td>
                            <%end if%>
                          </tr>
                          <%
							rsNew.movenext
							wend
							set rsNew=nothing
							set objNew=nothing
                       %>
                        </table>
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
                          <tr> 
                            <td width="95"><img src="img/ltxt.gif" width="96" height="22"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                          <%
                        set objBBs=server.CreateObject("BBS.BBSContent")
                        set rsBBs=objBBs.rsGetDiscussionInfo("ADO","MAIN")
                        while not rsBBs.eof
							objbbs.DataFromAdo(rsBBS)
							length1=len(objbbs.Title)
							if length1>11 then
								title=mid(objbbs.Title,1,9)
								title=title & "..."
							else
								title=objbbs.Title 
							end if
                        %>
                          <tr> 
                            <td align="right" width="10">&nbsp; </td>
                            <td align="center" width="20"><img src="img/jt.gif" width="11" height="11"></td>
                            <td align="left" class="cpx12black"><%=month(objbbs.PublishDate)%>/<%=day(objbbs.PublishDate)%>&nbsp;<%=hour(objbbs.PublishDate)%>:<%=Minute(objbbs.PublishDate)%>&nbsp;</td>
                            <td><a href="../BBS/BBSChiled.asp?updiscussionid=<%=objbbs.DiscussionID%>&amp;teamid=<%=teamid%>" class="cpx12black"><%=title%></a> 
                              &nbsp;</td>
                            <td align="left" class="cpx12black"><%=objbbs.LoveName%> 
                            </td>
                          </tr>
                          <%
							rsbbs.movenext
							wend
							set rsbbs=nothing
							set objbbs=nothing
                        %>
                        </table>
                      </td>
                      <td background="../img/fomr3.files/oa_menu_from3_04.gif" width="7"><img border="0" src="../img/images/tls.gif" width="7" height="1"> 
                        　</td>
                    </tr>
                    <tr> 
                      <td width="7"> <img src="../img/fomr3.files/oa_menu_from3_05.gif" width="7" height="15"></td>
                      <td background="../img/fomr3.files/oa_menu_from3_06.gif" width="100%"> 
                        <img border="0" src="../img/images/tls.gif" width="7" height="1"></td>
                      <td width="7"> <img src="../img/fomr3.files/oa_menu_from3_07.gif" width="7" height="15"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <br>
          </td>
          <td valign="top"> 
            <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="100%">
              <tr> 
                <td width="100%"> 
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr> 
                      <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="150"> 
                        <p class="efontpx10" align="center">&nbsp; 
                      </td>
                      <center>
                        <td align="left" background="../img/fomr1.files/oa_menu_from1_02a.gif" bgcolor="#E6E6E6"><img src="../img/fomr1.files/oa_menu_from1_02_new.gif" width="30" height="18"></td>
                        <td width="24"><img src="../img/fomr1.files/oa_menu_from1_05_no.gif" width="24" height="18" alt="关闭窗口"></td>
                      </center>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="100%" bgcolor="#E6E6E6"> 
                  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr> 
                      <td colspan="3" bgcolor="#FFFFFF"> <img src="../img/fomr3.files/oa_menu_from3_01.gif" width="218" height="1"></td>
                    </tr>
                    <tr> 
                      <td width="7" background="../img/fomr3.files/oa_menu_from3_02.gif"> 
                        <img border="0" src="../img/images/tls.gif" width="7" height="1"></td>
                      <td bgcolor="#E6E6E6" width="100%"> 
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
                          <tr> 
                            <td width="95"><img src="img/rwts.gif" width="96" height="22"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <%
							set objTask=server.CreateObject("objBLCS.TaskInfo")
							set rsTask=objTask.rsGetTaskInfo("ADO","EXCETASKCOUNT","3",cstr(Session("Userid")))
							newtaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","EXCETASKCOUNT","6",cstr(Session("Userid")))
							exectaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","EXCETASKCOUNT","9",cstr(Session("Userid")))
							notpasstaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","ARRANGETASKCOUNT",,cstr(Session("Userid")))
							arrangetaskcount=objTask.RecordCount
							set rsTask=nothing

							set rsTask=objTask.rsGetTaskInfo("ADO","CONFIRMTASKCOUNT",,cstr(Session("Userid")))
							confirmtaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","CHECKTASKCOUNT",,cstr(Session("Userid")))
							checktaskcount=objTask.RecordCount
							set rsTask=nothing
							
							'---内部任务单统计-----
							set rsTask=objTask.rsGetTaskInfo("ADO","INNEREXCETASKCOUNT","3",cstr(Session("Userid")))
							innernewtaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","INNEREXCETASKCOUNT","6",cstr(Session("Userid")))
							innerexectaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","INNEREXCETASKCOUNT","9",cstr(Session("Userid")))
							innernotpasstaskcount=objTask.RecordCount
							set rsTask=nothing
							
							set rsTask=objTask.rsGetTaskInfo("ADO","INNERMANAGERCOUNT")
							innermanagercount=objTask.RecordCount
							set rsTask=nothing

							set rsTask=objTask.rsGetTaskInfo("ADO","INNERCHECKTASKCOUNT",,cstr(Session("Userid")))
							innerchecktaskcount=objTask.RecordCount
							set rsTask=nothing
							'-----end----------
							set objTask=nothing
                        %>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr align="center"> 
                            <td width="10"></td>
                            <td class="cpx12black" align="left">→外部<font color="#FF0000">&nbsp;</font></td>
                            <td class="cpx12black"><font color="#FF0000">&nbsp;</font></td>
                            <td class="cpx12black"><font color="#FF0000">&nbsp;</font></td>
                            <td width="10"></td>
                          </tr>
                          <tr align="center"> 
                            <td width="10"></td>
                            <td class="cpx12black" align="left">&nbsp;&nbsp;新单<font color="#FF0000"><%=newtaskcount%></font>个</td>
                            <td class="cpx12black" align="left">执行中<font color="#FF0000"><%=exectaskcount%></font>个</td>
                            <td class="cpx12black" align="left">未通过验收<font color="#FF0000"><%=notpasstaskcount%></font>个</td>
                            <td width="10"></td>
                          </tr>
                          <tr align="center"> 
                            <td width="10"></td>
                            <td class="cpx12black" align="left">&nbsp;&nbsp;等待分配<font color="#FF0000"><%=arrangetaskcount%></font>个</td>
                            <td class="cpx12black" align="left">任务确认<font color="#FF0000"><%=confirmtaskcount%></font>个</td>
                            <td class="cpx12black" align="left">任务单验收<font color="#FF0000"><%=checktaskcount%></font>个</td>
                            <td width="10"></td>
                          </tr>
                          <tr align="center"> 
                            <td width="10"></td>
                            <td class="cpx12black" align="left">→内部<font color="#FF0000">&nbsp;</font></td>
                            <td class="cpx12black"><font color="#FF0000">&nbsp;</font></td>
                            <td class="cpx12black"><font color="#FF0000">&nbsp;</font></td>
                            <td width="10"></td>
                          </tr>  
                          <tr align="center"> 
                            <td width="10"></td>
                            <td class="cpx12black" align="left">&nbsp;&nbsp;新单<font color="#FF0000"><%=innernewtaskcount%></font>个</td>
                            <td class="cpx12black" align="left">执行中<font color="#FF0000"><%=innerexectaskcount%></font>个</td>
                            <td class="cpx12black" align="left">未通过验收<font color="#FF0000"><%=innernotpasstaskcount%></font>个</td>
                            <td width="10"></td>
                          </tr>
                          <tr align="center"> 
                            <td width="10"></td>
                            <td class="cpx12black" align="left">&nbsp;&nbsp;总监确认<font color="#FF0000"><%=innermanagercount%></font>个</td>
                            <td class="cpx12black" align="left">任务单验收<font color="#FF0000"><%=innerchecktaskcount%></font>个</td>
                            <td class="cpx12black" align="left">&nbsp;</td>
                            <td width="10"></td>
                          </tr>                        </table>
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
                          <tr> 
                            <td width="95"><img src="img/rcts.gif" width="96" height="22"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                        <%
							set objNote=server.CreateObject("objNoteBook.NoteBook")
							set rsNote=objNote.rsGetInfo("ADO","MAIN",cstr(Session("Userid")))
							while not rsNote.eof
								objNote.DataFromAdo(rsNote)
								length1=len(objNote.Title)
								if length1>11 then
									title=mid(objNote.Title,1,9)
									title=title & "..."
								else
									title=objNote.Title 
								end if
                        %>  
                         
                          <tr> 
                            <td align="right" width="10">&nbsp; </td>
                            <td align="center" width="30"><img src="img/jt.gif" width="11" height="11"></td>
                            <td align="left" class="cpx12black"><%=Month(objNote.NoteDate)&"月"&Day(objNote.NoteDate)&"日"%></td>
                            <td align="left" class="cpx12black"><a href="../Personal/NoteBookInfo.asp?bookid=<%=objNote.BookID%>" class="cpx12black"><%=title%></a></td>
                            <td align="left" class="cpx12black"><%=objNote.Field1%></td>
                          </tr>
                        <%
							rsNote.movenext
							wend
							set rsNote=nothing
							set objNote=nothing
                        %>
                        </table>
                        <!--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-->
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
                          <tr> 
                            <td width="95"><img src="img/rcts.gif" width="96" height="22"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                        <%
							ViewTodayTitle
                        %>
                        </table>
                        <!--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-->
                        
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
                          <tr> 
                            <td width="95"><img src="img/jlxx.gif" width="96" height="24"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                        <%
							set objMess=server.CreateObject("objMessage.sendmessage")
							set rsMess=objMess.rsGetSendMessageInfo("ADO","MAIN",cstr(Session("Userid")))
							while not rsMess.eof
								objMess.DataFromAdo(rsMess)
                        %>
                          <tr> 
                            <td align="right" width="10">&nbsp; </td>
                            <td align="center" width="30"><img src="img/jt.gif" width="11" height="11"></td>
                            <td align="left" class="cpx12black"><%=month(objMess.SendTime)&"/"&day(objMess.SendTime)%>&nbsp;<%=hour(objMess.SendTime)%>:<%=Minute(objMess.SendTime)%></td>
                            <td align="left" class="cpx12black"><a href="../Personal/MessageSend2.asp?Messageid=<%=objMess.MessageID%>" class="cpx12black"><%=objMess.Field1%></a></td>
                            <td align="left" class="cpx12black"><%=objMess.SendMan%></td>
                          </tr>
                          <%
							rsMess.movenext
							wend
							set rsMess=nothing
							set objMess=nothing
                        %>
                        </table>
                        <table width="98%" border="0" cellspacing="0" cellpadding="0" height="22">
                          <tr> 
                            <td width="95"><img src="img/xsts.gif" width="96" height="22"></td>
                            <td valign="bottom"> 
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr> 
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td background="img/bg.gif" height="1"><img src="img/bg.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        
                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                        <%set objSales=server.CreateObject("objBLCS.salesmsg")
						  set rsSales=objSales.rsGetSalesMsgInfo("ADO","CURRENT",cstr(Session("loginid")))
						while not rsSales.eof 
							objSales.DataFromAdo(rsSales)%>
                          <tr> 
                            <td align="right" width="10">&nbsp; </td>
                            <td align="center" width="30"><img src="img/jt.gif" width="11" height="11"></td>
                            <td align="left" class="cpx12black"><a href="#" class="cpx12black"><a HREF="../WorkMag/Sales/SalesList.asp" class="cpx12black"><%=objsales.Company%></a></td>
                          </tr>
                       <%
						 rsSales.movenext
						 wend
						 set rsSales=nothing
						 set objSales=nothing
                       %>
                        </table>
                      </td>
                      <td background="../img/fomr3.files/oa_menu_from3_04.gif" width="7"><img border="0" src="../img/images/tls.gif" width="7" height="1"> 
                        　</td>
                    </tr>
                    <tr> 
                      <td width="7"> <img src="../img/fomr3.files/oa_menu_from3_05.gif" width="7" height="15"></td>
                      <td background="../img/fomr3.files/oa_menu_from3_06.gif" width="100%"> 
                        <img border="0" src="../img/images/tls.gif" width="7" height="1"></td>
                      <td width="7"> <img src="../img/fomr3.files/oa_menu_from3_07.gif" width="7" height="15"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <br>
            <table border="0" cellspacing="1" cellpadding="0" bgcolor="#000000" width="100%">
              <tr> 
                <td width="100%"> 
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr> 
                      <td bgcolor="#0C89A7" background="../img/fomr1.files/oa_menu_from1_01.gif" valign="middle" width="150"> 
                        <p class="unnamed1" align="center">问 卷 调 查 
                      </td>
                      <center>
                        <td align="left" background="../img/fomr1.files/oa_menu_from1_02a.gif" bgcolor="#E6E6E6"><img src="../img/fomr1.files/oa_menu_from1_02_new.gif" width="30" height="18"></td>
                        <td width="24"><img src="../img/fomr1.files/oa_menu_from1_05_no.gif" width="24" height="18" alt="关闭窗口"></td>
                      </center>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="100%" bgcolor="#E6E6E6"> 
                <%
					dim rs,rsitem,item
					item=""
					Set obj1 = CreateObject("objVote.vote")
					set obj=server.CreateObject("objVote.voteitem")
					set rs=obj1.rsGetVote ("ADO","CURRENT")
					obj1.DataFromAdo (rs)
					set rs=nothing
					set rsitem=obj.rsGetVoteItem ("ADO","ONE",cint(obj1.VoteID))
				%>
                  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr><form method="POST" name="frmvote">  
                      <td colspan="3" bgcolor="#FFFFFF"> <img src="../img/fomr3.files/oa_menu_from3_01.gif" width="218" height="1"></td>
                    </tr>
                    <tr> 
                      <td width="7" background="../img/fomr3.files/oa_menu_from3_02.gif"> 
                        <img border="0" src="../img/images/tls.gif" width="7" height="1"></td>
                      <td bgcolor="#E6E6E6" width="100%" align="center" class="cpx12black"><%=obj1.title %>
                        <table width="75%" border="0" cellspacing="0" cellpadding="0">
                        <%
							while not rsitem.EOF 
								obj.DataFromAdo (rsitem)
								if obj.ItemName<>"" and obj.ItemName<>"0" then
						%>
                          <tr>
                            <td class="cpx12black"><input type="radio" name="radio1" value="<%=obj.VoteItemID%>"><%=obj.ItemName%></td> 
                          </tr>
                        <%
								items=obj.VoteItemID 
								if obj.OpinionCheck then
									if item="" then
										item=obj.VoteItemID 
									else
										item=item & "," & obj.VoteItemID 
									end if
								end if
								end if
								rsitem.movenext
								wend
								set obj=nothing
								set obj1=nothing
						%>
                        </table>
                        <input type="button" value="就这么定了" class="button" name="button1" onClick="javascript:checkform('<%=item%>')">
                        <input type="button" name="button2" value="看看别人什么主意" class="button" onClick="javascript:linktoshow('<%=items%>')">
                      </td></form>
                      <td background="../img/fomr3.files/oa_menu_from3_04.gif" width="7"><img border="0" src="../img/images/tls.gif" width="7" height="1"> 
                        　</td>
                    </tr>
                    <tr> 
                      <td width="7"> <img src="../img/fomr3.files/oa_menu_from3_05.gif" width="7" height="15"></td>
                      <td background="../img/fomr3.files/oa_menu_from3_06.gif" width="100%"> 
                        <img border="0" src="../img/images/tls.gif" width="7" height="1"></td>
                      <td width="7"> <img src="../img/fomr3.files/oa_menu_from3_07.gif" width="7" height="15"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
