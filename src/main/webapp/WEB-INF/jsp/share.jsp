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

        function uploadFile() {
            $('#file_upload').uploadifySettings('scriptData', {'description': $('#description').val()}, true);
            $('#file_upload').uploadifyUpload();
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
    <div class="share"><input type="button" value="Share" class="button-primary" onclick="uploadFile()"></div>
    <div id="body">
        <c:forEach items="${sharedItems}" var="item">
            <div class="item"><a href="${item.fileUrl}"><c:out value="${item.description}"/></a></div>
        </c:forEach>
    </div>


</div>
</body>
</html>
