import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rt_10055_2D_configurator_suite/models/packages.dart';

class DatabaseApiClient {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> saveChanges(
      {required String? sessionID,
      required Map<String, int> configMapping,
      required double totalCost,
      required Map<String, double> cost,
      Package? package}) async {
    DocumentReference documentReference =
        _firestore.collection('sessions').doc(sessionID);

    print('saving changes to sessionID: ${documentReference.id}');

    if (sessionID == null) {
      await documentReference.set({
        'sessionID': documentReference.id,
        'configMapping': configMapping,
        'package': package?.id,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'user': _auth.currentUser?.uid,
        'totalCost': totalCost,
        'cost': cost
      }, SetOptions(merge: true));
    } else {
      await documentReference.update({
        'sessionID': documentReference.id,
        'configMapping': configMapping,
        'package': package?.id,
        'timestamp': Timestamp.fromDate(DateTime.now()),
        'user': _auth.currentUser?.uid,
        'totalCost': totalCost,
        'cost': cost
      });
    }

    print('saved changes to sessionID: ${documentReference.id}');
    return documentReference.id;
  }

  saveCurrentConfigImages(
      String sessionID, Map<dynamic, dynamic> screenShotted) async {
    DocumentReference documentReference =
        _firestore.collection('sessions').doc(sessionID);
    documentReference
        .set({"imagesMapping": screenShotted}, SetOptions(merge: true));
  }
}
