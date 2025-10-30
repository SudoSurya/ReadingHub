# Python Data Structures

Data structures are fundamental building blocks in Python programming. They allow you to organize and store data efficiently for various operations.

## Lists

Lists are ordered, mutable collections of items. They can contain mixed data types.

### Creating Lists

```python
# Empty list
my_list = []

# List with items
numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]
mixed = [1, "hello", 3.14, True]

# Using list constructor
another_list = list(range(5))  # [0, 1, 2, 3, 4]
```

### List Operations

```python
fruits = ["apple", "banana"]

# Add items
fruits.append("cherry")           # Add to end
fruits.insert(1, "orange")        # Insert at index
fruits.extend(["grape", "kiwi"])  # Add multiple

# Remove items
fruits.remove("banana")           # Remove by value
fruits.pop()                      # Remove last item
fruits.pop(0)                     # Remove by index
del fruits[0]                     # Delete by index

# Access items
print(fruits[0])      # First item
print(fruits[-1])     # Last item

# Slicing
print(fruits[1:3])    # Items 1 to 2
print(fruits[:2])     # First 2 items
print(fruits[2:])     # Items from index 2
```

### List Methods

```python
numbers = [3, 1, 4, 1, 5, 9, 2, 6]

# Sorting
numbers.sort()              # In-place sort
sorted_numbers = sorted(numbers)  # New sorted list

# Counting
count = numbers.count(1)    # Count occurrences
index = numbers.index(4)    # Find index

# Other methods
length = len(numbers)       # Get length
numbers.reverse()           # Reverse list
numbers.clear()             # Clear all items
```

### List Comprehensions

```python
# Traditional approach
squares = []
for x in range(5):
    squares.append(x ** 2)

# List comprehension
squares = [x ** 2 for x in range(5)]

# With condition
evens = [x for x in range(10) if x % 2 == 0]

# Nested comprehension
matrix = [[i*j for j in range(3)] for i in range(3)]
```

## Tuples

Tuples are ordered, immutable collections. They're like lists but cannot be modified after creation.

### Creating Tuples

```python
# Empty tuple
my_tuple = ()

# Tuple with items
coordinates = (10, 20)
colors = ("red", "green", "blue")

# Single item tuple (note the comma)
single = (42,)

# Without parentheses
point = 1, 2, 3
```

### Tuple Operations

```python
point = (3, 5)

# Access items
print(point[0])   # 3
print(point[1])   # 5

# Unpacking
x, y = point
print(x, y)       # 3 5

# Multiple assignments
a, b, c = (1, 2, 3)

# Tuple methods
colors = ("red", "green", "red")
count = colors.count("red")  # 2
index = colors.index("green")  # 1
```

### When to Use Tuples

- **Immutable data**: When you want to prevent modifications
- **Dictionary keys**: Can be used as keys (unlike lists)
- **Return values**: Functions can return multiple values
- **Performance**: Slightly faster than lists

```python
# Returning multiple values
def get_name_age():
    return "Alice", 30

name, age = get_name_age()
```

## Dictionaries

Dictionaries are unordered collections of key-value pairs. Keys must be unique and immutable.

### Creating Dictionaries

```python
# Empty dictionary
my_dict = {}

# Dictionary with items
student = {
    "name": "Alice",
    "age": 20,
    "grade": "A"
}

# Using dict constructor
person = dict(name="Bob", age=25)

# From list of tuples
pairs = [("a", 1), ("b", 2)]
my_dict = dict(pairs)
```

### Dictionary Operations

```python
student = {"name": "Alice", "age": 20}

# Access values
name = student["name"]           # Using key
age = student.get("age")         # Using get() method
grade = student.get("grade", "N/A")  # With default

# Add/update items
student["grade"] = "A"           # Add/update
student.update({"city": "NYC"})  # Update multiple

# Remove items
del student["age"]               # Delete key
grade = student.pop("grade")     # Remove and return
student.clear()                  # Clear all

# Check existence
if "name" in student:
    print("Name exists")

# Get all keys/values
keys = student.keys()
values = student.values()
items = student.items()
```

