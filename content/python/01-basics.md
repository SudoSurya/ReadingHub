# Python Basics

Python is a high-level, interpreted programming language known for its simplicity and readability. It's used for web development, data science, artificial intelligence, automation, and more.

## Why Python?

Python has several advantages that make it popular:

- **Simple and Readable**: Clean syntax that's easy to learn
- **Versatile**: Used in web development, data science, AI, automation
- **Large Ecosystem**: Extensive libraries and frameworks
- **Cross-Platform**: Runs on Windows, macOS, and Linux
- **Community Support**: Large, active developer community

## Installation

### Windows

1. Download Python from [python.org](https://www.python.org)
2. Run the installer
3. Check "Add Python to PATH"
4. Verify: `python --version`

### Linux

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip

# Verify
python3 --version
```

### macOS

```bash
# Using Homebrew
brew install python3

# Verify
python3 --version
```

## First Program

Let's start with a classic "Hello, World!" program:

```python
print("Hello, World!")
```

Save this as `hello.py` and run:

```bash
python hello.py
# Output: Hello, World!
```

## Variables and Data Types

### Basic Data Types

Python has several built-in data types:

```python
# Numbers
age = 25
height = 5.9
pi = 3.14159

# Strings
name = "John Doe"
greeting = 'Hello'

# Boolean
is_student = True
has_job = False

# None (null in other languages)
result = None

# Type checking
print(type(age))    # <class 'int'>
print(type(height)) # <class 'float'>
print(type(name))   # <class 'str'>
```

### Type Conversion

```python
# String to int
age_str = "25"
age = int(age_str)

# Int to string
age = 25
age_str = str(age)

# Float to int
price = 19.99
price_int = int(price)  # 19

# Int to float
count = 5
count_float = float(count)  # 5.0
```

## Strings

### String Operations

```python
# Concatenation
first_name = "John"
last_name = "Doe"
full_name = first_name + " " + last_name

# String formatting (f-strings)
name = "Alice"
age = 30
message = f"My name is {name} and I'm {age} years old"

# Old style
message = "My name is %s and I'm %d years old" % (name, age)

# Using .format()
message = "My name is {} and I'm {} years old".format(name, age)

# String methods
text = "Hello World"
print(text.upper())        # HELLO WORLD
print(text.lower())        # hello world
print(text.capitalize())   # Hello world
print(len(text))           # 11
print(text.replace("World", "Python"))  # Hello Python
```

### String Indexing and Slicing

```python
text = "Python"

# Indexing
print(text[0])   # P
print(text[-1])  # n (last character)

# Slicing
print(text[0:3])  # Pyt
print(text[:3])   # Pyt (from start)
print(text[3:])   # hon (to end)
```

## Operators

### Arithmetic Operators

```python
a = 10
b = 3

print(a + b)  # 13 (Addition)
print(a - b)  # 7  (Subtraction)
print(a * b)  # 30 (Multiplication)
print(a / b)  # 3.333... (Division)
print(a // b) # 3  (Floor division)
print(a % b)  # 1  (Modulus)
print(a ** b) # 1000 (Exponentiation)
```

### Comparison Operators

```python
a = 10
b = 20

print(a == b)  # False (Equal)
print(a != b)  # True  (Not equal)
print(a < b)   # True  (Less than)
print(a > b)   # False (Greater than)
print(a <= b)  # True  (Less than or equal)
print(a >= b)  # False (Greater than or equal)
```

### Logical Operators

```python
a = True
b = False

print(a and b)  # False
print(a or b)   # True
print(not a)    # False
```

## Control Flow

### If-Else Statements

```python
age = 20

if age >= 18:
    print("You are an adult")
else:
    print("You are a minor")

# Multiple conditions
score = 85

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"

print(f"Grade: {grade}")
```

### Loops

#### For Loop

```python
# Range
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4

# Range with start and stop
for i in range(1, 6):
    print(i)  # 1, 2, 3, 4, 5

# Range with step
for i in range(0, 10, 2):
    print(i)  # 0, 2, 4, 6, 8

# Iterating over lists
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)
```

#### While Loop

```python
count = 0
while count < 5:
    print(count)
    count += 1

# Break and continue
i = 0
while i < 10:
    i += 1
    if i == 3:
        continue  # Skip 3
    if i == 8:
        break     # Stop at 8
    print(i)
```

## Functions

### Defining Functions

```python
def greet(name):
    return f"Hello, {name}!"

message = greet("Alice")
print(message)  # Hello, Alice!
```

### Function with Multiple Parameters

```python
def add(a, b):
    return a + b

result = add(5, 3)
print(result)  # 8
```

### Default Parameters

```python
def greet(name, greeting="Hello"):
    return f"{greeting}, {name}!"

print(greet("Alice"))           # Hello, Alice!
print(greet("Bob", "Hi"))       # Hi, Bob!
```

### Keyword Arguments

```python
def create_person(name, age, city):
    return f"{name}, {age} years old, from {city}"

# Using keyword arguments
person = create_person(city="New York", name="Alice", age=30)
print(person)
```

### Lambda Functions

```python
# Simple lambda
square = lambda x: x ** 2
print(square(5))  # 25

# Lambda with multiple parameters
add = lambda a, b: a + b
print(add(3, 4))  # 7
```

## Common Built-in Functions

| Function | Description | Example |
|----------|-------------|---------|
| `len()` | Get length | `len("hello")` → 5 |
| `str()` | Convert to string | `str(123)` → "123" |
| `int()` | Convert to integer | `int("123")` → 123 |
| `float()` | Convert to float | `float("3.14")` → 3.14 |
| `type()` | Get type | `type(5)` → <class 'int'> |
| `input()` | Get user input | `name = input("Name: ")` |
| `print()` | Print to console | `print("Hello")` |
| `range()` | Generate range | `range(5)` → 0,1,2,3,4 |
| `abs()` | Absolute value | `abs(-5)` → 5 |
| `max()` | Maximum value | `max(1,5,3)` → 5 |
| `min()` | Minimum value | `min(1,5,3)` → 1 |
| `sum()` | Sum of values | `sum([1,2,3])` → 6 |

## Comments

```python
# This is a single-line comment

"""
This is a multi-line comment
or docstring
"""

def my_function():
    """
    This is a function docstring
    that explains what the function does
    """
    pass
```

## Working with Files

```python
# Writing to a file
with open("example.txt", "w") as file:
    file.write("Hello, World!")

# Reading from a file
with open("example.txt", "r") as file:
    content = file.read()
    print(content)

# Reading line by line
with open("example.txt", "r") as file:
    for line in file:
        print(line.strip())  # strip() removes newline
```

## Summary

Python basics include:

- **Variables**: Store different data types
- **Operators**: Arithmetic, comparison, logical
- **Control Flow**: if-else, loops
- **Functions**: Reusable blocks of code
- **Strings**: Text manipulation and formatting
- **Files**: Reading and writing data

These fundamentals are the foundation for learning more advanced Python concepts like data structures, object-oriented programming, and libraries.

