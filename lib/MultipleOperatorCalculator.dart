import 'package:flutter/foundation.dart';

class MultipleOperatorCalculator {
  int pos = -1;

  double eval(final String str) {
    var ch;

    void nextChar() {
      ch = (++pos < str.length) ? str[pos] : "-1";
    }

    bool eat(var charToEat) {
      while (ch == ' ') {
        nextChar();
      }
      if (ch == charToEat) {
        nextChar();
        return true;
      }
      return false;
    }

    double parseFactor() {
      if (eat('+')) return parseFactor(); // unary plus
      if (eat('-')) return parseFactor(); // unary minus


      double x = 0;
      int startPos = pos;
      if (ch == '0' ||
          ch == '1' ||
          ch == '2' ||
          ch == '3' ||
          ch == '4' ||
          ch == '5' ||
          ch == '6' ||
          ch == '7' ||
          ch == '8' ||
          ch == '9' ||
          ch == '.') {
        // numbers
        while (ch == '0' ||
            ch == '1' ||
            ch == '2' ||
            ch == '3' ||
            ch == '4' ||
            ch == '5' ||
            ch == '6' ||
            ch == '7' ||
            ch == '8' ||
            ch == '9' ||
            ch == '.') {
          nextChar();
        }
        x = double.parse(str.substring(startPos, pos));
      } /*else if (ch >= 'a' && ch <= 'z') {
        // functions
        while (ch >= 'a' && ch <= 'z') {
          nextChar();
        }


        x = parseFactor();
      }*/
      return x;
    }

    double parseTerm() {
      double x = parseFactor();
      for (;;) {
        if (eat('*')) {
          x *= parseFactor();
        } else if (eat('/')) {
          x /= parseFactor();
        } else {
          return x;
        }
      }
    }

    double parseExpression() {
      double x = parseTerm();
      for (;;) {
        if (eat('+')) {
          x += parseTerm();
        } else if (eat('-')) {
          x -= parseTerm();
        } else {
          return x;
        }
      }
    }

    double parse2() {
      nextChar();
      double x = parseExpression();
      if (pos < str.length) {
        try {
          throwException();
        } on CustomException {
          if (kDebugMode) {
            print("custom exception has been obtained");
          }
        }
      }
      return x;
    }

    ch =parse2();

    if (ch == null){
      return 0.0;
    }
    return ch.toDouble();
  }

  throwException() {
    throw CustomException('This is my first custom exception');
  }
}

class CustomException implements Exception {
  String cause;

  CustomException(this.cause);
}
