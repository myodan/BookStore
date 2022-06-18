package dev.myodan.bookstore.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EqualsAndHashCode
@ToString
public class Book {
    private Integer bookId;
    private String bookName;
    private String publisher;
    private Integer price;

    @Builder
    public Book(Integer bookId, String bookName, String publisher, Integer price) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.publisher = publisher;
        this.price = price;
    }

}
