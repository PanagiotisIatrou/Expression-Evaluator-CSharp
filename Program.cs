using System;
using System.Collections.Generic;
using System.Globalization;

namespace ExpressionEvaluation
{
	class Program
	{
		static void Main(string[] args)
		{

		}
	}

	public class Evaluator
	{
		private enum Operator { Addition = 1, Subtraction = 1, Multiplication = 2, Division = 2, Modulo = 2, Exponent = 3, Null = 0 };
		static private bool wasDigit;
		static private string number;
		static private readonly string e = "2.71828182";
		static private readonly string pi = "3.14159265";

		static public void Setup()
		{
			CultureInfo customCulture = (CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
			customCulture.NumberFormat.NumberDecimalSeparator = ".";
			System.Threading.Thread.CurrentThread.CurrentCulture = customCulture;
		}

		static public double Evaluate(string expression)
		{
			Stack<double> Operators = new Stack<double>();
			Stack<char> Operands = new Stack<char>();

			// Format the expression so that its calculatable
			expression = expression.Replace("e", e);
			expression = expression.Replace("π", pi);

			// Do the calculations and return the result
			for (int i = 0; i < expression.Length; i++)
			{
				char c = expression[i];

				if (isDigit(c))
				{
					wasDigit = true;
					number += c.ToString();
					if (i == expression.Length - 1) // last iteration
					{
						double num = double.Parse(number);
						Operators.Push(num);
						wasDigit = false;
						number = "";
					}
				}
				else
				{
					if (wasDigit) // Add the previous number to our stack
					{
						double num = double.Parse(number);
						Operators.Push(num);
						wasDigit = false;
						number = "";
					}

					if (isLeftPar(c))
					{
						Operands.Push(c);
					}
					else if (isRightPar(c))
					{
						while (!isLeftPar(c))
						{
							double num1 = Operators.Pop();
							double num2 = Operators.Pop();
							char op = Operands.Pop();
							double endResult = calculateTwo(num1, num2, op);
							Operators.Push(endResult);
							c = Operands.Pop();
						}
					}
					else if (isOperator(c))
					{
						if (wasDigit) // Add the previous number to our stack
						{
							double num = double.Parse(number);
							Operators.Push(num);
							wasDigit = false;
							number = "";
						}

						bool empty = Operands.Count == 0;
						if (!empty)
						{
							char c2 = Operands.Peek();
							if (operatorPower(c2) >= operatorPower(c))
							{
								double num1 = Operators.Pop();
								double num2 = Operators.Pop();
								char op = Operands.Pop();

								double endResult = calculateTwo(num1, num2, op);

								Operators.Push(endResult);
							}
						}
						Operands.Push(c);
					}
				}
			}

			while (Operands.Count > 0)
			{
				double num1 = Operators.Pop();
				double num2 = Operators.Pop();
				char op = Operands.Pop();

				double endResult = calculateTwo(num1, num2, op);
				Operators.Push(endResult);

			}

			return Math.Round(Operators.Pop(), 8);
		}

		static bool isDigit(char c)
		{
			return Char.IsNumber(c) || c == '.';
		}

		static bool isOperator(char c)
		{
			return c == '+' || c == '-' || c == '*' || c == '/' || c == '%' || c == '^';
		}

		static bool isLeftPar(char c)
		{
			return c == '(';
		}

		static bool isRightPar(char c)
		{
			return c == ')';
		}

		static double calculateTwo(double num1, double num2, char op)
		{
			double result = 0;
			if (op == '+')
				result = num2 + num1;
			else if (op == '-')
				result = num2 - num1;
			else if (op == '*')
				result = num2 * num1;
			else if (op == '/')
				result = num2 / num1;
			else if (op == '^')
				result = Math.Pow(num2, num1);
			else if (op == '%')
				result = num2 % num1;

			return result;
		}

		static Operator operatorPower(char c)
		{
			Operator op = c == '+' ? Operator.Addition : (c == '-' ? Operator.Subtraction : (c == '*' ? Operator.Multiplication : (c == '/' ? Operator.Division : (c == '%' ? Operator.Modulo : (c == '^' ? Operator.Exponent : Operator.Null)))));
			return op;
		}
	}

}
