# Object-Oriented Programming in Java

Object-Oriented Programming (OOP) is a programming paradigm based on the concept of "objects" that contain data and code to manipulate that data. Java is fundamentally an object-oriented language.

## Core OOP Concepts

### 1. Classes and Objects

A **class** is a blueprint for creating objects. An **object** is an instance of a class.

```java
// Class definition
class Dog {
    // Fields (attributes)
    String name;
    String breed;
    int age;
    
    // Methods (behaviors)
    void bark() {
        System.out.println(name + " is barking!");
    }
    
    void sleep() {
        System.out.println(name + " is sleeping.");
    }
}

// Creating objects
Dog myDog = new Dog();
myDog.name = "Buddy";
myDog.breed = "Golden Retriever";
myDog.age = 3;
myDog.bark();
```

### 2. Encapsulation

Encapsulation means bundling data and methods together and controlling access to them through access modifiers.

```java
class BankAccount {
    // Private fields - cannot be accessed directly
    private double balance;
    
    // Public methods to access private fields
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
        }
    }
    
    public double getBalance() {
        return balance;
    }
}
```

**Benefits:**
- Data hiding and security
- Better control over data validation
- Easier to maintain and modify

### 3. Inheritance

Inheritance allows a class to inherit properties and methods from another class.

```java
// Parent class
class Animal {
    String name;
    
    void eat() {
        System.out.println(name + " is eating.");
    }
    
    void sleep() {
        System.out.println(name + " is sleeping.");
    }
}

// Child class
class Cat extends Animal {
    void meow() {
        System.out.println(name + " says meow!");
    }
}

// Using inheritance
Cat myCat = new Cat();
myCat.name = "Whiskers";
myCat.eat();  // Inherited from Animal
myCat.meow(); // Defined in Cat
```

### 4. Polymorphism

Polymorphism allows objects of different classes to be treated as objects of a common parent class.

```java
class Shape {
    void draw() {
        System.out.println("Drawing a shape.");
    }
}

class Circle extends Shape {
    @Override
    void draw() {
        System.out.println("Drawing a circle.");
    }
}

class Rectangle extends Shape {
    @Override
    void draw() {
        System.out.println("Drawing a rectangle.");
    }
}

// Polymorphic behavior
Shape[] shapes = new Shape[3];
shapes[0] = new Circle();
shapes[1] = new Rectangle();
shapes[2] = new Shape();

for (Shape shape : shapes) {
    shape.draw(); // Calls the appropriate draw() method
}
```

### 5. Abstraction

Abstraction means hiding complex implementation details and showing only essential features.

#### Abstract Classes

```java
abstract class Vehicle {
    abstract void start();
    abstract void stop();
    
    void display() {
        System.out.println("This is a vehicle.");
    }
}

class Car extends Vehicle {
    @Override
    void start() {
        System.out.println("Car is starting...");
    }
    
    @Override
    void stop() {
        System.out.println("Car is stopping...");
    }
}
```

#### Interfaces

```java
interface Flyable {
    void fly();
    void land();
}

class Bird implements Flyable {
    @Override
    public void fly() {
        System.out.println("Bird is flying.");
    }
    
    @Override
    public void land() {
        System.out.println("Bird is landing.");
    }
}

class Airplane implements Flyable {
    @Override
    public void fly() {
        System.out.println("Airplane is flying.");
    }
    
    @Override
    public void land() {
        System.out.println("Airplane is landing.");
    }
}
```

## Constructor

Constructors are special methods used to initialize objects.

```java
class Student {
    String name;
    int age;
    String grade;
    
    // Default constructor
    Student() {
        name = "Unknown";
        age = 0;
        grade = "N/A";
    }
    
    // Parameterized constructor
    Student(String name, int age, String grade) {
        this.name = name;
        this.age = age;
        this.grade = grade;
    }
    
    // Copy constructor
    Student(Student other) {
        this.name = other.name;
        this.age = other.age;
        this.grade = other.grade;
    }
}
```

## Access Modifiers

| Modifier | Class | Package | Subclass | World |
|----------|-------|---------|----------|-------|
| `public` | Yes | Yes | Yes | Yes |
| `protected` | Yes | Yes | Yes | No |
| `default` | Yes | Yes | No | No |
| `private` | Yes | No | No | No |

## Example: Complete OOP Implementation

```java
class Employee {
    // Encapsulation
    private String name;
    private int id;
    private double salary;
    
    // Constructor
    public Employee(String name, int id, double salary) {
        this.name = name;
        this.id = id;
        this.salary = salary;
    }
    
    // Getters and Setters
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public double getSalary() {
        return salary;
    }
    
    public void raiseSalary(double percentage) {
        salary += salary * (percentage / 100);
    }
    
    public void displayInfo() {
        System.out.println("Employee: " + name);
        System.out.println("ID: " + id);
        System.out.println("Salary: $" + salary);
    }
}

// Inheritance
class Manager extends Employee {
    private String department;
    
    public Manager(String name, int id, double salary, String department) {
        super(name, id, salary);
        this.department = department;
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Department: " + department);
        System.out.println("Position: Manager");
    }
}
```

## Benefits of OOP

1. **Modularity**: Code organized into logical modules
2. **Reusability**: Write once, use multiple times
3. **Maintainability**: Easier to update and modify code
4. **Scalability**: Better for large applications
5. **Testability**: Each component can be tested independently

## Summary

OOP is the foundation of Java programming. By understanding classes, objects, encapsulation, inheritance, polymorphism, and abstraction, you can write clean, maintainable, and scalable code.

