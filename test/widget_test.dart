import 'package:flutter_test/flutter_test.dart';
import 'package:tontonaja/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build aplikasi dan verifikasi berjalan tanpa error
    await tester.pumpWidget(const TontonAjaApp());
    expect(find.text('TontonAja'), findsWidgets);
  });
}
