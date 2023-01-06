import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

enum Collections { wods, records }

enum NetworkStatus { initial, processing, success, error }

extension NetworkStatusEx on NetworkStatus {
  bool get isInitial => this == NetworkStatus.initial;

  bool get isProcessing => this == NetworkStatus.processing;

  bool get isSuccess => this == NetworkStatus.success;

  bool get isError => this == NetworkStatus.error;
}
