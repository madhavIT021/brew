import 'dart:async';

import 'package:brew/models/user.dart';
import 'package:brew/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creat user object based on firebaseUser(User)
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) =>  _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sign anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //creat a new document for the user with uid
      await DatabaseServices(uid : user!.uid).updateUserData('0', 'new crew member', 100 );

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null; 
    }
  }

  //sign in using email and password
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    return _auth.signOut();
  }
}
