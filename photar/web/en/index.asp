<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="index.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
function jumpMenu(a,b){
	eval(a+".location.href='"+b.value+"'");
}
-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="top.asp"-->
<table height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> <table border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="1004" height="200">
              <param name="movie" value="flash/photar.swf">
              <embed src="flash/photar.swf" width="1004" height="200" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed></object></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="1"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="4" bgcolor="E7E3E7"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
  </tr>
</table>
<table width="930" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="190" valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><div align="center"><a href="invest.asp"><img src=<%=Timg("images/index_left0.gif")%> width="177" height="53" border="0"></a></div></td>
        </tr>
        <tr> 
          <td><div align="center"><a href="#"><img src=<%=Timg("images/index_left1.gif")%> width="177" height="53" border="0"></a></div></td>
        </tr>
        <tr> 
          <td><div align="center"><a href="http://211.147.225.34/gate/big5/www.chinaphotar.com/web/user.asp"><img src=<%=Timg("images/index_left3.gif")%> width="177" height="53" border="0"></a></div></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="177" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><div align="center"><a href="sell2.asp"><img src=<%=Timg("images/flash_adv_up.gif")%> width="177" height="23" border="0"></a></div></td>
        </tr>
        <tr> 
          <td width="150" height="100" background="images/flash_adv_d.gif"> 
            <div align="center"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="177"> 
                    <table border="0" align="center" cellpadding="15" cellspacing="0">
                      <tr>
                        <td width="150"> <div align="center" onClick="javascript:location.href='sell2.asp'" onMouseOver="">
                            <iframe src="adv.asp" width="150" height="150" scrolling="no" frameborder="0" align="middle"></iframe>
                          </div></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              
            </div></td>
        </tr>
        <tr> 
          <td><img src=<%=Timg("images/flash_adv_down.gif")%> width="177" height="15"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><font color="F78E00" class="font14">  <br>
<br>
<br>
&nbsp;&nbsp;Visit Members Site Of Photar 
            Group</font><br>
            <br><div align="center">
              <select name="goto" onChange="jumpMenu('this',this)" style="width:196;font-size: 7pt;">
                <% 
		  sql="select SiteName,URL from friendsiteinfo where ischeck=1 and english=1"
		  set rs=conn.execute(sql)
		  while not rs.eof
		  %>
                <option value="<%= rs("URL") %>"><%= rs("SiteName") %></option>
                <%  	
			rs.movenext
		  wend
		  rs.close
		   %>
              </select>
          </div></td>
        </tr>
      </table></td>
    <td width="740" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><div align="center"> </div></td>
        </tr>
      </table> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="720" border="0" align="center" cellpadding="1" cellspacing="0">
                    <tr> 
                      <td bgcolor="#CCCCCC"> 
                        <table width="720" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td height="25" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="5%"> 
                                    <div align="right"><img src="images/biao4.gif" width="22" height="22"></div></td>
                                  <td width="95%" height="30"><font color="F78E00" class="font14">Important 
                                    News </font></td>
                                </tr>
                              </table>
                              <table width="680" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td height="1" bgcolor="BFE1FF"><img src="images/blank.gif" width="1" height="1"></td>
                                </tr>
                              </table> </td>
                          </tr>
                          <tr> 
                            <td bgcolor="#FFFFFF"><table width="90%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td height="5"><img src="images/blank.gif" width="1" height="1"></td>
                                </tr>
                              </table> 
                              <table width="680" border="0" align="center" cellpadding="0" cellspacing="0">
                                <% 
							ImgURL=getdata("ImgURL","Newsinfo","cateid","3")
							if ImgURL="$" then ImgURL="images/index_new.jpg"%>
                                <tr> 
                                  <td width="252" bgcolor="#FFFFFF"> 
                                    <div align="center">
                                      <table width="223" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr> 
                                          <td><script language="JavaScript1.2">

var slideshow_width=223 //SET IMAGE WIDTH
var slideshow_height=149 //SET IMAGE HEIGHT
var pause=1500 //SET PAUSE BETWEEN SLIDE (3000=3 seconds)

