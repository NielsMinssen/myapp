import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveVisitedCountries(Set<String> countries) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _db.collection('users').doc(userId).set({
        'visitedCountries': countries.toList(),
      });
    }
  }

  Future<Set<String>> loadVisitedCountries() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentSnapshot snapshot = await _db.collection('users').doc(userId).get();
      List<dynamic> countries = snapshot.get('visitedCountries');
      return countries.map<String>((e) => e as String).toSet();
    }
    return {};
  }
}
