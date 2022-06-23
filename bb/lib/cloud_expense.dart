
import 'package:bb/cloud_storage_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


@immutable
class CloudExpense {
  final String documentId;
  final String ownerUserId;
  final String title;
  final double price;
  final String duration;

  const CloudExpense({
    required this.documentId,
    required this.ownerUserId,
    required this.title,
    required this.price,
    required this.duration,
  });
  CloudExpense.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
  : documentId = snapshot.id,
  ownerUserId = snapshot.data()[ownerUserIdFieldName],
  title = snapshot.data()[categoryFieldName] as String,
  price = snapshot.data()[priceFieldName] as double,
  duration = snapshot.data()[durationFieldName] as String;
}


