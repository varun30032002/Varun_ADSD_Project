from bottle import TEMPLATE_PATH
TEMPLATE_PATH.append('./')

from bottle import Bottle, request, HTTPResponse,run, template, redirect
from sqlalchemy.exc import IntegrityError
import dataset


app = Bottle()

# Connect to SQLite database
db = dataset.connect('sqlite:///example.db')

# Define tables
try:
    authors_table = db.create_table('authors')
except:
    authors_table = db['authors']

try:
    books_table = db.create_table('books')
except:
    books_table = db['books']

# Create indexes after tables are created
if 'name' not in authors_table.columns:
    authors_table.create_column('name', db.types.string)
    authors_table.create_index('name', unique=True)

if 'title' not in books_table.columns:
    books_table.create_column('title', db.types.string)
    books_table.create_column('author_id', db.types.integer)
    books_table.create_index(['title', 'author_id'], unique=True)

# Routes
@app.route('/')
def index():
    authors = authors_table.all()
    books = books_table.all()
    return template('index', authors=authors, books=books)

@app.route('/search', method='GET')
def search():
    search_term = request.query.get('search_term')
    
    # Perform search in both authors and books
    matched_authors = authors_table.find(name={'ilike': f'%{search_term}%'})
    matched_books = books_table.find(title={'ilike': f'%{search_term}%'})

    return template('search_results', search_term=search_term, matched_authors=matched_authors, matched_books=matched_books)

@app.route('/add_author', method='POST')
def add_author():
    name = request.forms.get('name')

    try:
        authors_table.insert({'name': name})
    except IntegrityError:
        return template('error', message=f"Author '{name}' already exists.")

    return redirect('/')

@app.route('/add_book', method='POST')
def add_book():
    title = request.forms.get('title')
    author_id = request.forms.get('author_id')

    try:
        books_table.insert({'title': title, 'author_id': author_id})
    except IntegrityError:
        return template('error', message=f"Book '{title}' already exists.")

    return redirect('/')

@app.route('/update_author/<author_id:int>')
def update_author(author_id):
    author = authors_table.find_one(id=author_id)
    return template('update_author', author=author)

@app.route('/do_update_author/<author_id:int>', method='POST')
def do_update_author(author_id):
    new_name = request.forms.get('new_name')

    # Perform the update
    authors_table.update({'id': author_id, 'name': new_name}, ['id'])

    return redirect('/')

@app.route('/update_book/<book_id:int>')
def update_book(book_id):
    book = books_table.find_one(id=book_id)
    return template('update_book', book=book)

@app.route('/do_update_book/<book_id:int>', method='POST')
def do_update_book(book_id):
    new_title = request.forms.get('new_title')
    new_author_id = request.forms.get('new_author_id')

    # Perform the update
    books_table.update({'id': book_id, 'title': new_title, 'author_id': new_author_id}, ['id'])

    return redirect('/')

@app.route('/delete_author/<author_id:int>')
def delete_author(author_id):
    authors_table.delete(id=author_id)
    books_table.delete(author_id=author_id)
    return redirect('/')

@app.route('/delete_book/<book_id:int>')
def delete_book(book_id):
    books_table.delete(id=book_id)
    return redirect('/')

if __name__ == '__main__':
    run(app, host='localhost', port=8080, debug=True)
