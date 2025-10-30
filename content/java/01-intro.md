# Introduction to Java

Java is a powerful, object-oriented programming language developed by Sun Microsystems (now owned by Oracle). It was designed to be portable, meaning Java code can run on any device that has a Java Virtual Machine (JVM).

## Why Java?

Java offers several key advantages:

- **Platform Independence**: Write once, run anywhere (WORA)
- **Strong Object-Oriented Programming**: Promotes code reusability
- **Automatic Memory Management**: Garbage collection handles memory
- **Rich Ecosystem**: Vast libraries and frameworks
- **Security**: Built-in security features and sandbox execution

## Key Features

### 1. Simple and Familiar

Java's syntax is similar to C/C++, making it easier for developers to learn.

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### 2. Object-Oriented

Everything in Java is an object, which promotes code organization and reusability.

### 3. Platform Independent

Java code compiles to bytecode that runs on the JVM, regardless of the underlying operating system.

### 4. Robust and Secure

- Automatic memory management prevents memory leaks
- Exception handling for error management
- Security manager for safe execution

## Java Development Kit (JDK)

The JDK includes:

- **javac**: Java compiler
- **java**: Java runtime
- **jar**: Packaging tool
- **javadoc**: Documentation generator

## Installation

### Windows

1. Download JDK from Oracle's website
2. Run the installer
3. Set JAVA_HOME environment variable
4. Verify installation: `java -version`

### Linux

```bash
sudo apt update
sudo apt install openjdk-17-jdk
java -version
```

## First Program

Let's write a simple program to add two numbers:

```java
public class Calculator {
    public static void main(String[] args) {
        int a = 10;
        int b = 20;
        int sum = a + b;
        
        System.out.println("Sum: " + sum);
    }
}
```

## Compilation and Execution

```bash
# Compile the Java file
javac Calculator.java

# Run the compiled class
java Calculator
```

## Common Data Types

| Type | Size | Range |
|------|------|-------|
| `byte` | 1 byte | -128 to 127 |
| `short` | 2 bytes | -32,768 to 32,767 |
| `int` | 4 bytes | -2^31 to 2^31-1 |
| `long` | 8 bytes | -2^63 to 2^63-1 |
| `float` | 4 bytes | IEEE 754 floating point |
| `double` | 8 bytes | IEEE 754 floating point |
| `char` | 2 bytes | Unicode characters |
| `boolean` | 1 bit | true or false |

## Summary

Java is a versatile, powerful language suitable for building enterprise applications, Android apps, web servers, and more. Its write-once-run-anywhere philosophy makes it an excellent choice for cross-platform development.