### Dictionary Comprehensions

```python
# Traditional approach
squares_dict = {}
for x in range(5):
    squares_dict[x] = x ** 2

# Dictionary comprehension
squares_dict = {x: x ** 2 for x in range(5)}

# With condition
odds_squared = {x: x ** 2 for x in range(10) if x % 2 == 1}

# From another dictionary
original = {'a': 1, 'b': 2, 'c': 3}
doubled = {k: v * 2 for k, v in original.items()}
```

## Sets

Sets are unordered collections of unique elements. They're useful for membership testing and eliminating duplicates.

### Creating Sets

```python
# Empty set
my_set = set()

# Set with items
numbers = {1, 2, 3, 4, 5}
colors = {"red", "green", "blue"}

# From list
unique_numbers = set([1, 2, 2, 3, 3, 4])

# Set comprehension
evens = {x for x in range(10) if x % 2 == 0}
```

### Set Operations

```python
a = {1, 2, 3, 4}
b = {3, 4, 5, 6}

# Add/remove
a.add(5)
a.remove(3)
a.discard(10)  # Remove if exists (no error)

# Set operations
union = a | b              # {1, 2, 3, 4, 5, 6}
intersection = a & b       # {3, 4}
difference = a - b         # {1, 2}
symmetric_diff = a ^ b     # {1, 2, 5, 6}

# Membership testing
is_member = 3 in a

# Set methods
c = a.copy()
a.clear()
```

## Nested Data Structures

### Lists of Lists

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

print(matrix[0][0])  # 1
print(matrix[1][2])  # 6
```

### Lists of Dictionaries

```python
students = [
    {"name": "Alice", "age": 20, "grade": "A"},
    {"name": "Bob", "age": 21, "grade": "B"},
    {"name": "Charlie", "age": 19, "grade": "A"}
]

# Access
print(students[0]["name"])  # Alice

# Modify
students[1]["grade"] = "A"
```

### Dictionary of Lists

```python
grades = {
    "math": [85, 90, 78],
    "science": [92, 88, 95],
    "english": [78, 82, 80]
}

# Access
math_grades = grades["math"]
print(math_grades[0])  # 85
```

## Common Operations Across Data Structures

### Iteration

```python
# List
for item in [1, 2, 3]:
    print(item)

# Dictionary
person = {"name": "Alice", "age": 30}
for key, value in person.items():
    print(f"{key}: {value}")

# Set
for item in {1, 2, 3}:
    print(item)
```

### Membership Testing

```python
# Lists and Tuples
3 in [1, 2, 3]        # True
3 in (1, 2, 3)        # True

# Dictionaries (checks keys)
"name" in {"name": "Alice"}  # True

# Sets
3 in {1, 2, 3}        # True
```

### Length

```python
len([1, 2, 3])           # 3
len((1, 2, 3))           # 3
len({"a": 1, "b": 2})    # 2
len({1, 2, 3})           # 3
```

## When to Use Each Structure

| Structure | Mutable | Ordered | Unique Keys | Use Case |
|-----------|---------|---------|-------------|----------|
| **List** | Yes | Yes | No | Ordered collections, dynamic arrays |
| **Tuple** | No | Yes | No | Immutable sequences, coordinates |
| **Dictionary** | Yes | No (3.7+ ordered) | Yes | Key-value mappings, databases |
| **Set** | Yes | No | Yes | Unique items, membership testing |

## Summary

Python data structures provide flexible ways to organize data:

- **Lists**: Ordered, mutable collections
- **Tuples**: Ordered, immutable collections
- **Dictionaries**: Key-value mappings
- **Sets**: Unique element collections

Each structure has specific use cases and methods that make Python powerful for data manipulation and organization.

