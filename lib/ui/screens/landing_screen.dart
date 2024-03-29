import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulib_manager/core/view/auth_view.dart';
import 'package:yulib_manager/ui/screens/login_screen/login_screen.dart';
import 'package:yulib_manager/ui/screens/main_screen/main_screen.dart';
import 'package:yulib_manager/ui/screens/splash/splash_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);


    if(authView.authState == AuthState.landing){
      return const SplashScreen();
    }else{
      if(authView.authState == AuthState.unAuthorized){
        return const LoginScreen();
      }else{
        return const MainScreen();
      }
    }
  }
}
