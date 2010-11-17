<!DOCTYPE html>
<html>
<head>
    <title>justshare.me</title>
    <link href="css/main.css" rel="stylesheet" type="text/css"/>
    <link href="/uploadify/uploadify.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/uploadify/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/uploadify/swfobject.js"></script>
    <script type="text/javascript" src="/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#file_upload').uploadify({
                'uploader'  : '/uploadify/uploadify.swf',
                'script'    : '/uploadify/uploadify.php',
                'cancelImg' : '/uploadify/cancel.png',
                'folder'    : '/api/uploads',
                'auto'      : true,
                'multi'     : false
            });
        });
    </script>
</head>
<body onload="document.getElementById('space').focus();">
<div id="header">
    <div id="stripe">
        <a class="about" href="#">About</a>
    </div>
    <div id="logo">

    </div>

    <div class="heading">Space <span class="space_name">Devoxx2010</span></div>

    <div id="body">
        <input id="file_upload" name="file_upload" type="file" />
    </div>
</div>
</body>
</html>
