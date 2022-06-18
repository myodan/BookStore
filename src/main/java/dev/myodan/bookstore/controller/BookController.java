package dev.myodan.bookstore.controller;

import dev.myodan.bookstore.util.Pageable;
import dev.myodan.bookstore.model.Book;
import dev.myodan.bookstore.service.BookService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/books")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public String getBookList(Model model, Pageable pageable) {
        model.addAttribute("bookList", bookService.getBookList(pageable));
        model.addAttribute("pagination", pageable);
        return "/books/list";
    }

    @GetMapping("/create")
    public String getBookInsert() {
        return "/books/create";
    }

    @PostMapping("/create")
    public String postBookInsert(Book book) {
        bookService.createBook(book);
        return "redirect:/books";
    }

    @GetMapping("/update")
    public String getUpdateBook(int bookId, Model model) {
        model.addAttribute("book", bookService.getBook(bookId));
        return "/books/update";
    }

    @PostMapping("/update")
    public String postUpdateBook(Book book) {
        bookService.updateBook(book);
        return "redirect:/books";
    }

    @GetMapping("/delete")
    public String getDeleteBook() {
        return "/books/delete";
    }

    @PostMapping("/delete")
    public String postDeleteBook(int bookId) {
        bookService.deleteBook(bookId);
        return "redirect:/books";
    }

    @GetMapping("/init")
    public String getInitBook() {
        bookService.initBook();
        return "redirect:/books";
    }

    @GetMapping("/dummy")
    public String getDummyBook() {
        bookService.dummyBook();
        return "redirect:/books";
    }

}

