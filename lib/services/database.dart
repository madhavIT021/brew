import 'package:brew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew/models/brew.dart';

class DatabaseServices {
  final String uid;

  DatabaseServices({ required this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  // brew list from snapshot
  List<Brew>  _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      final data = doc.data() as Map<String, dynamic>;
      return Brew(
          name: data['name'] ?? '',
          strength: data['strength'] ?? 0,
          sugars: data['sugars'] ?? '0'
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserData(
        uid: uid,
        name: data['name'],
        sugars: data['sugars'],
        strength: data['strength'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}
