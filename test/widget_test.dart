import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:litebite/app_theme.dart';
import 'package:litebite/main.dart';
import 'package:litebite/splashscrn.dart';

void main() {
  testWidgets('app uses Lite Bite warm theme', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.title, 'Lite Bite');
    expect(app.theme!.scaffoldBackgroundColor, cream);
    expect(app.theme!.colorScheme.primary, orange);
    expect(find.byType(Splashscrn), findsOneWidget);
  });
}
