import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: const Center(child: Text('Farm Recorder')),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'My Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Record Activity'),
          ],
        ),
      ),
    ));

    expect(find.text('Farm Recorder'), findsOneWidget);
    expect(find.byIcon(Icons.task_alt), findsOneWidget);
    expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
  });
}
