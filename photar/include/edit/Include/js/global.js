onload=onStartPage;

// Ŀ�ģ� 
//		��pageTop��ʹ�õ�js, ������pageTop��.
//		��pageLeft��ʹ�õ�js, ������pageLeft��.
//		�ڱ�ҳ��ʹ�õ�js, ������ ��ҳ ��.
function onStartPage(){
	
	try{onStartPageTop();}catch(Exception){}
	try{onStartPageLeft();}catch(Exception){}
	try{onStart();}catch(Exception){}
}


var url=document.location.href;
url=url.substring(0,url.lastIndexOf('/')+1);
