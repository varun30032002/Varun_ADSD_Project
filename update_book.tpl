<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Book</title>
</head>
<body>
    <h2>Update Book</h2>
    <form action="/do_update_book/{{ book['id'] }}" method="post">
        <label for="new_title">New Title:</label>
        <input type="text" id="new_title" name="new_title" value="{{ book['title'] }}" required>
        <label for="new_author_id">New Author ID:</label>
        <input type="text" id="new_author_id" name="new_author_id" value="{{ book['author_id'] }}" required>
        <button type="submit">Update Book</button>
    </form>
    <a href="/">Cancel</a>
</body>
</html>
