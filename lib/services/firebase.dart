import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference codes = FirebaseFirestore.instance.collection('codes');

  // Méthode existante pour créer un code
  Future<DocumentReference> createCode(String code) async {
    try {
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

  // Méthode existante pour obtenir les codes
  Stream<QuerySnapshot> getCodes() {
    return codes.snapshots();
  }

  // Nouvelle méthode pour supprimer un code
  Future<void> deleteCode(String docId) async {
    try {
      await codes.doc(docId).delete();
      print('Code deleted successfully: $docId');
    } catch (e) {
      print('Error deleting code: $e');
      throw e;
    }
  }
}