// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:onlineshopping/main.dart';
import 'package:onlineshopping/navigation_bar.dart';

void main() {
  testWidgets('app provides light and dark themes based on system setting', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme?.brightness, Brightness.light);
    expect(app.darkTheme?.brightness, Brightness.dark);
    expect(app.themeMode, ThemeMode.system);

    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.dark,
    );

    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.light;
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.light,
    );
    tester.binding.platformDispatcher.clearPlatformBrightnessTestValue();
  });

  testWidgets('login screen shows username, password, and login button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text('Register Now'), findsOneWidget);
  });

  testWidgets('valid login form opens home navigation and replaces login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Login').last);
    await tester.pump();
    expect(find.text('Enter your username'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(find.text('Home page'), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Login').last);
    await tester.pumpAndSettle();

    expect(find.text('Home page'), findsOneWidget);
    expect(find.text('Create Account'), findsNothing);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Home page'), findsOneWidget);
    expect(find.text('Username'), findsNothing);
  });

  testWidgets('registration form submits validation and links back to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Register Now'));
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.text('First name'), findsOneWidget);
    expect(find.text('Last name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('Already registered?'), findsOneWidget);

    final registrationFields = tester
        .widgetList<InputDecorator>(find.byType(InputDecorator))
        .toList();
    expect(
      registrationFields.map((field) => field.decoration.labelText).toList(),
      ['First name', 'Last name', 'Email', 'Phone number', 'Password'],
    );

    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Enter your first name'), findsOneWidget);
    expect(find.text('Enter your last name'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);

    await tester.ensureVisible(find.text('Sign in'));
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsNWidgets(2));
  });

  testWidgets('phone back navigation returns from registration to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Register Now'));
    await tester.pumpAndSettle();
    expect(find.text('Create Account'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsNothing);
    expect(find.text('Login'), findsNWidgets(2));
  });

  testWidgets('bottom navigation switches between four destinations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: Home()));

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Store'), findsOneWidget);
    expect(find.text('Wishlist'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    const destinations = ['Store', 'Wishlist', 'Profile', 'Home'];
    for (var index = 0; index < destinations.length; index++) {
      final destination = destinations[index];
      await tester.tap(find.text(destination).last);
      await tester.pumpAndSettle();
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
        index == destinations.length - 1 ? 0 : index + 1,
      );
      expect(find.text('$destination page'), findsOneWidget);
    }
  });
}
