function openWin(f,n,w,h,s){
	sb = s == "1" ? "1" : "0";
	l = (screen.width - w)/2;
	t = (screen.height - h)/2;
	if(!w) {
		sFeatures = "fullscreen=yes,center=1,scrollbars=1,status=0,directories=0,channelmode=0";
	} else {
		sFeatures = "left="+ l +",top="+ t +",height="+ h +",width="+ w
		+ ",center=1,scrollbars=" + sb + ",status=0,directories=0,channelmode=0";
	}
	openwin = window.open(f , n , sFeatures );
	
	//window.open原本是三个参数-> window.open(pageURL, name, parameters)
	//其中， pageURL为子窗口路径， name为子窗口句柄， parameters为窗口参数(各参数用逗号分隔)
	//window.open ('page.html','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') 
}