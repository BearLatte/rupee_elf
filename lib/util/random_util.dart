import 'dart:math';

class RandomUtil {
  static String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  static String randomScore() {
    List<String> scores = ['4.8', '4.9', '5.0'];
    return scores[Random().nextInt(3) + 0];
  }
}
