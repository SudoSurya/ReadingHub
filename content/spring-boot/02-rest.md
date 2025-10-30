# Building RESTful APIs with Spring Boot

REST (Representational State Transfer) is an architectural style for designing networked applications. Spring Boot provides excellent support for building RESTful APIs.

## What is REST?

REST is a set of guidelines for creating web services that use HTTP protocol. Key principles:

- **Stateless**: Each request contains all necessary information
- **Resource-Based**: Everything is a resource identified by URI
- **HTTP Methods**: Use standard HTTP verbs (GET, POST, PUT, DELETE)
- **JSON/XML**: Standard data formats

## REST Conventions

### HTTP Methods

| Method | Purpose | Idempotent | Safe |
|--------|---------|------------|------|
| GET | Retrieve resource | Yes | Yes |
| POST | Create resource | No | No |
| PUT | Update resource (complete) | Yes | No |
| PATCH | Update resource (partial) | No | No |
| DELETE | Delete resource | Yes | No |

### HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | OK - Success |
| 201 | Created - Resource created |
| 204 | No Content - Success with no body |
| 400 | Bad Request - Invalid input |
| 404 | Not Found - Resource doesn't exist |
| 500 | Internal Server Error - Server error |

## Creating REST Controllers

### Basic Controller

```java
package com.example.myapp.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {
    
    private Map<Long, User> users = new HashMap<>();
    private Long nextId = 1L;
    
    // GET /api/users
    @GetMapping
    public List<User> getAllUsers() {
        return new ArrayList<>(users.values());
    }
    
    // GET /api/users/{id}
    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        User user = users.get(id);
        if (user == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(user);
    }
    
    // POST /api/users
    @PostMapping
    public ResponseEntity<User> createUser(@RequestBody User user) {
        user.setId(nextId++);
        users.put(user.getId(), user);
        return ResponseEntity.status(201).body(user);
    }
    
    // PUT /api/users/{id}
    @PutMapping("/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, 
                                           @RequestBody User user) {
        if (!users.containsKey(id)) {
            return ResponseEntity.notFound().build();
        }
        user.setId(id);
        users.put(id, user);
        return ResponseEntity.ok(user);
    }
    
    // DELETE /api/users/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        if (users.remove(id) == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.noContent().build();
    }
}
```

### User Entity

```java
package com.example.myapp.model;

public class User {
    private Long id;
    private String name;
    private String email;
    private int age;
    
    // Constructors
    public User() {}
    
    public User(String name, String email, int age) {
        this.name = name;
        this.email = email;
        this.age = age;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
}
```

## Path Variables and Request Parameters

### Path Variables

```java
@GetMapping("/users/{id}")
public User getUser(@PathVariable Long id) {
    return userService.findById(id);
}

// Multiple path variables
@GetMapping("/users/{userId}/posts/{postId}")
public Post getPost(@PathVariable Long userId, 
                    @PathVariable Long postId) {
    return postService.findById(userId, postId);
}

// Custom path variable name
@GetMapping("/posts/{id}")
public Post getPostById(@PathVariable("id") Long postId) {
    return postService.findById(postId);
}
```

### Request Parameters

```java
// Optional query parameter
@GetMapping("/users")
public List<User> searchUsers(@RequestParam(required = false) String name) {
    if (name != null) {
        return userService.findByName(name);
    }
    return userService.findAll();
}

// Required query parameter
@GetMapping("/users")
public User findUser(@RequestParam Long id) {
    return userService.findById(id);
}

// Multiple parameters
@GetMapping("/users")
public List<User> searchUsers(
    @RequestParam String name,
    @RequestParam(required = false, defaultValue = "0") int minAge
) {
    return userService.search(name, minAge);
}
```

### Request Body

```java
@PostMapping("/users")
public ResponseEntity<User> createUser(@RequestBody User user) {
    User created = userService.save(user);
    return ResponseEntity.status(HttpStatus.CREATED).body(created);
}
```

## Exception Handling

### Global Exception Handler

