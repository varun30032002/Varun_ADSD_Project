<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Author</title>
</head>
<body>
    <h2>Update Author</h2>
    <form action="/do_update_author/{{ author['id'] }}" method="post">
        <label for="new_name">New Name:</label>
        <input type="text" id="new_name" name="new_name" value="{{ author['name'] }}" required>
        <button type="submit">Update Author</button>
    </form>
    <a href="/">Cancel</a>
</body>
</html>
