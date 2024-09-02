import 'package:brew/services/auth.dart';
import 'package:brew/services/push_notification.dart';
import 'package:brew/shared/constants.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toogleView;
  SignIn({ required this.toogleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Bar',
        style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toogleView(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.brown[100], // foreground (text) color
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textDecoretion.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textDecoretion.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // foreground (text) color
                    backgroundColor: Colors.pink[400],// background color
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30.0)
                    // )
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white)
                    ,
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailandPassword(email, password);


                      if(result == null) {

                        setState(() {
                          error = 'Could not sign in with those credentials';
                        });
                      }

                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}