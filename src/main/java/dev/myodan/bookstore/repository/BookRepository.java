package dev.myodan.bookstore.repository;

import dev.myodan.bookstore.util.Pageable;
import dev.myodan.bookstore.model.Book;

import java.util.List;

public interface BookRepository {

    List<Book> findAll();

    List<Book> findAll(Pageable pageable);

    Book findById(int bookId);

    void save(Book book);

    void update(Book book);

    void delete(int bookId);

    int total(Pageable pageable);

}
