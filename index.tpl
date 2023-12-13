<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authors and Books</title>
</head>
<body>
    <h1>Authors</h1>
    <ul>
        % for author in authors:
            <li>
                {{ author['name'] }}
                <a href="/delete_author/{{ author['id'] }}">Delete</a>
                <a href="/update_author/{{ author['id'] }}">Update</a>
            </li>
        % end
    </ul>

    <h1>Books</h1>
    <ul>
        % for book in books:
            <li>
                {{ book['title'] }} by Author ID {{ book['author_id'] }}
                <a href="/delete_book/{{ book['id'] }}">Delete</a>
                <a href="/update_book/{{ book['id'] }}">Update</a>
            </li>
        % end
    </ul>

    <h2>Search</h2>
    <form action="/search" method="get">
        <label for="search_term">Search Term:</label>
        <input type="text" id="search_term" name="search_term" required>
        <button type="submit">Search</button>
    </form>

    <h2>Add Author</h2>
    <form action="/add_author" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        <button type="submit">Add Author</button>
    </form>

    <h2>Add Book</h2>
    <form action="/add_book" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>
        <label for="author_id">Author ID:</label>
        <input type="text" id="author_id" name="author_id" required>
        <button type="submit">Add Book</button>
    </form>
</body>
</html>
