
import 'package:yulib_manager/core/model/manager_model.dart';

abstract class AuthBase {
  Future<Manager?> getCurrentManager();
  Future<Manager?> signInWithEmailAndPassword(String email,String password);
  Future signOut();
}
