# HTTP Protocol Fundamentals

HTTP (Hypertext Transfer Protocol) is the foundation of data communication on the World Wide Web. It defines how messages are formatted and transmitted between clients and servers.

## What is HTTP?

HTTP is an application-layer protocol that uses TCP/IP to deliver web content. Key characteristics:

- **Stateless**: Each request is independent
- **Request-Response**: Client requests, server responds
- **Text-based**: Human-readable messages
- **Flexible**: Can transfer any data type

## HTTP Versions

### HTTP/1.0

```
GET /index.html HTTP/1.0
Connection: close
```

### HTTP/1.1

- **Persistent connections**: Reuse TCP connections
- **Host header**: Required for virtual hosting
- **Chunked transfer encoding**: Stream large files
- **Pipelining**: Multiple requests without waiting

### HTTP/2

- **Binary protocol**: More efficient than text
- **Multiplexing**: Multiple requests over one connection
- **Server push**: Server can send resources proactively
- **Header compression**: Reduces overhead

### HTTP/3

- **UDP-based**: Uses QUIC protocol
- **Built-in encryption**: TLS by default
- **Improved performance**: Faster connection setup

## HTTP Request Structure

### Request Line

```
Method Path HTTP-Version
```

Example:
```
GET /api/users HTTP/1.1
```

### HTTP Methods

| Method | Idempotent | Safe | Purpose |
|--------|------------|------|---------|
| **GET** | Yes | Yes | Retrieve resource |
| **POST** | No | No | Create resource / submit data |
| **PUT** | Yes | No | Update resource (full) |
| **PATCH** | No | No | Update resource (partial) |
| **DELETE** | Yes | No | Delete resource |
| **HEAD** | Yes | Yes | Get headers only |
| **OPTIONS** | Yes | Yes | Get allowed methods |
| **TRACE** | Yes | Yes | Echo request for testing |

### Complete HTTP Request Example

```http
GET /api/users/123 HTTP/1.1
Host: example.com
User-Agent: Mozilla/5.0
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
Connection: keep-alive
```

### Common Request Headers

| Header | Purpose |
|--------|---------|
| `Host` | Domain name of server |
| `User-Agent` | Client application info |
| `Accept` | Response content types |
| `Accept-Language` | Preferred languages |
| `Accept-Encoding` | Supported compression |
| `Authorization` | Authentication credentials |
| `Content-Type` | Request body type |
| `Content-Length` | Body size in bytes |
| `Cookie` | Stored cookies |
| `Referer` | Previous page URL |

## HTTP Response Structure

### Status Line

```
HTTP-Version Status-Code Reason-Phrase
```

Example:
```
HTTP/1.1 200 OK
```

### HTTP Status Codes

#### 1xx - Informational

| Code | Meaning |
|------|---------|
| 100 | Continue |
| 101 | Switching Protocols |

#### 2xx - Success

| Code | Meaning |
|------|---------|
| 200 | OK |
| 201 | Created |
| 204 | No Content |
| 206 | Partial Content |

#### 3xx - Redirection

| Code | Meaning |
|------|---------|
| 301 | Moved Permanently |
| 302 | Found (Temporary) |
| 304 | Not Modified |
| 307 | Temporary Redirect |
| 308 | Permanent Redirect |

#### 4xx - Client Error

| Code | Meaning |
|------|---------|
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 405 | Method Not Allowed |
| 408 | Request Timeout |
| 409 | Conflict |
| 413 | Payload Too Large |
| 429 | Too Many Requests |

#### 5xx - Server Error

| Code | Meaning |
|------|---------|
| 500 | Internal Server Error |
| 501 | Not Implemented |
| 502 | Bad Gateway |
| 503 | Service Unavailable |
| 504 | Gateway Timeout |
| 507 | Insufficient Storage |

### Complete HTTP Response Example

```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 156
Date: Mon, 23 May 2024 10:15:30 GMT
Server: nginx/1.18.0
Set-Cookie: session_id=abc123; Path=/
Cache-Control: max-age=3600

{
  "id": 123,
  "name": "Alice",
  "email": "alice@example.com"
}
```

### Common Response Headers

| Header | Purpose |
|--------|---------|
| `Content-Type` | Resource media type |
| `Content-Length` | Body size |
| `Content-Encoding` | Compression used |
| `Cache-Control` | Caching directives |
| `ETag` | Resource version |
| `Location` | Redirect target |
| `Set-Cookie` | Send cookie to client |
| `WWW-Authenticate` | Authentication required |
| `Access-Control-Allow-Origin` | CORS policy |
| `Server` | Server software |

## URL Structure

```
https://www.example.com:8080/path/to/resource?key=value&key2=value2#fragment
│      │  │              │   │                   │                         │
│      │  │              │   │                   │                         └─ Fragment
│      │  │              │   │                   └─ Query String
│      │  │              │   └─ Path
│      │  │              └─ Port (optional)
│      │  └─ Domain
│      └─ Subdomain
└─ Protocol
```

