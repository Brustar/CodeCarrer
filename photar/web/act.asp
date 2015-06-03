<!--#include file="../include/database.asp"-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="JavaScript1.2">

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
sql="select LogoURL from advertisement where cateid=5 and ischeck=1"
set rs=conn.execute(sql)
i=0
while not rs.eof
 %>
fadeimages[<%= i %>]="../Uploadfiles/<%= rs("LogoURL") %>"
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
</script>