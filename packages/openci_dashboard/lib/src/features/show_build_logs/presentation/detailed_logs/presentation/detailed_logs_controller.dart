import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'detailed_logs_controller.g.dart';

@riverpod
class DetailedLogsController extends _$DetailedLogsController {
  @override
  void build() {
    return;
  }
}

@riverpod
Future<dynamic> fetchLogs(FetchLogsRef ref, String documentId) async {
  QuerySnapshot<Map<String, dynamic>>? qs;

  qs = await FirebaseFirestore.instance
      .collection('jobs')
      .doc(documentId)
      .collection('logs')
      .orderBy(
        'createdAt',
      )
      .get();
  final buildList = <dynamic>[];
  for (final docs in qs.docs) {
    final map = docs.data();
    buildList.add(map);
  }
  return buildList;
}