```java
package com.example.myapp.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(
            ResourceNotFoundException ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.NOT_FOUND.value(),
            ex.getMessage(),
            System.currentTimeMillis()
        );
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }
    
    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<ErrorResponse> handleBadRequest(
            BadRequestException ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            ex.getMessage(),
            System.currentTimeMillis()
        );
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGeneric(Exception ex) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.INTERNAL_SERVER_ERROR.value(),
            "An unexpected error occurred",
            System.currentTimeMillis()
        );
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(error);
    }
}
```

### Custom Exceptions

```java
public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String message) {
        super(message);
    }
}

public class BadRequestException extends RuntimeException {
    public BadRequestException(String message) {
        super(message);
    }
}
```

### Error Response Model

```java
public class ErrorResponse {
    private int status;
    private String message;
    private long timestamp;
    
    public ErrorResponse(int status, String message, long timestamp) {
        this.status = status;
        this.message = message;
        this.timestamp = timestamp;
    }
    
    // Getters
    public int getStatus() { return status; }
    public String getMessage() { return message; }
    public long getTimestamp() { return timestamp; }
}
```

## Advanced Features

### Pagination and Sorting

```java
@GetMapping("/users")
public ResponseEntity<List<User>> getUsers(
    @RequestParam(defaultValue = "0") int page,
    @RequestParam(defaultValue = "10") int size,
    @RequestParam(defaultValue = "id") String sortBy
) {
    // Implementation with pagination
    List<User> users = userService.findAll(page, size, sortBy);
    return ResponseEntity.ok(users);
}
```

### Response Entity with Headers

```java
@PostMapping("/users")
public ResponseEntity<User> createUser(@RequestBody User user) {
    User created = userService.save(user);
    
    URI location = ServletUriComponentsBuilder
        .fromCurrentRequest()
        .path("/{id}")
        .buildAndExpand(created.getId())
        .toUri();
    
    return ResponseEntity
        .created(location)
        .header("X-Custom-Header", "Value")
        .body(created);
}
```

### Content Negotiation

```java
@GetMapping(value = "/users/{id}", 
            produces = {MediaType.APPLICATION_JSON_VALUE, 
                       MediaType.APPLICATION_XML_VALUE})
public User getUser(@PathVariable Long id) {
    return userService.findById(id);
}
```

### CORS Configuration

```java
@Configuration
public class WebConfig {
    
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**")
                    .allowedOrigins("http://localhost:3000")
                    .allowedMethods("GET", "POST", "PUT", "DELETE")
                    .allowedHeaders("*");
            }
        };
    }
}
```

## Testing REST APIs

### Testing with MockMvc

```java
@WebMvcTest(UserController.class)
class UserControllerTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void shouldReturnAllUsers() throws Exception {
        mockMvc.perform(get("/api/users"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$", hasSize(greaterThan(0))));
    }
    
    @Test
    void shouldCreateUser() throws Exception {
        User user = new User("John Doe", "john@example.com", 25);
        
        mockMvc.perform(post("/api/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(new ObjectMapper().writeValueAsString(user)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("John Doe"));
    }
}
```

### Testing with RestTemplate

```java
@Test
void testGetUserById() {
    RestTemplate restTemplate = new RestTemplate();
    String url = "http://localhost:8080/api/users/1";
    
    ResponseEntity<User> response = restTemplate.getForEntity(url, User.class);
    
    assertEquals(HttpStatus.OK, response.getStatusCode());
    assertNotNull(response.getBody());
}
```

## Best Practices

1. **Use proper HTTP status codes**
2. **Follow RESTful naming conventions**
3. **Return consistent response formats**
4. **Implement proper error handling**
5. **Use ResponseEntity for fine-grained control**
6. **Document your API (Swagger/OpenAPI)**
7. **Validate input data**
8. **Implement pagination for large datasets**
9. **Use HTTP caching headers**
10. **Secure your API endpoints**

## Summary

Spring Boot provides powerful and intuitive tools for building RESTful APIs:

- `@RestController` for REST controllers
- `@RequestMapping` for URL mapping
- HTTP method annotations (GET, POST, PUT, DELETE)
- Exception handling with `@RestControllerAdvice`
- Built-in support for JSON serialization
- Testing with MockMvc and RestTemplate

With these tools, you can create production-ready REST APIs with minimal boilerplate code.

