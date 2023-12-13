<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
</head>
<body>
    <h2>Search Results for '{{ search_term }}'</h2>

    <h3>Matched Authors</h3>
    <ul>
        % for author in matched_authors:
            <li>{{ author['name'] }}</li>
        % end
    </ul>

    <h3>Matched Books</h3>
    <ul>
        % for book in matched_books:
            <li>{{ book['title'] }} by Author ID {{ book['author_id'] }}</li>
        % end
    </ul>
    <a href="/">Go back to the home page</a>
</body>
</html>
