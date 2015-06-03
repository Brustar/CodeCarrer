<!--#include file="../include/database.asp"-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script src="images.js"></script>
<script>
var fadeimages2=new Array();
<% 
sql="select LogoURL from advertisement where cateid=5 and ischeck=1"
set rs=conn.execute(sql)
i=0
while not rs.eof
 %>
fadeimages2[<%= i %>]="../Uploadfiles/<%= rs("LogoURL") %>"
//fadeimages[1]="images/news_m2.jpg"
//fadeimages[2]="images/news_m3.jpg"
//fadeimages[3]="images/news_m4.jpg"
////NO need to edit beyond here/////////////
<% rs.movenext
i=i+1
wend
rs.close
 %>
//fadeimages2[0]="images/act_1.jpg";
//fadeimages2[1]="images/act_2.jpg";
//fadeimages2[2]="images/act_3.jpg";
//fadeimages2[3]="images/act_4.jpg";
//fadeimages2[4]="images/act_5.jpg";
//fadeimages2[5]="images/act_6.jpg";
//fadeimages2[6]="images/act_7.jpg";
//fadeimages2[7]="images/act_8.jpg";
img(fadeimages2,216,162,1000,"b");	
</script>