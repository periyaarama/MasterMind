import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a document to a collection
  Future<void> addDocumentToCollection(
      String collectionName, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
      print('Document added to $collectionName collection');
    } catch (e) {
      print('Failed to add document: $e');
    }
  }

  // Method to update a document in a collection
  Future<void> updateDocumentInCollection(String collectionName,
      String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).update(data);
      print('Document updated in $collectionName collection');
    } catch (e) {
      print('Failed to update document: $e');
    }
  }

  // Method to delete a document from a collection
  Future<void> deleteDocumentFromCollection(
      String collectionName, String documentId) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).delete();
      print('Document deleted from $collectionName collection');
    } catch (e) {
      print('Failed to delete document: $e');
    }
  }

  // Method to query documents in a collection
  Future<void> queryDocumentsInCollection(
      String collectionName, Map<String, dynamic> query) async {
    try {
      Query collectionQuery = _firestore.collection(collectionName);

      // Apply query conditions if provided
      query.forEach((key, value) {
        collectionQuery = collectionQuery.where(key, isEqualTo: value);
      });

      // Fetch query results
      QuerySnapshot querySnapshot = await collectionQuery.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        print('Document ID: ${doc.id}');
        print('Document Data: ${doc.data()}');
      }
    } catch (e) {
      print('Failed to query documents: $e');
    }
  }

  // Method to listen to changes in a collection
  void listenToCollectionChanges(
      String collectionName, Function(QuerySnapshot) onChange) {
    _firestore.collection(collectionName).snapshots().listen((querySnapshot) {
      onChange(querySnapshot);
    });
  }
}
