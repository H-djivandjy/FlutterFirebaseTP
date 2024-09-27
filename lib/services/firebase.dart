import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference codes = FirebaseFirestore.instance.collection('codes');

  Future<DocumentReference> createCode(String code) async {
    try {
      print('Attempting to create a new code: $code');
      final DocumentReference documentReference = await codes.add({
        'code': code,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Code created successfully: ${documentReference.id}');
      return documentReference;
    } catch (e) {
      print('Error creating code: $e');
      throw e;
    }
  }

  Stream<QuerySnapshot> getCodes() {
    try {
      print('Fetching codes from Firestore');
      return codes.snapshots().handleError((error) {
        print('Error fetching codes: $error');
        throw error;
      });
    } catch (e) {
      print('Unexpected error in getCodes: $e');
      rethrow;
    }
  }
}