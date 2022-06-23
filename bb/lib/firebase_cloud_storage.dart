import 'package:bb/cloud_expense.dart';
import 'package:bb/cloud_storage_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudStorage {
  final expense = FirebaseFirestore.instance.collection("expense");

  Future<void> deleteExpense({
    required String documentId,
  }) async {
    try {
      await expense.doc(documentId).delete();
    } catch (e) {
      // throw CouldNotDeleteExpenseException();
    }
  }

  // Future<void> updateNote({
  //   required String documentId,
  //   required String text,
  // }) async {
  //   try {
  //     await expense.doc(documentId).update({textFieldName: text});
  //   } catch (e) {
  //     throw CouldNotUpdateexpenseException();
  //   }
  // }

  Future<CloudExpense> createNewExpense({required String ownerUserId}) async {
    final document = await expense.add({
      ownerUserIdFieldName: ownerUserId,
      categoryFieldName: "",
      priceFieldName: 0.0,
      durationFieldName: "",
    });
    final fetchedExpense = await document.get();
    return CloudExpense(
        documentId: fetchedExpense.id,
        ownerUserId: ownerUserId,
        title: categoryFieldName,
        price: double.parse(priceFieldName),
        duration: durationFieldName);
  }

  // Stream<Iterable<CloudNote>> allexpense({required String ownerUserId}) => expense
  //     .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
  //     .snapshots()
  //     .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)));

  // Future<Iterable<CloudNote>> getexpense({required String ownerUserId}) async {
  //   try {
  //     return await expense
  //         .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
  //         .get()
  //         .then((value) => value.docs.map(
  //               (doc) => CloudNote.fromSnapshot(doc),
  //             ));
  //   } catch (e) {
  //     throw CouldNotGetAllexpenseException();
  //   }
  // }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
