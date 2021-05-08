import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marioquest/models/champion.dart';
import 'package:marioquest/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference championCollection =
      Firestore.instance.collection('champions');

  Future<void> updateUserData(String character, String name, int saved) async {
    return await championCollection.document(uid).setData({
      'character': character,
      'name': name,
      'saved': saved,
    });
  }

  // Champion list from Snapshot
  List<Champion> _championListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Champion(
        name: doc.data['name'] ?? '',
        character: doc.data['character'] ?? '',
        saved: doc.data['saved'] ?? 0,
      );
    }).toList();
  }

  // user data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      character: snapshot.data['character'],
      saved: snapshot.data['saved'],
    );
  }

  // get champions stream
  Stream<List<Champion>> get champions {
    return championCollection.snapshots().map(_championListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return championCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
