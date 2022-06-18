package dev.myodan.bookstore.service;

import dev.myodan.bookstore.util.Pageable;
import dev.myodan.bookstore.model.Book;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BookService {

    List<Book> getBookList(Pageable pageable);

    Book getBook(int bookId);

    void createBook(Book book);

    void updateBook(Book book);

    void deleteBook(int bookId);

    void initBook();

    void dummyBook();
}