var fadeimages=new Array()
/*SET IMAGE PATHS. Extend or contract array as needed
fadeimages[0]="images/news_m1.jpg"
fadeimages[1]="images/news_m2.jpg"
fadeimages[2]="images/news_m3.jpg"
fadeimages[3]="images/news_m4.jpg"
////NO need to edit beyond here////////////*/
<% 
sql="select LogoURL from advertisement where cateid=4 and ischeck=1"
set rs=conn.execute(sql)
i=0
while not rs.eof
 %>
fadeimages[<%= i %>]="../../Uploadfiles/<%= rs("LogoURL") %>"
//fadeimages[1]="images/news_m2.jpg"
//fadeimages[2]="images/news_m3.jpg"
//fadeimages[3]="images/news_m4.jpg"
////NO need to edit beyond here/////////////
<% rs.movenext
i=i+1
wend
rs.close
 %>

var preloadedimages=new Array()
for (p=0;p<fadeimages.length;p++){
preloadedimages[p]=new Image()
preloadedimages[p].src=fadeimages[p]
}

var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1
var dom=document.getElementById&&navigator.userAgent.indexOf("Opera")==-1

if (ie4||dom)
document.write('<div style="position:relative;width:'+slideshow_width+';height:'+slideshow_height+';overflow:hidden"><div  id="canvas0" style="position:absolute;width:'+slideshow_width+';height:'+slideshow_height+';top:0;filter:alpha(opacity=10);-moz-opacity:10"></div><div id="canvas1" style="position:absolute;width:'+slideshow_width+';height:'+slideshow_height+';top:0;filter:alpha(opacity=10);-moz-opacity:10"></div></div>')
else
document.write('<img name="defaultslide" src="'+fadeimages[0]+'">')

var curpos=10
var degree=10
var curcanvas="canvas0"
var curimageindex=0
var nextimageindex=1


function fadepic(){
if (curpos<100){
curpos+=10
if (tempobj.filters)
tempobj.filters.alpha.opacity=curpos
else if (tempobj.style.MozOpacity)
tempobj.style.MozOpacity=curpos/100
}
else{
clearInterval(dropslide)
nextcanvas=(curcanvas=="canvas0")? "canvas0" : "canvas1"
tempobj=ie4? eval("document.all."+nextcanvas) : document.getElementById(nextcanvas)
tempobj.innerHTML='<img src="'+fadeimages[nextimageindex]+'">'
nextimageindex=(nextimageindex<fadeimages.length-1)? nextimageindex+1 : 0
setTimeout("rotateimage()",pause)
}
}

function rotateimage(){
if (ie4||dom){
resetit(curcanvas)
var crossobj=tempobj=ie4? eval("document.all."+curcanvas) : document.getElementById(curcanvas)
crossobj.style.zIndex++
var temp='setInterval("fadepic()",50)'
dropslide=eval(temp)
curcanvas=(curcanvas=="canvas0")? "canvas1" : "canvas0"
}
else
document.images.defaultslide.src=fadeimages[curimageindex]
curimageindex=(curimageindex<fadeimages.length-1)? curimageindex+1 : 0
}

function resetit(what){
curpos=10
var crossobj=ie4? eval("document.all."+what) : document.getElementById(what)
if (crossobj.filters)
crossobj.filters.alpha.opacity=curpos
else if (crossobj.style.MozOpacity)
crossobj.style.MozOpacity=curpos/100
}

function startit(){
var crossobj=ie4? eval("document.all."+curcanvas) : document.getElementById(curcanvas)
crossobj.innerHTML='<img src="'+fadeimages[curimageindex]+'">'
rotateimage()
}
	if (ie4||dom)
