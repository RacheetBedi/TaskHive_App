import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryBody extends ConsumerStatefulWidget {
  const SummaryBody({super.key});
  @override
  ConsumerState<SummaryBody> createState() => _SummaryBodyState();
}

class _SummaryBodyState extends ConsumerState<SummaryBody> {

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