import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_radar/login.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets(
    'Login test has an username and password input, with a keep signed in checkbox and login button',
    (WidgetTester tester) async {
      Widget testWidget = const MediaQuery(
          data: MediaQueryData(), child: MaterialApp(home: LoginPage()));
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(testWidget);

      // Create the Finders.
      final textFieldFinder = find.byType(TextField);
      final checkboxFinder = find.byType(CheckboxListTile);
      final loginButtonFinder = find.byType(MaterialButton);

      // Verify that they are there
      expect(textFieldFinder, findsAtLeastNWidgets(2));
      expect(checkboxFinder, findsOneWidget);
      expect(loginButtonFinder, findsOneWidget);

      // Converts the widgets to variables
      TextField username =
          textFieldFinder.at(0).evaluate().first.widget as TextField;
      TextField password =
          textFieldFinder.at(1).evaluate().first.widget as TextField;

      // Enter 'wilma52' into the TextField.
      await tester.enterText(textFieldFinder.at(0), 'wilma52');
      // Enter 'wrong password' into the password field
      await tester.enterText(textFieldFinder.at(1), 'wrong password');

      // Verify the inputs
      expect(username.controller?.value.text, "wilma52");
      expect(password.controller?.value.text, "wrong password");

      // Pump the widget
      await tester.pumpWidget(testWidget);

      // Get the login button
      final loginButton =
          loginButtonFinder.evaluate().first.widget as MaterialButton;
      // Evaluates if the button is enabled
      expect(loginButton.onPressed, isNotNull);

      // Gets the checkbox
      CheckboxListTile checkbox = checkboxFinder.first.evaluate().first.widget as CheckboxListTile;

      // Checkbox is not selected by default.
      expect(checkbox.value, false);

      // Taps the checkbox
      await tester.tap(checkboxFinder);

      // Taps the button
      await tester.tap(loginButtonFinder);

      // Pumps the widget
      await tester.pumpWidget(testWidget);
      
      // Updates the checkbox variable with the new info
      checkbox = checkboxFinder.first.evaluate().first.widget as CheckboxListTile;
      // Checkbox should now be selected
      expect(checkbox.value, true);

      // Updates the variables
      username = textFieldFinder.at(0).evaluate().first.widget as TextField;
      password = textFieldFinder.at(1).evaluate().first.widget as TextField;

      // Checks that the input was indeed incorrect
      expect(username.decoration?.errorText, "Login information is invalid");
      expect(password.decoration?.errorText, "Login information is invalid");
    },
  );
}
