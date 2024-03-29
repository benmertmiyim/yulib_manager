
import 'package:flutter/material.dart';
import 'package:yulib_manager/core/base/book_base.dart';
import 'package:yulib_manager/core/model/book_model.dart';
import 'package:yulib_manager/core/service/book_service.dart';
import 'package:yulib_manager/locator.dart';

enum BookProcess {
  idle,
  busy,
}

class BookView with ChangeNotifier implements BookBase {
  BookProcess _bookProcess = BookProcess.idle;
  BookService bookService = locator<BookService>();
  List<BookModel>? books;
  List<BookModel>? orderedBooks;

  BookProcess get bookProcess => _bookProcess;

  set bookProcess(BookProcess value) {
    _bookProcess = value;
    notifyListeners();
  }

  @override
  Future<List<BookModel>?> getBooks() async {
    try {
      books = await bookService.getBooks();
    } catch (e) {
      debugPrint(
        "BookView - Exception - Get Books : ${e.toString()}",
      );
    }
    return books;
  }

  @override
  Future<BookModel?> getBook(String bookId) async {
    try {
      bookProcess = BookProcess.busy;
      return await bookService.getBook(bookId);
    } catch (e) {
      debugPrint(
        "BookView - Exception - Get Book : ${e.toString()}",
      );
    } finally {
      bookProcess = BookProcess.idle;
    }
    return null;
  }

  @override
  Future<List<BookModel>?> getOrders() async {
    try {
      orderedBooks = await bookService.getOrders();
    } catch (e) {
      debugPrint(
        "BookView - Exception - Get Ordered Books : ${e.toString()}",
      );
    }
    return orderedBooks;
  }

  @override
  Future<bool> deliveryBook(BookModel bookModel) async {
    try {
      bookProcess = BookProcess.busy;
      return await bookService.deliveryBook(bookModel);
    } catch (e) {
      debugPrint(
        "BookView - Exception - deliveryBook : ${e.toString()}",
      );
      return false;
    }finally{
      bookProcess = BookProcess.idle;
    }
  }

  @override
  Future<BookModel?> getOrder(String bookId) async {
    try {
      bookProcess = BookProcess.busy;
      BookModel? bookModel = await bookService.getOrder(bookId);
      debugPrint(bookModel.toString());
      return bookModel;
    } catch (e) {
      debugPrint(
        "BookView - Exception - getOrder: ${e.toString()}",
      );
    } finally {
      bookProcess = BookProcess.idle;
    }
    return null;
  }
}
