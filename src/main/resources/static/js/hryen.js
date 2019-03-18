// Back to top
if (document.documentElement.scrollTop < 300) {
	document.getElementById("backToTop").setAttribute('hidden', 'true');
}

window.onscroll = function() {
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    if (scrollTop < 300) {
		document.getElementById("backToTop").setAttribute('hidden', 'true');
    } else {
        document.getElementById("backToTop").removeAttribute('hidden');
    }
};

function backToTop() {
    var duration = 150; // return to the top times
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


// comment start
// if article page, load comment-form author,email,url
var authorElement = document.getElementById('author');
var emailElement  = document.getElementById('email');
var urlElement  = document.getElementById('url');
if (null != authorElement) { authorElement.value = localStorage.getItem("author"); }
if (null != emailElement) { emailElement.value = localStorage.getItem("email"); }
if (null != urlElement) { urlElement.value = localStorage.getItem("url"); }

var parentId = null;

// Submit Comment
function submitComment(articleId) {

    var comment = new Object();
    comment.articleId = articleId;

    // replace wrap
    comment.content = document.getElementById('content').value
        .replace(/\r\n/g, '<br/>')
        .replace(/\n/g, '<br/>')
        .replace(/\s/g, ' ');

    // get form data
    comment.author = document.getElementById('author').value;
    comment.email  = document.getElementById('email').value;
    comment.url  = document.getElementById('url').value;

    if (null != parentId) { comment.parentId = parentId; }

    // check author
    if (null == comment.author || "" === comment.author.trim()) {
        document.getElementById('author').focus();
        return;
    }

    // check content
    if (null == comment.content || "" === comment.content.trim()) {
        document.getElementById('content').focus();
        return;
    }

    // save to localStorage
    localStorage.setItem("author", comment.author);
    localStorage.setItem("email", comment.email);
    localStorage.setItem("url", comment.url);

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("POST", "/api/comment/save", true);
    xmlhttp.setRequestHeader("Content-type","application/json");

    xmlhttp.send(JSON.stringify(comment)); // send json data

    xmlhttp.onreadystatechange = function() {
        if(xmlhttp.readyState==4 && xmlhttp.status==200) {
            var result = JSON.parse(xmlhttp.responseText);
            if(result.result) { window.location.reload(); } // submit ok, reload
        }
    }
}

// reply comment
function replyComment(id, author) {
    document.getElementById('submitComment').innerText = 'Reply @' + author;
    document.getElementById('cancelReply').removeAttribute('hidden');
    parentId = id;
    window.location = "#comment-form";
}

// cancel reply
function cancelReply() {
    document.getElementById('cancelReply').setAttribute('hidden', 'true');
    document.getElementById('submitComment').innerText = 'Comment';
    parentId = null;
}
// comment end



// jump page
// 监控jumpPageInput输入框回车事件
var jumpPageInput = document.getElementById("jumpPageInput");
if (null != jumpPageInput) {
    jumpPageInput.onkeydown = function(ev) {
        if (ev.keyCode == 13) {
            var pageNumber = jumpPageInput.value;
            // 如果不是空 则触发jumpPage()
            if ("" != pageNumber) {
                jumpPage();
            }
        }
    }
}

// 跳转到指定页数
function jumpPage() {
    // 获取跳转的页码
    var pageNumber = document.getElementById("jumpPageInput").value;
    // 如果不是空 则执行跳转
    if ("" != pageNumber) {
        location.href = location.pathname + "?page=" + pageNumber;
    }
}
