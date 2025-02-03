import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_flutter/features/dashboard/presentation/animal_type_widget.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('animal type widget displays name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimalType(name: 'Bob'),
      ),
    );

    final nameTitle = find.text('Bob');
    expect(nameTitle, findsOneWidget);
  });

  testWidgets('animal type widget navigates to items', (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const AnimalType(name: 'Bob'),
            ),
            GoRoute(
              path: '/items',
              builder: (context, state) => Text('Test ${state.extra}'),
            ),
          ],
        ),
      ),
    );

    final nameTitle = find.text('Bob');
    await tester.tap(nameTitle);
    await tester.pump();
    await tester.pump(); //Second pump for navigation

    final nameTestText = find.text('Test Bob');
    expect(nameTestText, findsOneWidget);
  });
}
