<%@page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
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
                'script'    : '/api/spaces/upload/<c:out value="${space}"/>',
                'cancelImg' : '/uploadify/cancel.png',
                'auto'      : false,
                'multi'     : false,
                'onComplete': onComplete,
                'displayData' : 'speed',
                'scriptData': {'description': $('#description').val()}
            });
        });

        var loggedIn = Boolean(<c:out value="${sessionScope['LOGGED_IN']}"/>+'');

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

            if ($('#description').val() == '') {
                alert('The description has to be filled');
                return false;
            }

            if ($('#file_upload').val() == '') {
                $.ajax({url: '/api/spaces/status/<c:out value="${space}"/>', type: 'POST', data: {description: $('#description').val()}, success: onComplete});
                return false;
            }
            $('#file_upload').uploadifySettings('scriptData', {'description': $('#description').val()}, true);
            $('#file_upload').uploadifyUpload();

            return true;
        }

        function login() {
            $.ajax({url: '/api/spaces/login/<c:out value="${space}"/>', type: 'POST', data: {password: $('#password').val()}, success: onLogin});
        }


        function onLogin(result) {
            if (eval(result)) {
                loggedIn = true;
                disablePopup();
                share();
            } else {
                loggedIn = false;
                $('#loginFailure').show('slow');                
            }
        }

        function onComplete(event) {
            window.location.reload();
        }
    </script>
</head>
<body>
<div id="header">
    <div id="stripe">
        <a class="about" href="#">About</a>
    </div>
    <div id="logo"></div>

    <div class="heading">Space <span class="space_name"><c:out value="${space}"/></span></div>

    <div id="upload">
        <label for="description">Description </label><input id="description" name="description" type="text" value="">
        <input id="file_upload" name="file_upload" type="file"/>
    </div>
    <div class="share"><input id="share" type="button" value="Share" class="button-primary" onclick="share()"></div>
    <div id="body">
        <c:forEach items="${sharedItems}" var="item">
            <div class="item"><a href="${item.fileUrl}"><c:out value="${item.description}"/></a></div>
        </c:forEach>
    </div>

    <div id="popupContact">
        <a id="popupContactClose">x</a>

        <h1>Password is required</h1>
        <div id="loginFailure">Password is wrong</div>
        <label for="password">Password </label><input type="password" name="password" id="password" value="">
        <input type="button" value="Log in" id="submit" name="submit" class="button-primary" onclick="login()">
    </div>
    <div id="backgroundPopup"></div>

</div>
</body>
</html>
