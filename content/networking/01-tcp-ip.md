# TCP/IP Fundamentals

The TCP/IP (Transmission Control Protocol/Internet Protocol) suite is the foundation of modern network communication. It enables computers to communicate over networks, including the internet.

## What is TCP/IP?

TCP/IP is a set of networking protocols that allows computers to exchange information. It provides:

- **Routing**: How data finds its way across networks
- **Reliable delivery**: Ensuring data arrives intact
- **Addressing**: Identifying devices on the network
- **Connection management**: Establishing and maintaining connections

## The TCP/IP Model

The TCP/IP model consists of four layers:

| Layer | Protocols | Function |
|-------|-----------|----------|
| **Application** | HTTP, FTP, SMTP, DNS | Interface for applications |
| **Transport** | TCP, UDP | End-to-end communication |
| **Internet** | IP, ICMP | Routing and addressing |
| **Network Access** | Ethernet, Wi-Fi | Physical transmission |

## Internet Protocol (IP)

IP is responsible for routing packets across networks. It provides logical addressing for devices.

### IPv4 Addressing

IPv4 uses 32-bit addresses, typically written in dotted-decimal notation:

```
192.168.1.100
```

### IPv6 Addressing

IPv6 uses 128-bit addresses, written in hexadecimal:

```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

### IP Address Classes

| Class | Range | Network Bits | Host Bits | Use Case |
|-------|-------|--------------|-----------|----------|
| A | 1.0.0.0 - 127.255.255.255 | 8 | 24 | Large networks |
| B | 128.0.0.0 - 191.255.255.255 | 16 | 16 | Medium networks |
| C | 192.0.0.0 - 223.255.255.255 | 24 | 8 | Small networks |
| D | 224.0.0.0 - 239.255.255.255 | - | - | Multicast |
| E | 240.0.0.0 - 255.255.255.255 | - | - | Reserved |

### Subnetting

Subnets divide networks into smaller segments:

```
Network: 192.168.1.0/24
Subnet Mask: 255.255.255.0

Subnets:
- 192.168.1.0/26 (hosts: 62)
- 192.168.1.64/26 (hosts: 62)
- 192.168.1.128/26 (hosts: 62)
- 192.168.1.192/26 (hosts: 62)
```

### Private IP Ranges

Private IP addresses (not routable on internet):

- **Class A**: 10.0.0.0 - 10.255.255.255
- **Class B**: 172.16.0.0 - 172.31.255.255
- **Class C**: 192.168.0.0 - 192.168.255.255

### Public IP vs Private IP

```
Public IP:
- Globally routable
- Assigned by ISP
- Visible on internet
- Example: 203.0.113.45

Private IP:
- Not routable globally
- Used internally
- NAT translates to public
- Example: 192.168.1.100
```

## Transmission Control Protocol (TCP)

TCP provides reliable, connection-oriented communication.

### TCP Characteristics

1. **Reliable**: Ensures data delivery
2. **Connection-oriented**: Establishes session before data transfer
3. **Ordered**: Maintains packet sequence
4. **Error detection**: Checksums verify integrity
5. **Flow control**: Prevents overwhelming receiver

### TCP Three-Way Handshake

Connection establishment:

```
Client                          Server
  |                               |
  |--- SYN (Seq=100) ------------>|
  |                               |
  |<-- SYN-ACK (Ack=101, Seq=200)-|
  |                               |
  |--- ACK (Ack=201) ------------>|
  |                               |
Connection Established
```

### TCP Connection Termination

```
Client                          Server
  |                               |
  |--- FIN (Seq=500) ------------>|
  |                               |
  |<-- ACK (Ack=501) -------------|
  |                               |
  |<-- FIN (Seq=700) -------------|
  |                               |
  |--- ACK (Ack=701) ------------>|
  |                               |
Connection Closed
```

### TCP Header

```
  0                   1                   2                   3
  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |          Source Port          |       Destination Port        |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |                        Sequence Number                        |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |                    Acknowledgment Number                      |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |  Data |           |U|A|P|R|S|F|                               |
 | Offset| Reserved  |R|C|S|S|Y|I|            Window             |
 |       |           |G|K|H|T|N|N|                               |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |           Checksum            |         Urgent Pointer        |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| **Connection** | Connection-oriented | Connectionless |
| **Reliability** | Guaranteed delivery | Best effort |
| **Ordering** | Maintains sequence | No ordering |
| **Speed** | Slower | Faster |
| **Header Size** | 20-60 bytes | 8 bytes |
| **Error Checking** | Yes | Checksum only |
| **Use Cases** | Web, Email, FTP | DNS, VoIP, Gaming |

## User Datagram Protocol (UDP)

UDP provides fast, connectionless communication with minimal overhead.

### UDP Characteristics

1. **Fast**: No connection setup
2. **Connectionless**: No session establishment
3. **Low overhead**: Smaller header
4. **No guarantees**: May lose packets
5. **No congestion control**: Can overwhelm network

### UDP Header

```
  0                   1                   2                   3
  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |          Source Port          |       Destination Port        |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |            Length             |           Checksum            |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Ports and Sockets

### Common Ports

| Port | Protocol | Service |
|------|----------|---------|
| 20, 21 | FTP | File Transfer |
| 22 | SSH | Secure Shell |
| 23 | Telnet | Remote Login |
| 25 | SMTP | Email |
| 53 | DNS | Domain Name System |
| 80 | HTTP | Web |
| 110 | POP3 | Email |
| 143 | IMAP | Email |
| 443 | HTTPS | Secure Web |
| 3306 | MySQL | Database |
| 5432 | PostgreSQL | Database |

### Socket

A socket is an endpoint for communication:

```
Socket = IP Address + Port Number

Example: 192.168.1.100:8080
```

## NAT (Network Address Translation)

NAT translates private IP addresses to public IP addresses.

### How NAT Works

```
Internal Network        NAT Router        Internet
192.168.1.100:5000  ----> (translates) ----> 203.0.113.45:1024
192.168.1.101:6000  ----> (translates) ----> 203.0.113.45:1025

Multiple private IPs map to one public IP
```

### NAT Types

1. **Static NAT**: One-to-one mapping
2. **Dynamic NAT**: Pool of public IPs
3. **PAT (NAT Overload)**: Many-to-one with ports

## Common Network Tools

### ping

Test connectivity:

```bash
ping google.com
ping 8.8.8.8
```

### traceroute / tracert

Trace network path:

```bash
traceroute google.com
tracert google.com  # Windows
```

### netstat

Display network connections:

```bash
netstat -an
netstat -rn  # Show routing table
```

### nslookup / dig

DNS lookup:

```bash
nslookup google.com
dig google.com
```

### ipconfig / ifconfig

Display IP configuration:

```bash
ipconfig       # Windows
ifconfig       # Linux/macOS
ip addr show   # Linux (modern)
```

## Summary

TCP/IP fundamentals include:

- **IP**: Logical addressing and routing
- **TCP**: Reliable, connection-oriented transport
- **UDP**: Fast, connectionless transport
- **Ports**: Application endpoints
- **NAT**: Address translation
- **Tools**: Network diagnostics

Understanding TCP/IP is essential for network programming, troubleshooting, and system administration.

