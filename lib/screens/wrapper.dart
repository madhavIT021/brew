import 'package:brew/models/user.dart';
import 'package:brew/screens/authenticate/authenticate.dart';
import 'package:brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);
    print(user);

    if(user == null)
      {
        return Authenticate();
      }
    else
      {
        return Home();
      }
  }
}
