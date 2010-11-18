<%@page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="js"        uri="http://justshare.me/elfunctions/js/1.0"%>
<!DOCTYPE html>
<html>
<head>
    <title>justshare.me</title>
    <link href="/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="/uploadify/uploadify.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/uploadify/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/uploadify/swfobject.js"></script>
    <script type="text/javascript" src="/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
    <script type="text/javascript" src="/uploadify/popup.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#description').focus();
            $('#description').val('');
        });

        
        $(function() {
            $('#file_upload').uploadify({
                'method'    : 'get',
                'uploader'  : '/uploadify/uploadify.swf',
                'script'    : '/spaces/upload/<c:out value="${space}"/>;jsessionid=<%=request.getSession().getId()%>',
                'cancelImg' : '/uploadify/cancel.png',
                'auto'      : false,
                'multi'     : false,
                'onComplete': onComplete,
                'displayData' : 'speed',
                'onSelect'  : onSelect});

        });

        function onSelect(event, ID, fileObj) {
            uploadingFile = true;
        }

        var loggedIn = Boolean(<c:out value="${sessionScope['LOGGED_IN']}"/>+'');
        var uploadingFile = false;

        
        function checkLogin() {
            centerPopup();
            loadPopup();
            $('#password').focus();
            return false;
        }

        $("#popupContactClose").click(function() {
            disablePopup();
        });

        $("#backgroundPopup").click(function() {
            disablePopup();
            disableWaiting();
        });

        $(document).keypress(function(e) {
            if (e.keyCode == 27 && popupStatus == 1) {
                disablePopup();
            }
        });

        function share() {
            if (!loggedIn) {
                checkLogin();
                return false;
            }
            disablePopup();

            if ($('#description').val() == '') {
                $('#errorSpace').html('Sorry. You must enter a description');
                return false;
            }

            loadWaiting();
            
            if (!uploadingFile) {
                $.ajax({url: '/spaces/status/<c:out value="${space}"/>', type: 'POST', data: {description: $('#description').val()}, success: onComplete});
                return false;
            }

            $('#file_upload').uploadifySettings('scriptData', {'description': $('#description').val()}, true);
            $('#file_upload').uploadifyUpload();

            return true;
        }

        function login() {
            $.ajax({url: '/spaces/login/<c:out value="${space}"/>', type: 'POST', data: {password: $('#password').val()}, success: onLogin});
        }


        function onLogin(result) {
            if (eval(result)) {
                loggedIn = true;
                share();
            } else {
                loggedIn = false;
                $('#loginFailure').show('slow');
            }
        }

        function onComplete(event) {
            disableWaiting();
            uploadingFile = false;
            window.location.reload();
        }
    </script>
</head>
<body>
<div id="header">
    <div id="stripe">
        <a class="about" href="/spaces/about-justshareme">About</a>
        <a class="about" href="/">Home</a>
    </div>
    <div id="logo"></div>

    <div class="heading">Space Name: <span class="space_name"><c:out value="${space}"/></span></div>
    <div class="subheading">URL you can share with others: <strong>http://justshare.me/spaces/${space}</strong></div>

    <div id="errorSpace" class="errorMessage"></div>

    <div id="upload">
        <label for="description">Description </label>
        <%--<input id="description" name="description" type="text" value="">--%>
        <textarea id="description" style="width:100%"></textarea>
        <input id="file_upload" name="file_upload" type="file"/>
    </div>
    <div class="share"><input id="share" type="button" value="Share" class="button-primary" onclick="share()"></div>
    <div id="body">

        <c:forEach items="${sharedItems}" var="item">
        <div class="item">
            <c:choose>
                <c:when test='${item.isDescription}'>
                    <div class="description">${js:prettify(item.description)}</div>
                </c:when>
                <c:when test='${item.isImage}'>
                    <div class="image"><img src="${item.fileUrl}" alt="description"></div>
                    <div class="description">${js:prettify(item.description)}</div>
                </c:when>
                <c:otherwise>
                    <div class="file"><a href="${item.fileUrl}">${js:prettify(item.description)}</a></div>
                </c:otherwise>
            </c:choose>
            </div>
            </c:forEach>
        </div>
    </div>

    <div id="popupContact">
        <a id="popupContactClose">x</a>

        <h1>Password is required</h1>

        <div id="loginFailure">Password is wrong</div>
        <label for="password">Password </label><input type="password" name="password" id="password" value="">
        <input type="button" value="Log in" id="submit" name="submit" class="button-primary" onclick="login()">
    </div>
    <div id="backgroundPopup"></div>
    <div id="waitingWheel">
        <img src="/images/ajax-loader.gif">
    </div>
</div>
</body>
</html>
