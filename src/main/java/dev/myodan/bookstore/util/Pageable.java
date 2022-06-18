package dev.myodan.bookstore.util;

import lombok.Getter;
import lombok.Setter;

import java.util.*;

@Getter
@Setter
public class Pageable {

    private int page = 1;

    private int offset = 10;

    private int group = 5;

    private int total;

    private String keyword;

    private int filter = 0;

    public int getLast() {
        return (int) Math.ceil((double) total / (double) offset);
    }

    public int getPre() {
        return page <= group ? 1 : (((page - 1) / group) - 1) * group + 1;
    }

    public int getNext() {
        int next = (((page - 1) / group) + 1) * group + 1;
        int last = this.getLast();
        return Math.min(next, last);
    }

    public List<Integer> getList() {
        List<Integer> list = new ArrayList<>();
        int startPage = (((page - 1) / group)) * group + 1;

        for (int i = startPage; i < startPage + group && i <= this.getLast(); i++) {
            list.add(i);
        }

        if (list.isEmpty()) {
            list.add(1);
        }

        return list;
    }

    public String getQuery() {
        List<String> result = new ArrayList<>();

        result.add("offset=" + offset);

        if (filter != 0) {
            result.add("filter=" + filter);
        }

        if (keyword != null) {
            result.add("keyword=" + keyword);
        }

        return String.join("&", result);
    }

}
