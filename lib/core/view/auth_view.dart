
import 'package:flutter/material.dart';
import 'package:yulib_manager/core/base/auth_base.dart';
import 'package:yulib_manager/core/model/manager_model.dart';
import 'package:yulib_manager/core/service/auth_service.dart';
import 'package:yulib_manager/locator.dart';

enum AuthProcess {
  idle,
  busy,
}
enum AuthState {
  authorized,
  unAuthorized,
  landing,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthState authState = AuthState.landing;
  AuthService authService = locator<AuthService>();
  Manager? manager;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
    notifyListeners();
  }

  AuthView() {
    getCurrentManager();
  }

  @override
  Future<Manager?> getCurrentManager() async {
    try {
      authProcess = AuthProcess.busy;
      manager = await authService.getCurrentManager();
      await Future.delayed(const Duration(seconds: 2)); //TODO
      if(manager != null){
        authState = AuthState.authorized;
      }else{
        authState = AuthState.unAuthorized;
      }
      debugPrint(
        "AuthView - Current Customer : $manager",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - Get Current Customer : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return manager;
  }

  @override
  Future<Manager?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      authProcess = AuthProcess.busy;
      manager = await authService.signInWithEmailAndPassword(email, password);
      if(manager != null){
        authState = AuthState.authorized;
      }else{
        authState = AuthState.unAuthorized;
      }
      debugPrint(
        "AuthView - signInWithEmailAndPassword : $manager",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signInWithEmailAndPassword : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return manager;
  }

  @override
  Future signOut() async {
    try {
      authProcess = AuthProcess.busy;
      await authService.signOut();
      manager = null;
      authState = AuthState.unAuthorized;
      debugPrint(
        "AuthView - signOut : $manager",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return manager;
  }
}
