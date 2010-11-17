<!DOCTYPE html>
<html>
<head>
    <title>justshare.me</title>
    <link href="css/main.css" rel="stylesheet" type="text/css"/>
</head>
<body onload="document.getElementById('space').focus();">
<div id="header">
    <div id="stripe">
        <a class="about" href="#">About</a>
    </div>
    <div id="logo">

    </div>

    <div id="body">
        <form method="POST" action="/api/spaces/new">
            <div class="heading">create your space</div>
            <label for="space">http://justshare.me/spaces/</label><input id="space" name="space" type="text" value="">
            <label for="password">Editing password </label><input id="password" name="password" type="password" value="">
            <div id="submit">
                <input type="submit" value="create" class="button-primary">
            </div>
        </form>
    </div>
    <div id="activespaces">
        <div class="heading">Active Spaces</div>
    </div>
</div>
</body>
</html>
