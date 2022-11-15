
import 'package:yulib_manager/core/model/book_model.dart';

abstract class BookBase {
  Future<List<BookModel>?> getBooks();
  Future<BookModel?> getBook(String bookId);
  Future<bool> deliveryBook(BookModel bookModel);
  Future<List<BookModel>?> getOrders();
  Future<BookModel?> getOrder(String bookId);
}
