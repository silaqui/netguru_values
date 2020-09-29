import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Netguru Values Application', () {
    final valueTextField = find.byValueKey('value text field');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Should show some value on screen', () async {
      //given
      //when
      String actual = await driver.getText(valueTextField);
      //then
      expect(actual.isNotEmpty, true);
    });
  });
}
