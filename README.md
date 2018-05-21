# Expression-Evaluation
Evaluate an expression represented by a String!

# How to implement
### Visual Studio 2017:
1) Download the ExpressionEvaluator.dll
2) Right click on "Dependencies" in the Project Solution Explorer.
3) Select "Add Reference"
4) Click Browse
5) Navigate to the ExpressionEvaluator.dll you downloaded and double click it
6) Select the box and click "OK"
7) Done!

# How to use:
1) Use the ExpressionEvaluator namespace:
```CSharp
using ExpressionEvaluation;
```
2) Call the Setup function before calculating anything, usually in the start of Main:
```CSharp
Evaluator.Setup();
```
3) You can now start calculating!

# Examples:
- Stores 2 in 'number'
```CSharp
double number = Evaluator.Evaluate("1+1"); // 2
double number = Evaluator.Evaluate("10-1"); // 9
double number = Evaluator.Evaluate("10/3"); // 3.33333333
double number = Evaluator.Evaluate("5^2"); // 25
double number = Evaluator.Evaluate("5^3"); // 125
double number = Evaluator.Evaluate("5%2"); // 1
double number = Evaluator.Evaluate("5.5%2"); // 1.5
double number = Evaluator.Evaluate("2+5*2"); // 12
double number = Evaluator.Evaluate("1.234^8+5/2"); // 7.87676775
double number = Evaluator.Evaluate("(2+5)*2"); // 14
double number = Evaluator.Evaluate("e^2"); // 7.38905605
double number = Evaluator.Evaluate("π^2"); // 9.86960438
```

# Currently supports:
- Addition (+)
- Subtraction (-)
- Multiplication (\*)
- Division (/)
- Exponent (^)
- Modulo (%)
- e (2.71828182)
- π (3.14159265)
- Left parenthesis (()
- Right parenthesis ())
