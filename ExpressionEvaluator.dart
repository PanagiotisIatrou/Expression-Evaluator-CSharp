import 'dart:collection';
import 'dart:math';

enum Operator { Addition, Subtraction, Multiplication, Division, Modulo, Exponent, Null }

class Evaluator {
  static bool _wasDigit;
  static String _number = '';
  static String _e = "2.71828182";
  static String _pi = "3.14159265";

  /*static public void Setup()
		{
			CultureInfo customCulture = (CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
			customCulture.NumberFormat.NumberDecimalSeparator = ".";
			System.Threading.Thread.CurrentThread.CurrentCulture = customCulture;
		}*/

  static double Evaluate(String expression) {
    Queue<double> Operators = new Queue<double>();
    Queue<String> Operands = new Queue<String>();

    // Format the expression so that its calculatable
    expression = expression.replaceAll("e", _e);
    expression = expression.replaceAll("π", _pi);

    // Do the calculations and return the result
    for (int i = 0; i < expression.length; i++) {
      String c = expression[i];

      if (isDigit(c)) {
        _wasDigit = true;

		
        print('_number is $_number and c is $c');


        _number += c;
        if (i == expression.length - 1) // last iteration
        {
          double num = double.parse(_number);
          Operators.add(num);
          _wasDigit = false;
          _number = "";
        }
      } else {
        if (_wasDigit) // Add the previous number to our stack
        {
          double num = double.parse(_number);
          Operators.add(num);
          _wasDigit = false;
          _number = "";
        }

        if (isLeftPar(c)) {
          Operands.add(c);
        } else if (isRightPar(c)) {
          while (!isLeftPar(c)) {
            double num1 = Operators.removeLast();
            double num2 = Operators.removeLast();
            String op = Operands.removeLast();
            double endResult = calculateTwo(num1, num2, op);
            Operators.add(endResult);
            c = Operands.removeLast();
          }
        } else if (isOperator(c)) {
          if (_wasDigit) // Add the previous number to our stack
          {
            double num = double.parse(_number);
            Operators.add(num);
            _wasDigit = false;
            _number = "";
          }

          bool empty = Operands.length == 0;
          if (!empty) {
            String c2 = Operands.last;
            if (operatorNum(operatorPower(c2)) >= operatorNum(operatorPower(c))) {
              double num1 = Operators.removeLast();
              double num2 = Operators.removeLast();
              String op = Operands.removeLast();

              double endResult = calculateTwo(num1, num2, op);

              Operators.add(endResult);
            }
          }
          Operands.add(c);
        }
      }
    }

    while (Operands.length > 0) {
      double num1 = Operators.removeLast();
      double num2 = Operators.removeLast();
      String op = Operands.removeLast();

      double endResult = calculateTwo(num1, num2, op);
      Operators.add(endResult);
    }

    return double.parse(Operators.removeLast().toStringAsFixed(8));
  }

  static bool isDigit(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null || s == '.';
  }

  /*static bool isDigit(String c)
		{
			return String.IsNumber(c) || c == '.';
		}*/

  static bool isOperator(String c) {
    return c == '+' || c == '-' || c == '*' || c == '/' || c == '%' || c == '^';
  }

  static bool isLeftPar(String c) {
    return c == '(';
  }

  static bool isRightPar(String c) {
    return c == ')';
  }

  static double calculateTwo(double num1, double num2, String op) {
    double result = 0.0;
    if (op == '+')
      result = num2 + num1;
    else if (op == '-')
      result = num2 - num1;
    else if (op == '*')
      result = num2 * num1;
    else if (op == '/')
      result = num2 / num1;
    else if (op == '^')
      result = pow(num2, num1);
    else if (op == '%') result = num2 % num1;

    return result;
  }

  static Operator operatorPower(String c) {
    Operator op = c == '+'
        ? Operator.Addition
        : (c == '-'
            ? Operator.Subtraction
            : (c == '*'
                ? Operator.Multiplication
                : (c == '/'
                    ? Operator.Division
                    : (c == '%' ? Operator.Modulo : (c == '^' ? Operator.Exponent : Operator.Null)))));
    return op;
  }

  static int operatorNum(Operator op) {
    if (op == Operator.Addition)
      return 1;
    else if (op == Operator.Subtraction)
      return 1;
    else if (op == Operator.Multiplication)
      return 2;
    else if (op == Operator.Division)
      return 2;
    else if (op == Operator.Modulo)
      return 2;
    else if (op == Operator.Exponent)
      return 3;
    else
      return 0;
  }
}