window.onload=startit
else
setInterval("rotateimage()",pause)
</script></td>
                                        </tr>
                                      </table>
                                    </div></td>
                                  <td width="1" bgcolor="#CCCCCC"><img src=<%=Timg("images/blank.gif")%> width="1" height="1"></td>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="6">
                                      <tr> 
                                        <td bgcolor="#FFFFFF"><font color="#666666" class="fonthr-18"><a href="news_show.asp?id=<%= getdata("id","Newsinfo","cateid","12") %>" class="a1" target="_blank" title="<%= getdata("subject","Newsinfo","cateid","12") %>"><%= upstring(gettextdata("content","Newsinfo","cateid","12"),150) %></a></font>
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td><div align="right"><font color="#999999"><strong><a href="news_show.asp?id=<%= getdata("id","Newsinfo","cateid","12") %>" class="a1" target="_blank" title="<%= getdata("subject","Newsinfo","cateid","12") %>"><font color="#999999">More...</font></a></strong></font></div></td>
                                            </tr>
                                          </table></td>
                                      </tr>
                                    </table></td>
                                </tr>
                              </table>
                              <table width="90%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td height="5"><img src="images/blank.gif" width="1" height="1"></td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            
          </td>
        </tr>
      </table>
      <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="720" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="1" colspan="5" bgcolor="CEC6CE"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td width="1" bgcolor="CEC6CE"><img src="images/blank.gif" width="1" height="1"></td>
          <td width="475"><table width="456" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="5%"><div align="right"><img src="images/biao4.gif" width="22" height="22"></div></td>
                      <td width="95%" height="30"><font color="F78E00" class="font14">News 
                        Dynamic</font></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td height="1" colspan="2" bgcolor="F7FFFF"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="1" colspan="2" bgcolor="D6DBDE"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
<% 
sql="select top 5 * from Newsinfo where isCheck=1 and english=1 and cateid=11 order by modified desc"
set rs=conn.execute(sql) 
for i=0 to 4
 %>		
<% 
   if i=4 then
%>
              <tr> 
                <td width="381" height="30">&nbsp;&nbsp;<img src="images/biao5.gif" width="3" height="5">&nbsp;<a href="news_show.asp?id=<%= rs("id") %>" class="a1" target="_blank" title="<%= rs("subject") %>"><%= upstring(rs("subject"),58) %></a> <font color="#666666" class="fonthr-18"><!-- (<%= left(rs("modified"),instr(rs("modified")," ")-1) %>) --></font></td>
                <td width="75"><strong><a href="news.asp" target="_blank"><font color="#999999">More..</font></a></strong></td>
              </tr>
              <tr> 
                <td height="1" colspan="2" bgcolor="EFEBEF"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
<%else%>
              <tr> 
                <td height="30" colspan="2">&nbsp;&nbsp;<img src="images/biao5.gif" width="3" height="5">&nbsp;<a href="news_show.asp?id=<%= rs("id") %>" class="a1" target="_blank" title="<%= rs("subject") %>"><%= upstring(rs("subject"),58) %></a> <font color="#666666" class="fonthr-18"><!-- (<%= left(rs("modified"),instr(rs("modified")," ")-1) %>) --></font></td>
              </tr>
              <tr> 
                <td height="1" colspan="2" bgcolor="EFEBEF"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
<% end if %>			
<% 
rs.movenext
next
closers(rs)
%>					
            </table></td>
          <td width="1" bgcolor="CEC6CE"><img src="images/blank.gif" width="1" height="1"></td>
          <td width="242" valign="top"> <table width="225" border="0" align="center" cellpadding="3" cellspacing="0">
              <tr> 
                <td height="30"><strong><font color="00A6BD">Active Image</font> 
                  <font color="00AE9C">&gt;&gt;</font></strong></td>
              </tr>
              <tr> 
                <td width="225">
				<div align="center"> 
                 <iframe src="act.asp" width="216" height="162" scrolling="no" frameborder="0" align="middle"></iframe>
                </div>
				</td>
              </tr>
            </table></td>
          <td width="1" bgcolor="CEC6CE"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
      </table>
      <br>
      <table width="720" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="1" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><div align="center">
              <p align="left"><img src=images/example4_1.gif width="471" height="103" hspace="10" vspace="0" border="0" usemap="#Map2"></p>
            </div></td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
<map name="Map2">
  <area shape="rect" coords="2,4,79,128" href="contact.asp?field=users">
  <area shape="rect" coords="132,4,209,126" href="contact.asp?field=SiteMap">
  <area shape="rect" coords="265,4,343,123" href="contact.asp?field=management">
  <area shape="rect" coords="390,5,468,102" href="server.asp">
</map>
</body>
</html>
