/***************************/
//@Author: Adrian "yEnS" Mato Gondelle
//@website: www.yensdesign.com
//@email: yensamg@gmail.com
//@license: Feel free to use it, but keep this credits please!
/***************************/

//SETTING UP OUR POPUP
//0 means disabled; 1 means enabled;
var popupStatus = 0;

//loading popup with jQuery magic!
function loadPopup(){
	//loads popup only if it is disabled
	if(popupStatus==0){
		$("#backgroundPopup").css({
			"opacity": "0.7"
		});
		$("#backgroundPopup").fadeIn("slow");
		$("#popupContact").fadeIn("slow");
		popupStatus = 1;
	}
}

//disabling popup with jQuery magic!
function disablePopup(){
	//disables popup only if it is enabled
	if(popupStatus==1){
		$("#backgroundPopup").fadeOut("slow");
		$("#popupContact").fadeOut("slow");
		popupStatus = 0;
	}
}

//centering popup
function centerPopup(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("#popupContact").height();
	var popupWidth = $("#popupContact").width();
	//centering
	$("#popupContact").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});

	$("#backgroundPopup").css({
		"height": windowHeight
	});

}


$(document).ready(function(){

	$("#ccv").click(function(){
		//centering with css
		centerPopup();
		//load popup
		loadPopup();

        return false;
	});

	$("#popupContactClose").click(function(){
		disablePopup();
	});

	$("#backgroundPopup").click(function(){
		disablePopup();
	});

	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup();
		}
	});

});

/* ------------------------------------------------- */

/***************************/
//@Author: Adrian "yEnS" Mato Gondelle
//@website: www.yensdesign.com
//@email: yensamg@gmail.com
//@license: Feel free to use it, but keep this credits please!
/***************************/

//SETTING UP OUR POPUP
//0 means disabled; 1 means enabled;
var waitingStatus = 0;

//loading popup with jQuery magic!
function loadWaiting(){
	//loads popup only if it is disabled
	if(waitingStatus ==0){
		$("#backgroundPopup").css({
			"opacity": "0.7"
		});
		$("#backgroundPopup").fadeIn("slow");
        centerWaitingPopup();
		$("#waitingWheel").fadeIn("slow");
		waitingStatus = 1;
	}
}

//disabling popup with jQuery magic!
function disableWaiting(){
	//disables popup only if it is enabled
	if(popupStatus==1){
		$("#backgroundPopup").fadeOut("slow");
		$("#waitingWheel").fadeOut("slow");
		waitingStatus = 0;
	}
}

//centering popup
function centerWaitingPopup(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("#waitingWheel").height();
	var popupWidth = $("#waitingWheel").width();
	//centering
	$("#waitingWheel").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});

	$("#backgroundPopup").css({
		"height": windowHeight
	});

}