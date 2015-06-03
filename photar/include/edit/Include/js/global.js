onload=onStartPage;

// 目的： 
//		在pageTop中使用的js, 都放在pageTop中.
//		在pageLeft中使用的js, 都放在pageLeft中.
//		在本页中使用的js, 都放在 本页 中.
function onStartPage(){
	
	try{onStartPageTop();}catch(Exception){}
	try{onStartPageLeft();}catch(Exception){}
	try{onStart();}catch(Exception){}
}


var url=document.location.href;
url=url.substring(0,url.lastIndexOf('/')+1);
