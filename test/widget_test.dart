import 'package:exam_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Home screen'), findsOneWidget);
  });
}
