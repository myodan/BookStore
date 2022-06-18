package dev.myodan.bookstore.service;

import dev.myodan.bookstore.util.Pageable;
import dev.myodan.bookstore.repository.BookRepository;
import dev.myodan.bookstore.model.Book;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    private final BookRepository bookRepository;

    public BookServiceImpl(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Override
    public List<Book> getBookList(Pageable pageable) {
        pageable.setTotal(bookRepository.total(pageable));
        return bookRepository.findAll(pageable);
    }

    @Override
    public Book getBook(int bookId) {
        return bookRepository.findById(bookId);
    }

    @Override
    public void createBook(Book book) {
        bookRepository.save(book);
    }

    @Override
    public void updateBook(Book book) {
        bookRepository.update(book);
    }

    @Override
    public void deleteBook(int bookId) {
        bookRepository.delete(bookId);
    }

    @Override
    public void initBook() {
        for (int i = 11; i < 100; i++) {
            bookRepository.delete(i);
        }
    }

    @Override
    public void dummyBook() {
        for (int i = 11; i < 100; i++) {
            bookRepository.save(Book.builder().bookId(i).bookName("도서명" + i).publisher("출판사" + i).price((int) (Math.random() * 100 + 1) * 100).build());
        }
    }

}
