# Spring Boot Setup and Getting Started

Spring Boot is a powerful framework that simplifies the development of Java applications by providing auto-configuration and convention-over-configuration principles.

## What is Spring Boot?

Spring Boot makes it easy to create standalone, production-grade Spring-based applications. It includes:

- **Embedded Tomcat/Jetty**: No need for separate application servers
- **Auto-Configuration**: Automatically configures Spring and third-party libraries
- **Starter Dependencies**: Pre-defined dependency descriptors
- **Production-Ready Features**: Metrics, health checks, and externalized configuration

## Prerequisites

Before starting with Spring Boot, ensure you have:

- **Java**: JDK 8 or higher (JDK 17 recommended)
- **Build Tool**: Maven or Gradle
- **IDE**: IntelliJ IDEA, Eclipse, or VS Code

## Creating a Spring Boot Project

### Using Spring Initializr

1. Visit [start.spring.io](https://start.spring.io)
2. Select your project metadata:
   - **Project**: Maven or Gradle
   - **Language**: Java
   - **Spring Boot**: Latest stable version
   - **Group**: com.example
   - **Artifact**: myapp
3. Add dependencies: Spring Web
4. Click "Generate" and download the zip file

### Using Command Line

```bash
# Using curl
curl https://start.spring.io/starter.zip \
  -d dependencies=web \
  -d javaVersion=17 \
  -d groupId=com.example \
  -d artifactId=myapp \
  -o myapp.zip

unzip myapp.zip
cd myapp
```

### Using IntelliJ IDEA

1. **File** → **New** → **Project**
2. Select **Spring Initializr**
3. Choose Java and Spring Boot version
4. Add dependencies (Spring Web)
5. Click **Finish**

## Project Structure

```
myapp/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/myapp/
│   │   │       └── MyappApplication.java
│   │   └── resources/
│   │       ├── application.properties
│   │       └── static/
│   │       └── templates/
│   └── test/
│       └── java/
│           └── com/example/myapp/
├── pom.xml (Maven)
│
└── README.md
```

## First Application

### Main Application Class

```java
package com.example.myapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyappApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyappApplication.class, args);
    }
}
```

### Creating a REST Controller

```java
package com.example.myapp.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    
    @GetMapping("/hello")
    public String hello() {
        return "Hello, Spring Boot!";
    }
}
```

### Running the Application

#### From IDE

Right-click on `MyappApplication.java` → **Run**

#### From Command Line (Maven)

```bash
# Build the project
./mvnw clean package

# Run the application
./mvnw spring-boot:run
```

#### From Command Line (Gradle)

```bash
# Build the project
./gradlew build

# Run the application
./gradlew bootRun
```

## Configuration

### Application Properties

Edit `src/main/resources/application.properties`:

```properties
# Server configuration
server.port=8080
server.servlet.context-path=/api

# Application name
spring.application.name=My Spring Boot App

# Logging
logging.level.com.example=DEBUG
logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} - %msg%n
```

### Application YAML

Create `src/main/resources/application.yml`:

```yaml
server:
  port: 8080
  servlet:
    context-path: /api

spring:
  application:
    name: My Spring Boot App

logging:
  level:
    com.example: DEBUG
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
```

## Spring Boot Dependencies

### Common Starters

| Starter | Description |
|---------|-------------|
| `spring-boot-starter-web` | Web applications with RESTful APIs |
| `spring-boot-starter-data-jpa` | JPA with Hibernate |
| `spring-boot-starter-data-mongodb` | MongoDB support |
| `spring-boot-starter-security` | Spring Security |
| `spring-boot-starter-test` | Testing dependencies |
| `spring-boot-starter-thymeleaf` | Thymeleaf templating |
| `spring-boot-starter-actuator` | Production monitoring |

### Adding Dependencies (Maven)

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>runtime</scope>
    </dependency>
</dependencies>
```

## Profiles

Spring Boot supports profiles for different environments:

```properties
# application-dev.properties
spring.datasource.url=jdbc:h2:mem:devdb
logging.level.root=DEBUG

# application-prod.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/proddb
logging.level.root=INFO
```

Running with a profile:

```bash
java -jar app.jar --spring.profiles.active=prod
```

## Testing

### Unit Test Example

```java
package com.example.myapp.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(HelloController.class)
class HelloControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void helloShouldReturnMessage() throws Exception {
        mockMvc.perform(get("/hello"))
                .andExpect(status().isOk())
                .andExpect(content().string("Hello, Spring Boot!"));
    }
}
```

## Packaging for Production

### Building JAR

```bash
# Maven
./mvnw clean package

# Gradle
./gradlew clean build
```

The JAR file will be in `target/` (Maven) or `build/libs/` (Gradle).

### Running JAR

```bash
java -jar target/myapp-0.0.1-SNAPSHOT.jar
```

## Actuator Endpoints

Add Actuator for monitoring:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

Expose endpoints:

```properties
management.endpoints.web.exposure.include=*
```

Common endpoints:

- `/actuator/health` - Health check
- `/actuator/info` - Application information
- `/actuator/metrics` - Metrics data

## Common Annotations

| Annotation | Purpose |
|------------|---------|
| `@SpringBootApplication` | Main application class |
| `@RestController` | REST controller |
| `@Controller` | Web controller |
| `@Service` | Service layer |
| `@Repository` | Data access layer |
| `@Component` | Generic component |
| `@Autowired` | Dependency injection |
| `@Value` | Inject configuration values |
| `@Configuration` | Configuration class |

## Summary

Spring Boot simplifies Java application development by providing:

- Quick project setup
- Auto-configuration
- Embedded server
- Production-ready features
- Extensive ecosystem

This foundation sets you up for building robust enterprise applications with minimal configuration.

