/* (c) 2019 by Henry Chen */

// Back to top
if (document.documentElement.scrollTop < 300) {
	document.getElementById("backtotop").setAttribute('hidden', 'true');
}

window.onscroll = function() {
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    if (scrollTop < 300) {
		document.getElementById("backtotop").setAttribute('hidden', 'true');
    } else {
        document.getElementById("backtotop").removeAttribute('hidden');
    }
}

function backToTop() {
    var duration = 150; // 返回顶部的时间
    var interval= 5;
    var target = document.documentElement.scrollTop || document.body.scrollTop;
    var step = (target/duration)*interval;
	
    var timer = window.setInterval(function() {
        var curTop = document.documentElement.scrollTop || document.body.scrollTop;
		
        if (curTop == 0) {
            window.clearInterval(timer);
        }
		
        curTop-=step;
        document.documentElement.scrollTop = document.body.scrollTop = curTop;
    },interval);
}



// insert year to copyright
var year = new Date().getFullYear();
var copyright = document.getElementById("copyright");
copyright.innerHTML = "&copy; " + year + " " + copyright.innerHTML;
