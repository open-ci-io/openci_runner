import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openci_dashboard/src/features/show_build_logs/presentation/detailed_logs/presentation/detailed_logs_controller.dart';

class DetailedLogsPage extends ConsumerWidget {
  const DetailedLogsPage(this.documentId, {super.key});

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(fetchLogsProvider(documentId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Logs'),
      ),
      body: future.when(
          data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final log = data[index];
                  return Card(
                    child: ListTile(title: Text(log['command'].toString())),
                  );
                });
          },
          error: (e, s) => Text(e.toString()),
          loading: () => const CircularProgressIndicator()),
    );
  }
}
