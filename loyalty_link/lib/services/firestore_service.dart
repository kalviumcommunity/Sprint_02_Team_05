import 'package:cloud_firestore/cloud_firestore.dart';

/// FirestoreService – handles Cloud Firestore CRUD operations.
///
/// Provides Create, Read, Update, Delete for the 'users' and
/// 'customers' collections used by LoyaltyLink.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ═══════════════════ USER PROFILE ═══════════════════

  /// Create / overwrite user profile data after sign-up.
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).set(data);
  }

  /// Read user profile by UID.
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  // ═══════════════════ CUSTOMERS (CRUD) ═══════════════════

  /// Create – add a new customer to the business owner's sub-collection.
  Future<DocumentReference> addCustomer(
    String ownerUid,
    Map<String, dynamic> data,
  ) async {
    return _db
        .collection('users')
        .doc(ownerUid)
        .collection('customers')
        .add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Read – real-time stream of all customers for a business owner.
  Stream<QuerySnapshot> getCustomers(String ownerUid) {
    return _db
        .collection('users')
        .doc(ownerUid)
        .collection('customers')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Update – modify an existing customer document.
  Future<void> updateCustomer(
    String ownerUid,
    String customerId,
    Map<String, dynamic> data,
  ) async {
    await _db
        .collection('users')
        .doc(ownerUid)
        .collection('customers')
        .doc(customerId)
        .update(data);
  }

  /// Delete – remove a customer document.
  Future<void> deleteCustomer(String ownerUid, String customerId) async {
    await _db
        .collection('users')
        .doc(ownerUid)
        .collection('customers')
        .doc(customerId)
        .delete();
  }
}
