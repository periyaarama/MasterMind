import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a document to a collection
  Future<void> addDocumentToCollection(
      String collectionName, Map<String, dynamic> data) async {
    try {
      // Check if a document with the same email already exists
      QuerySnapshot existingDocs =
          await getDocumentByEmail(collectionName, data['email']);
      if (existingDocs.docs.isNotEmpty) {
        print(
            'Document with the same email already exists in $collectionName collection');
        return; // Return early to avoid duplicate entries
      }

      // Add the document if no duplicates found
      await _firestore.collection(collectionName).add(data);
      print('Document added to $collectionName collection');
    } catch (e) {
      print('Failed to add document: $e');
    }
  }

  // Method to fetch a document from a collection by email
  Future<QuerySnapshot> getDocumentByEmail(
      String collectionName, String email) async {
    try {
      // Query the 'users' collection for a document where 'email' matches the provided email
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionName)
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot; // Return the query snapshot
    } catch (e) {
      print('Failed to fetch document by email: $e');
      rethrow;
    }
  }

  // Method to update a document in a collection based on email
  Future<void> updateDocumentInCollection(
      String collectionName, String email, Map<String, dynamic> data) async {
    try {
      // Fetch the document by email
      QuerySnapshot querySnapshot =
          await getDocumentByEmail(collectionName, email);

      // Ensure there is exactly one matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String documentId = querySnapshot.docs.first.id;

        // Update the document using its ID
        await _firestore
            .collection(collectionName)
            .doc(documentId)
            .update(data);
        print('Document updated in $collectionName collection');
      } else {
        print('No matching document found with email: $email');
      }
    } catch (e) {
      print('Failed to update document: $e');
    }
  }

  // Method to delete a document from a collection based on email
  Future<void> deleteDocumentFromCollection(
      String collectionName, String email) async {
    try {
      // Fetch the document by email
      QuerySnapshot querySnapshot =
          await getDocumentByEmail(collectionName, email);

      // Ensure there is exactly one matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String documentId = querySnapshot.docs.first.id;

        // Delete the document using its ID
        await _firestore.collection(collectionName).doc(documentId).delete();
        print('Document deleted from $collectionName collection');
      } else {
        print('No matching document found with email: $email');
      }
    } catch (e) {
      print('Failed to delete document: $e');
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
