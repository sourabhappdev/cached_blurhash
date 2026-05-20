import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_blurhash/cached_blurhash.dart';

void main() {
  testWidgets('BlurHash widget basic smoke test', (WidgetTester tester) async {
    const String testHash = 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: CachedBlurhash(
                hash: testHash,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(CachedBlurhash), findsOneWidget);

    final CachedBlurhash blurHash = tester.widget(find.byType(CachedBlurhash));
    expect(blurHash.hash, equals(testHash));
    expect(blurHash.image, isNull);
  });
}
