import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String  uid;
  DatabaseService ({this.uid});

  // colection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars'    : sugars,
      'name'      : name,
      'strength'  : strength
    });
  }

  //userdata from snapshot
  UserData _userDataFromSnapShots(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );

  }

  //brewList from snapshots
  List <Brew> _brewListFromSnapShot (QuerySnapshot snapshot){
    
    if (snapshot!= null){

      return snapshot.documents.map((doc){
          return Brew(
            name: doc.data['name'] ?? '',
            strength:  doc.data['strength'] ?? '',
            sugar: doc.data['sugars'] ?? '',
          );
      }).toList();
    } else{
      return null;
    }


  }
  

  Stream <List <Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }


  Stream <UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapShots);
  }


}