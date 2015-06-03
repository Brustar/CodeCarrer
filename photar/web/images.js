var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1;
var dom=document.getElementById&&navigator.userAgent.indexOf("Opera")==-1;
var curcanvas="";
var canvas="";
var curimageindex=0;
var nextimageindex=1;
var curpos=10;
var degree=10;
var fadeimages=new Array();
var tempobj;
var pause;
var dropslide;

function img(images,slideshow_width,slideshow_height,pau,div){
var preloadedimages=new Array();
fadeimages=images;
curcanvas=div+"0";
canvas=div;
pause=pau;
var outhtml="";
for (p=0;p<fadeimages.length;p++){
	preloadedimages[p]=new Image();
	preloadedimages[p].src=fadeimages[p];
}

if (ie4||dom){
	var div0=curcanvas;
	var div1=canvas+"1";
	outhtml='<div style="position:relative;width:'+slideshow_width+';height:'+slideshow_height+';overflow:hidden"><div id='+div0+' style="position:absolute;width:'+slideshow_width+';height:'+slideshow_height+';top:0;filter:alpha(opacity=10);-moz-opacity:10"></div><div id='+div1+' style="position:absolute;width:'+slideshow_width+';height:'+slideshow_height+';top:0;filter:alpha(opacity=10);-moz-opacity:10"></div></div>';
}else{
	outhtml='<img name="defaultslide" src="'+fadeimages[0]+'">';
}
document.write(outhtml);
if (ie4||dom)
	window.onload=startit;
else
	setInterval("rotateimage()",pause);
}

function fadepic(){
	var div0=curcanvas;
	var div1=canvas+"1";
	if (curpos<100){
		curpos+=10
		if (tempobj.filters)
			tempobj.filters.alpha.opacity=curpos
		else if (tempobj.style.MozOpacity)
			tempobj.style.MozOpacity=curpos/100
	}else{
		clearInterval(dropslide)
		nextcanvas=(curcanvas==div0)? div0 : div1
		tempobj=ie4? eval("document.all."+nextcanvas) : document.getElementById(nextcanvas)
		tempobj.innerHTML='<img src="'+fadeimages[nextimageindex]+'">'
		nextimageindex=(nextimageindex<fadeimages.length-1)? nextimageindex+1 : 0
		setTimeout("rotateimage()",pause)
	}
}

function rotateimage(){
	var div0=curcanvas;
	var div1=canvas+"1";
	if (ie4||dom){
		resetit(curcanvas)
		var crossobj=tempobj=ie4? eval("document.all."+curcanvas) : document.getElementById(curcanvas)
		crossobj.style.zIndex++
		var temp='setInterval("fadepic()",50)'
		dropslide=eval(temp)
		curcanvas=(curcanvas==div0)? div1 : div0
	}else
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
	var temcan=curcanvas;
	var crossobj=ie4? eval("document.all."+temcan) : document.getElementById(temcan)
	crossobj.innerHTML='<img src="'+fadeimages[curimageindex]+'">'
	rotateimage()
}			  