## Media Types (MIME Types)

| Type | Application |
|------|-------------|
| `text/html` | HTML documents |
| `text/plain` | Plain text |
| `application/json` | JSON data |
| `application/xml` | XML data |
| `application/pdf` | PDF files |
| `image/jpeg` | JPEG images |
| `image/png` | PNG images |
| `video/mp4` | MP4 videos |
| `multipart/form-data` | Form uploads |

## Cookies

Cookies store state information on the client.

### Cookie Attributes

```
Set-Cookie: session_id=abc123; Domain=.example.com; Path=/; Secure; HttpOnly; SameSite=Strict; Max-Age=3600
```

Attributes:
- `Domain`: Cookie domain scope
- `Path`: Cookie path scope
- `Secure`: Only over HTTPS
- `HttpOnly`: Not accessible to JavaScript
- `SameSite`: CSRF protection (Strict/Lax/None)
- `Max-Age` / `Expires`: Cookie lifetime

### Cookie Example

```http
# Server sends
Set-Cookie: user_id=12345; HttpOnly; Secure

# Client sends
Cookie: user_id=12345; theme=dark
```

## Sessions

Sessions maintain state across multiple requests.

### Session Flow

1. Server creates session → generates session ID
2. Server sends session ID → client via cookie
3. Client sends session ID → server with each request
4. Server retrieves session data → uses session ID

### Session vs Cookies

| Aspect | Session | Cookie |
|--------|---------|--------|
| **Storage** | Server-side | Client-side |
| **Security** | More secure | Less secure |
| **Size** | Large data | Limited (4KB) |
| **Lifecycle** | Server-managed | Client-managed |
| **Performance** | Requires lookup | No lookup |

## Caching

### Cache-Control Directives

```
Cache-Control: max-age=3600, must-revalidate
```

Directives:
- `max-age=<seconds>`: Cache lifetime
- `no-cache`: Revalidate before use
- `no-store`: Don't cache
- `must-revalidate`: Revalidate if expired
- `public`: Cacheable by any cache
- `private`: Only browser cache

### ETag and Last-Modified

```http
# First request
GET /api/data HTTP/1.1
Host: example.com

HTTP/1.1 200 OK
ETag: "abc123"
Last-Modified: Mon, 01 Jan 2024 00:00:00 GMT

# Subsequent request
GET /api/data HTTP/1.1
Host: example.com
If-None-Match: "abc123"

HTTP/1.1 304 Not Modified
```

## CORS (Cross-Origin Resource Sharing)

Allows requests from different origins.

### Simple Request

```
GET https://api.example.com/data
Origin: https://example.com
```

### Preflight Request

```http
# Browser sends
OPTIONS /api/data HTTP/1.1
Origin: https://example.com
Access-Control-Request-Method: POST

# Server responds
HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://example.com
Access-Control-Allow-Methods: POST, GET
Access-Control-Allow-Headers: Content-Type
```

### CORS Headers

- `Access-Control-Allow-Origin`: Allowed origins
- `Access-Control-Allow-Methods`: Allowed methods
- `Access-Control-Allow-Headers`: Allowed headers
- `Access-Control-Allow-Credentials`: Allow credentials

## HTTPS

HTTPS adds TLS/SSL encryption to HTTP.

### Benefits

- **Encryption**: Data protected in transit
- **Authentication**: Verify server identity
- **Integrity**: Detect tampering
- **SEO**: Search engine ranking boost

### TLS Handshake

```
Client                          Server
  |                               |
  |--- Client Hello -------------->|
  |                               |
  |<-- Server Hello, Certificate --|
  |                               |
  |--- Client Key Exchange ------->|
  |                               |
  |<-- Finished -------------------|
  |                               |
  |--- Finished ------------------>|
  |                               |
Encrypted Communication
```

## RESTful Design Principles

1. **Resource-based URLs**: `/api/users/123`
2. **HTTP methods**: GET, POST, PUT, DELETE
3. **Stateless**: No server-side session
4. **Representations**: JSON, XML, etc.
5. **Status codes**: Proper HTTP status

### REST API Examples

```http
# Get all users
GET /api/users
→ 200 OK

# Get specific user
GET /api/users/123
→ 200 OK

# Create user
POST /api/users
Content-Type: application/json
Body: {"name": "Alice", "email": "alice@example.com"}
→ 201 Created

# Update user
PUT /api/users/123
Content-Type: application/json
Body: {"name": "Alice Updated"}
→ 200 OK

# Delete user
DELETE /api/users/123
→ 204 No Content
```

## Summary

HTTP fundamentals include:

- **Methods**: GET, POST, PUT, DELETE, etc.
- **Status codes**: 200, 404, 500, etc.
- **Headers**: Metadata for requests/responses
- **Cookies**: Client-side state storage
- **Caching**: Performance optimization
- **HTTPS**: Secure communication
- **CORS**: Cross-origin requests
- **REST**: API design principles

Understanding HTTP is essential for web development, API design, and debugging network issues.

