import 'package:brew/services/auth.dart';
import 'package:brew/shared/constants.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toogleView;

  Register({required this.toogleView});



  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final Authservice _auth = Authservice();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign up to Brew Bar",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            onPressed: () {
              widget.toogleView();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.brown[100], // foreground (text) color
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textDecoretion.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? "Enter an Email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textDecoretion.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6  ? "Enter valid  Password" : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // foreground (text) color
                  backgroundColor: Colors.pink[400], // background color
                ),
                onPressed: () async {
                  if(_formkey.currentState!.validate())
                    {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailandPassword(email, password);
                      if(result==null)
                        {
                          setState(() {
                            error = "Enter a valid email or password";
                          });
                        }
                    }
                },
                child: const Text(
                  'Register',
                ),
              ),

              SizedBox(height: 20.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red,fontSize: 15.0),
              ),
              const Text(
                "@2024 MD creation,All rights reserved",
                style: TextStyle(color: Colors.black,fontSize: 15.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
