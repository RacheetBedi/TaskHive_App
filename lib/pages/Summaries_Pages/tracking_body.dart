import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';

class TrackingBody extends StatelessWidget {
  const TrackingBody({super.key, required void Function(NavigationPage page) onNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Scrollable(
          viewportBuilder: (context, position) {
            return const Center(
              child: Column(children: [/* Future Widgets */]),
            );
          },
        ),
      ),
    );
  }
}