# BookStore

# 프로젝트 전체 코드

[https://github.com/myodan/BookStore](https://github.com/myodan/BookStore)

# 프로젝트 라이브러리, 프레임워크

1. Maven [[링크]](https://github.com/apache/maven)
   1. 자바 프로젝트 의존성 설치, 테스트, 배포 작업을 쉽고 편리하게 해주는 빌드 도구이다.
   2. xml작성으로 의존성을 설정하고 설치할 수 있다.
2. Spring [[링크]](https://github.com/spring-projects/spring-framework)
   1. 자바 코드를 좀 더 쉽고 편리하게 처리할 수 있게 해주는 프레임 워크이다.
   2. IoC 기반의 프레임워크(DI, DL 사용 용이)이다.
3. MyBatis [[링크]](https://github.com/mybatis/mybatis-3)
   1. 자바에서 데이터베이스 처리를 좀 더 쉽게 처리할 수 있게 도와주는 프레임 워크이다.
   2. 실제 코드와 SQL을 분리할 수 있는 장점이 있다.
4. Log4J [[링크]](https://github.com/apache/logging-log4j2)
   1. 로그 출력을 도와주는 라이브러리이다.
5. Lombok [[링크]](https://github.com/projectlombok/lombok)
   1. 자바에서 Getter, Setter, Constructor, toString, Builder 등을 어노테이션 기반으로 쉽게 생성이 가능하게 해주는 라이브러리이다.
   2. Getter, Setter 등의 반복되는 코드를 많이 줄일 수 있다.
6. JSP (Java Server Page) [[링크]](https://www.oracle.com/java/technologies/jspt.html)
   1. HTML코드에 JAVA코드를 넣어 동적인 웹페이를 생성해주는 라이브러리이다.
7. JSTL (JavaServer Pages Standard Tag Library) [[링크]](https://tomcat.apache.org/taglibs/standard/)
   1. JSP 확장 라이브러리로 여러 기능들을 자바코드가이나리 태그기반으로 작성할 수 있게 도와주는 라이브러리이다.
8. Tabler (Bootstrap) [[링크]](https://github.com/tabler/tabler)
   1. 부트스트랩5 기반의 프론트엔드 프레임워크

# HTTP 목록

| HTTP 요청 메서드 & 경로 | 설명                                           |
| ----------------------- | ---------------------------------------------- |
| GET /books              | 도서 목록 페이지를 반환                        |
| GET /books/create       | 도서 생성 페이지를 반환                        |
| POST /books/create      | 도서를 생성하고 /books로 리다이렉트            |
| GET /books/update       | 도서 수정 페이지를 반환                        |
| POST /books/update      | 도서를 수정하고 /books로 리다이렉트            |
| GET /books/delete       | 도서 삭제 페이지를 반환                        |
| POST /books/delete      | 도서를 삭제하고 /books로 리다이렉트            |
| GET /books/init         | 임시 도서데이터를 추가하고 /books로 리다이렉트 |
| GET /books/dummy        | 임시 도서데이트를 삭제하고 /books로 리다이렉트 |

# 프로젝트 구조

## Model

### Book

Book 테이블과 매핑되는 클래스이다. Lombok을 사용함

- 코드
  `src/main/java/dev/myodan/bookstore/model/Book.java`

  ```java
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
  ```

## Controller

### BookController

`/books` 에대한 요청을 처리하는 컨트롤러 각 요청을 서비스에서 처리하여 view 경로를 반환함, 경로를 반환하면 스프링에서 설정된 prefix, subprefix 값을 넣어 경로를 찾아 jsp파일을 찾아 응답한다.

- 코드
  `src/main/java/dev/myodan/bookstore/controller/BookController.java`

  ```java
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
  ```

## Service

### BookService Interface

북 서비스 구현체에서 필요한 함수들을 명시해둔 인터페이스

- 코드
  `src/main/java/dev/myodan/bookstore/service/BookService.java`

  ```java
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
  ```

### BookService Implement

북 서비스 인터페이스를 구현한 구현체 실질적으로 비지니스 로직을 처리하는 클래스

- 코드
  `src/main/java/dev/myodan/bookstore/service/BookServiceImpl.java`

  ```java
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
  ```

## Repository

### BookRepository Interface

북 레파지토리 구현체에서 필요한 함수들을 명시해둔 인터페이스

- 코드
  `src/main/java/dev/myodan/bookstore/repository/BookRepository.java`

  ```java
  public interface BookRepository {

      List<Book> findAll();

      List<Book> findAll(Pageable pageable);

      Book findById(int bookId);

      void save(Book book);

      void update(Book book);

      void delete(int bookId);

      int total(Pageable pageable);

  }
  ```

### BookRepository Implement

북 레파지토리를 구현한 구현체로 실직적으로 데이터베이스에 접근해 쿼리를 실행하고 데이터를 받아오는 클래스

`sqlSession`은 MyBatis에서 제공하는 클래스로 xml로 작성된 sql을 id로 호출하여 데이터값을 반환한다.

- 코드
  `src/main/java/dev/myodan/bookstore/repository/DatabaseBookRepository.java`

  ```java
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
  ```

## Util

### Pageable

페이지네이션을 지원하기위한 클래스이다. 페이지 관련 함수들이 들어가있으며 필드에 컨트롤러가 쿼리를 매치시켜 주입시켜준다.

- 코드
  `src/main/java/dev/myodan/bookstore/util/Pageable.java`

  ```java
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
  ```

## Log4J

### Log4J Config

Log4J에 대한 설정을 작성해둔 파일

- 코드
  `src/main/resources/log4j.xml`

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN"
          "http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/xml/doc-files/log4j.dtd">
  <log4j:configuration>
      <!-- Appenders -->
      <appender name="console" class="org.apache.log4j.ConsoleAppender">
          <param name="Target" value="System.out"/>
          <layout class="org.apache.log4j.PatternLayout">
              <param name="ConversionPattern" value="%-5p: %c - %m%n"/>
          </layout>
      </appender>

      <!-- Application Loggers -->
      <logger name="dev.myodan.bookstore">
          <level value="info"/>
      </logger>

      <!-- 3rdparty Loggers -->
      <logger name="org.springframework.core">
          <level value="info"/>
      </logger>

      <logger name="org.springframework.beans">
          <level value="info"/>
      </logger>

      <logger name="org.springframework.context">
          <level value="info"/>
      </logger>

      <logger name="org.springframework.web">
          <level value="info"/>
      </logger>

      <!-- Root Logger -->
      <root>
          <priority value="trace"/>
          <appender-ref ref="console"/>
      </root>

  </log4j:configuration>
  ```

## MyBatis

### MyBatis Config

MyBatis에 대한 설정을 작성해둔 파일

- 코드
  `src/main/resources/mybatis-config.xml`

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
  <configuration>
      <typeAliases>
          <typeAlias alias="book" type="dev.myodan.bookstore.model.Book"/>
      </typeAliases>

      <mappers>
          <mapper resource="mybatis/book.xml"/>
      </mappers>
  </configuration>
  ```

### Book Mapper

MyBatis에 매핑될 sql을 작성해둔 파일이다.

- 코드
  `src/main/resources/mybatis/book.xml`

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

  <mapper namespace="book">
      <sql id="search">
          SELECT *
          FROM BOOK
          <where>
              <if test="filter == 1">
                  BOOKID LIKE '%' || '${keyword}' || '%'
              </if>

              <if test="filter == 2">
                  BOOKNAME LIKE '%' || '${keyword}' || '%'
              </if>

              <if test="filter == 3">
                  PUBLISHER LIKE '%' || '${keyword}' || '%'
              </if>
          </where>
          ORDER BY BOOKID
      </sql>

      <select id="findAll" resultType="book">
          SELECT *
          FROM BOOK
      </select>

      <select id="findAllPageable" resultType="book">
          SELECT *
          FROM (SELECT T1.*, ROWNUM as rnum
          FROM (<include refid="search"/>) T1) T2
          WHERE T2.rnum between ((#{page} - 1) * #{offset}) + 1 and (#{page} * #{offset})
      </select>

      <select id="findById" resultType="book">
          SELECT *
          FROM BOOK
          WHERE BOOKID = #{bookId}
      </select>

      <select id="total" resultType="int">
          SELECT COUNT(*)
          FROM (<include refid="search"/>)
      </select>

      <insert id="save">
          INSERT INTO BOOK
          VALUES (#{bookId}, #{bookName}, #{publisher}, #{price})
      </insert>

      <update id="update">
          UPDATE BOOK
          SET BOOKNAME  = #{bookName},
              PUBLISHER = #{publisher},
              PRICE     = #{price}
          WHERE BOOKID = #{bookId}
      </update>

      <delete id="delete">
          DELETE
          FROM BOOK
          WHERE BOOKID = #{bookId}
      </delete>
  </mapper>
  ```

## Webapp

### Web

웹 어플리케이션 서버에서 사용할 설정들을 설정하는 파일

- 코드
  `src/main/webapp/WEB-INF/web.xml`

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <web-app
          version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://java.sun.com/xml/ns/javaee https://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
  >

      <!-- The definition of the Root Spring Container shared by all Servlets and Filters -->
      <context-param>
          <param-name>contextConfigLocation</param-name>
          <param-value>/WEB-INF/spring/root-context.xml</param-value>
      </context-param>

      <!-- Creates the Spring Container shared by all Servlets and Filters -->
      <listener>
          <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
      </listener>

      <!-- Processes application requests -->
      <servlet>
          <servlet-name>appServlet</servlet-name>
          <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
          <init-param>
              <param-name>contextConfigLocation</param-name>
              <param-value>/WEB-INF/spring/appServlet/servlet-context.xml</param-value>
          </init-param>
          <load-on-startup>1</load-on-startup>
      </servlet>

      <servlet-mapping>
          <servlet-name>appServlet</servlet-name>
          <url-pattern>/</url-pattern>
      </servlet-mapping>

      <filter>
          <filter-name>encodingFilter</filter-name>
          <filter-class>
              org.springframework.web.filter.CharacterEncodingFilter
          </filter-class>
          <init-param>
              <param-name>encoding</param-name>
              <param-value>UTF-8</param-value>
          </init-param>

          <init-param>
              <param-name>forceEncoding</param-name>
              <param-value>true</param-value>
          </init-param>
      </filter>

      <filter-mapping>
          <filter-name>encodingFilter</filter-name>
          <url-pattern>/*</url-pattern>
      </filter-mapping>
  </web-app>
  ```

### Root Context Config

스프링에 등록될 기본적인 빈즈들을 설정하는 파일

- 코드
  `src/main/webapp/WEB-INF/spring/root-context.xml`

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <beans
          xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd"
  >
      <bean id="dataSource" class="org.apache.commons.dbcp2.BasicDataSource" destroy-method="close">
          <property name="driverClassName" value="oracle.jdbc.OracleDriver"/>
          <property name="url" value="jdbc:oracle:thin:@localhost:1521:xe"/>
          <property name="username" value="madang"/>
          <property name="password" value="madang"/>
      </bean>

      <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
          <property name="dataSource" ref="dataSource"/>
          <property name="configLocation" value="classpath:mybatis-config.xml"/>
      </bean>

      <bean id="sqlSessionTemplate" class="org.mybatis.spring.SqlSessionTemplate">
          <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"/>
      </bean>
  </beans>
  ```

### Servlet Context Config

스프링에 등록될 서블릿에서 사용될 빈즈들을 설정하는 파일

- 코드
  `src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml`

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <beans:beans
          xmlns="http://www.springframework.org/schema/mvc"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:beans="http://www.springframework.org/schema/beans"
          xmlns:context="http://www.springframework.org/schema/context"
          xsi:schemaLocation="http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd
  		http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd
  		http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd"
  >

      <!-- DispatcherServlet Context: defines this servlet's request-processing infrastructure -->

      <!-- Enables the Spring MVC @Controller programming model -->
      <annotation-driven/>

      <!-- Handles HTTP GET requests for /resources/** by efficiently serving up static resources in the ${webappRoot}/resources directory -->
      <resources mapping="/resources/**" location="/resources/"/>

      <!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
      <beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
          <beans:property name="prefix" value="/WEB-INF/views/"/>
          <beans:property name="suffix" value=".jsp"/>
      </beans:bean>
      <context:component-scan base-package="dev.myodan.bookstore"/>
  </beans:beans>
  ```

### Views

JSP, JSTL, Tabler로 구현된 뷰파일들이 있다.

- 코드
  `src/main/webapp/WEB-INF/views/**/*.jsp`
  [BookStore/src/main/webapp/WEB-INF/views at main · myodan/BookStore](https://github.com/myodan/BookStore/tree/main/src/main/webapp/WEB-INF/views)
