import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveVisitedCountries(Set<String> countries) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _db.collection('users').doc(userId).update({
        'visitedCountries': countries,
      });
    }
  }

  Future<void> saveFirstName(String firstName) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _db.collection('users').doc(userId).set({
        'firstName': firstName,
      });
    }
  }

  Future<void> saveLastName(String lastName) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _db.collection('users').doc(userId).update({
        'lastName': lastName,
      });
    }
  }

  Future<String> getFirstName() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentSnapshot snapshot =
          await _db.collection('users').doc(userId).get();
      String res = snapshot.get('firstName');
      return res;
    } else {
      print('No user ID found, returning empty set.');
      return ''; // Return an empty String if userId is null
    }
  }

    Future<String> getLastName() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentSnapshot snapshot =
          await _db.collection('users').doc(userId).get();
      String res = snapshot.get('lastName');
      return res;
    } else {
      print('No user ID found, returning empty set.');
      return ''; // Return an empty String if userId is null
    }
  }

  Future<Set<String>> loadVisitedCountries() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        DocumentSnapshot snapshot =
            await _db.collection('users').doc(userId).get();
        List<dynamic> countries = snapshot.get('visitedCountries');
        print("***************************************************");
        print(countries);
        var tmp = countries.map<String>((e) => e as String).toSet();
        print(tmp);
        return countries.map<String>((e) => e as String).toSet();
      } catch (e) {
        // Log the error or handle it as needed
        print('Error loading visited countries: $e');
        return {}; // Return an empty set in case of error
      }
    } else {
      print('No user ID found, returning empty set.');
      return {}; // Return an empty set if userId is null
    }
    // This line is unnecessary as all paths now return a value or an empty set
    // return {};
  }
}
