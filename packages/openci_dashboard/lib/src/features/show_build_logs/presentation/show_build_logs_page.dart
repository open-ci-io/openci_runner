import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openci_dashboard/src/features/show_build_logs/presentation/detailed_logs/presentation/detailed_logs_page.dart';
import 'package:openci_dashboard/src/features/show_build_logs/presentation/show_build_logs_controller.dart';
import 'package:openci_dashboard/src/features/top/domain/user_data.dart';

class ShowBuildLogsPage extends ConsumerWidget {
  const ShowBuildLogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showBuildLogsControllerProvider);
    final controller = ref.watch(showBuildLogsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Build Info'),
        backgroundColor: Colors.blueAccent,
      ),
      body: state.when(
        data: (data) {
          final userData = data.userData;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButton<String>(
                    hint: const Text('Please choose your org'),
                    value: data.selectedOrg,
                    onChanged: (newValue) async {
                      if (newValue != null) {
                        controller.updateOrg(newValue);
                        final data = await controller.fetchUserData();
                        if (data != null) {
                          controller.updateUserState(data);
                        }
                      }
                    },
                    items: data.joinedOrgs
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  if (userData != null) _List(userData)
                ],
              ),
            ),
          );
        },
        error: (e, s) => Text(e.toString()),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _List extends ConsumerWidget {
  const _List(
    this.userData,
  );

  final UserData userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(fetchBuildListProvider(userData.userId!));
    return future.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final build = data[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailedLogsPage(build['documentId'] as String),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(build['documentId'].toString()),
                  subtitle: Text(build['githubRepositoryUrl']),
                ),
              ),
            );
          },
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => const Text('loading'),
    );
  }
}
