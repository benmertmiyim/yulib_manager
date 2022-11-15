import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yulib_manager/core/base/book_base.dart';
import 'package:yulib_manager/core/model/book_model.dart';

class BookService implements BookBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<BookModel>?> getBooks() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(
        "books").get();
    List<BookModel> list = [];
    for (int i = 0; i < querySnapshot.size; i++) {
      Map<String, dynamic> vendor =
      querySnapshot.docs[i].data() as Map<String, dynamic>;
      debugPrint(vendor.toString());
      list.add(BookModel.fromMap(vendor));
    }
    return list;
  }

  @override
  Future<BookModel?> getBook(String bookId) async {
    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection(
        "books").doc(bookId)
        .get();
    return BookModel.fromMapForThing(documentSnapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<List<BookModel>?> getOrders() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(
        "orders")
        .get();
    List<BookModel> list = [];
    for (int i = 0; i < querySnapshot.size; i++) {
      Map<String, dynamic> vendor =
      querySnapshot.docs[i].data() as Map<String, dynamic>;
      debugPrint(vendor.toString());
      list.add(BookModel.fromMapForOrder(vendor));
    }
    return list;
  }

  @override
  Future<bool> deliveryBook(BookModel bookModel) async {
    try{
      DocumentReference books =
      firebaseFirestore.collection("books").doc(bookModel.id);
      await books
          .update({"active": true});
      DocumentReference orders =
      firebaseFirestore.collection("orders").doc(bookModel.orderId);
      await orders
          .update({"active": false,"delivery_date":Timestamp.now()});
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Future<BookModel?> getOrder(String bookId) async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(
        "orders").where("book_id",isEqualTo: bookId).where("active",isEqualTo: true)
        .get();
    List<BookModel> list = [];
    for (int i = 0; i < querySnapshot.size; i++) {
      Map<String, dynamic> vendor =
      querySnapshot.docs[i].data() as Map<String, dynamic>;
      debugPrint(vendor.toString());
      list.add(BookModel.fromMapForOrder(vendor));
    }
    return list[0];
  }
}