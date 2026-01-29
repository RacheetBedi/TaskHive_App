import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentChangesBody extends ConsumerStatefulWidget {
  const RecentChangesBody({super.key});
  @override
  ConsumerState<RecentChangesBody> createState() => _RecentChangesBodyState();
}

class _RecentChangesBodyState extends ConsumerState<RecentChangesBody> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Scrollable(
          viewportBuilder: (context, position) {
            return const Center(
              child: Column(
                children: [
                  //Future Widgets will go here
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}