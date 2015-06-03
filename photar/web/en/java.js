<!--
document.ns = navigator.appName == "Netscape"
//--
var rnumx1=new Array();
var rnumx2;
var rnumx3;
rnumxtemp="";
for(i=0;i<3;i++){
rnumx2 =Math.round(Math.random()*10);
rnumx2!=10 ? rnumx3=rnumx2:rnumx3=9;
//document.write("["+rnumx3+"]");
rnumx1[i]=rnumx3;
if (rnumx1[0]>4||rnumx1[0]<1){
rnumx1[0]=1;
}
if (rnumx1[1]>2&&rnumx1[0]==4){
	rnumx1[1]=1;
	}
rnumxtemp+=new String(rnumx1[i]);
}
//--
window.screen.width>800 ? imgheight=550:imgheight=rnumxtemp
window.screen.width>800 ? imgright=0:imgright=0
window.screen.width>800 ? imgleft=1:imgleft=1
function threenineload()
{
if (navigator.appName == "Netscape")
{
if(document.getElementById) {
	document.getElementById('threenine').pageY=pageYOffset+window.innerHeight-imgheight;
	document.getElementById('threenine').pageX=imgright;
	document.getElementById('threenine1').pageY=pageYOffset+window.innerHeight-imgheight;
	document.getElementById('threenine1').pageX=imgleft;

} else {
	document.threenine.pageY=pageYOffset+window.innerHeight-imgheight;
	document.threenine.pageX=imgright;
	document.threenine1.pageY=pageYOffset+window.innerHeight-imgheight;
	document.threenine1.pageX=imgleft;
}
threeninemove();
}
else
{
threenine.style.top=document.body.scrollTop+document.body.offsetHeight-imgheight;
threenine.style.right=imgright;
threenine1.style.top=document.body.scrollTop+document.body.offsetHeight-imgheight;
threenine1.style.left=imgleft;
threeninemove();
}
}
function threeninemove()
{
if(document.ns)
{
if(document.getElementById) {
	document.getElementById('threenine').style.top=pageYOffset+window.innerHeight-imgheight
	document.getElementById('threenine').style.right=imgright;
	document.getElementById('threenine1').style.top=pageYOffset+window.innerHeight-imgheight
	document.getElementById('threenine1').style.left=imgleft;
} else {
	document.threenine.top=pageYOffset+window.innerHeight-imgheight
	document.threenine.right=imgright;
	document.threenine1.top=pageYOffset+window.innerHeight-imgheight
	document.threenine1.left=imgleft;
}
setTimeout("threeninemove();",40)
}
else
{
threenine.style.top=document.body.scrollTop+document.body.offsetHeight-imgheight;
threenine.style.right=imgright;
threenine1.style.top=document.body.scrollTop+document.body.offsetHeight-imgheight;
threenine1.style.left=imgleft;
setTimeout("threeninemove();",80)
}
}
function MM_reloadPage(init) { //reloads the window if Nav4 resized
if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true)
{
if (screen.width>800){ //判断分辨率,小于1024则不显示
document.write('<div id=threenine1 ></div>');
document.write('<div id=threenine style="position:absolute; right:0; top:250px; height:40px; z-index:20;; visibility: visible; width: 226;">');
document.write('<iframe src="news1.asp" width=100% height=365 frameborder=0 marginheight=0 marginwidth=0 scrolling=no></iframe>');
document.write('</div>');
threenineload()
}
}
//-->