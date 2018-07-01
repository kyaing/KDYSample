
class BookViewModel():
    def __init__(self, book):
        self.title = book['title']
        self.publisher = book['publisher']
        self.author = '、'.join(book['author'])
        self.image = book['image']
        self.price = book['price']
        self.summary = book['summary']
        self.pages = book['pages']
        self.isbn = book['isbn']

    @property
    def intro(self):
        intros = filter(lambda x: True if x else False, 
                        [self.author, self.publisher, self.price])
                        
        return ' / '.join(intros)

class BookCollection():
    def __init__(self):
        self.total = 0
        self.keyword = ''
        self.books = []

    def fill(self, fisher_book, keyword):
        self.total = fisher_book.total
        self.keyword = keyword
        self.books = [BookViewModel(book) for book in fisher_book.books]

# 弃用
class _BookViewModel():
    @classmethod
    def package_single(cls, data, keyword):
        returned = {
            'books': [],
            'total': 0,
            'keyword': keyword
        }
        if data:
            returned['total'] = 1
            returned['books'] = [cls.__cut_book_data(data)]
        return returned

    @classmethod
    def package_collection(cls, data, keyword):
        returned = {
            'books': [],
            'total': 0,
            'keyword': keyword
        }
        if data:
            returned['total'] = data['total']
            returned['books'] = [cls.__cut_book_data(data) for book in data['books']]
        return returned

    @classmethod
    def __cut_book_data(cls, data):
        book = {
            'title': data['title'],
            'publisher': data['publisher'],
            'pages': data['pages'] or '',
            'author': '、'.join(data['author']),
            'price': data['pri ce'],
            'summary': data['summary'] or '',
            'image': data['image']
        }
        return book