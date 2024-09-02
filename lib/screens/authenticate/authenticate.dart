import 'package:brew/screens/authenticate/register.dart';
import 'package:brew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
      {
        return SignIn( toogleView:toogleView);
      }
    else
      {
        return Register(toogleView:toogleView);
      }
  }
}
