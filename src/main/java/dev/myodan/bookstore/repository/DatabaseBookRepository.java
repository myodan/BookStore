package dev.myodan.bookstore.repository;

import dev.myodan.bookstore.util.Pageable;
import dev.myodan.bookstore.model.Book;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DatabaseBookRepository implements BookRepository {

    private final SqlSession sqlSession;

    public DatabaseBookRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<Book> findAll() {
        return sqlSession.selectList("book.findAll");
    }

    @Override
    public List<Book> findAll(Pageable pageable) {
        return sqlSession.selectList("book.findAllPageable", pageable);
    }

    @Override
    public Book findById(int bookId) {
        return sqlSession.selectOne("book.findById", bookId);
    }

    @Override
    public void save(Book book) {
        sqlSession.insert("book.save", book);
    }

    @Override
    public void update(Book book) {
        sqlSession.update("book.update", book);
    }

    @Override
    public void delete(int bookId) {
        sqlSession.delete("book.delete", bookId);
    }

    @Override
    public int total(Pageable pageable) {
        return sqlSession.selectOne("book.total", pageable);
    }

}
