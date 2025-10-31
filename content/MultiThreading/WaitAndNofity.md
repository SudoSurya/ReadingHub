# Wait and Notify in JAVA

Let’s dive into **`wait()`** and **`notify()`** in Java, two methods that are essential for inter-thread communication when synchronizing threads. They’re part of the `Object` class, meaning every object in Java can use them as a coordination mechanism. These methods shine in scenarios like producer-consumer problems, where one thread needs to wait for another to signal readiness. I’ll explain how they work, with examples, and keep it engaging.

### Basics of `wait()` and `notify()`
- **`wait()`**: Causes the current thread to pause and release the lock it holds on an object, waiting until another thread calls `notify()` or `notifyAll()` on the same object.
- **`notify()`**: Wakes up one thread that’s waiting on the object’s monitor (lock). If multiple threads are waiting, it picks one arbitrarily.
- **`notifyAll()`**: Wakes up *all* threads waiting on the object’s monitor, letting them compete for the lock.

These methods must be called within a **`synchronized`** block or method because they rely on the object’s lock. Calling them outside synchronization throws an `IllegalMonitorStateException`.

### How They Work
1. **Thread A** acquires an object’s lock and calls `wait()`:
   - It releases the lock and goes into a waiting state.
   - It’s added to the object’s wait set.
2. **Thread B** acquires the same lock and calls `notify()`:
   - One waiting thread (or all with `notifyAll()`) is woken up.
   - The woken thread(s) wait to reacquire the lock after B releases it.
3. **Thread A** resumes once it gets the lock back.

### Syntax and Rules
- **Must be in `synchronized`**:
```java
synchronized(obj) {
    obj.wait(); // Releases lock on obj and waits
}
```
- **Variants of `wait()`**:
  - `wait()`: Waits indefinitely.
  - `wait(long timeout)`: Waits up to a specified time (in milliseconds).
  - `wait(long timeout, int nanos)`: Adds nanosecond precision.

### Example: Producer-Consumer
Let’s build a simple queue where a producer adds items and a consumer removes them, using `wait()` and `notify()` to coordinate:

```java
class SharedQueue {
    private int item;
    private boolean hasItem = false; // Flag to track availability

    synchronized void produce(int value) {
        while (hasItem) { // Wait if queue is full
            try {
                wait();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        item = value;
        hasItem = true;
        System.out.println("Produced: " + item);
        notify(); // Wake up consumer
    }

    synchronized int consume() {
        while (!hasItem) { // Wait if queue is empty
            try {
                wait();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return -1;
            }
        }
        hasItem = false;
        System.out.println("Consumed: " + item);
        notify(); // Wake up producer
        return item;
    }
}

public class WaitNotifyTest {
    public static void main(String[] args) {
        SharedQueue queue = new SharedQueue();

        Thread producer = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                queue.produce(i);
            }
        });

        Thread consumer = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                queue.consume();
            }
        });

        producer.start();
        consumer.start();
    }
}
```

#### Output (example):
```
Produced: 1
Consumed: 1
Produced: 2
Consumed: 2
Produced: 3
Consumed: 3
...
```

### How It Works Here
- **Producer**: If `hasItem` is `true` (queue isn’t empty), it calls `wait()` and releases the lock. Once `notify()` is called by the consumer, it resumes, adds the item, and signals back.
- **Consumer**: If `hasItem` is `false` (queue is empty), it waits. When the producer adds an item and calls `notify()`, the consumer wakes up.
- **Why `while` loops?**: This guards against **spurious wakeups** (rare cases where `wait()` returns without `notify()`). Always recheck the condition!

### Key Points
1. **Lock Release**: `wait()` releases the lock, unlike `sleep()` or `yield()`, which hold it. This lets other threads proceed.
2. **Signaling**: `notify()` doesn’t release the lock—it just marks a waiter to wake up when the lock becomes available.
3. **Interrupts**: If a waiting thread is interrupted, it throws `InterruptedException` and needs handling.
4. **notify() vs notifyAll()**:
   - Use `notify()` for one-to-one signaling (e.g., one producer, one consumer).
   - Use `notifyAll()` when multiple threads might be waiting, and you need all to check conditions (e.g., multiple consumers).

### Common Pitfalls
- **Missing Synchronization**: Calling `wait()` or `notify()` outside `synchronized` crashes the program.
- **Deadlock**: If all threads wait and none notify, you’re stuck. Ensure a notify path exists.
- **Lost Signals**: If `notify()` is called before `wait()`, the signal is lost. Use state variables (like `hasItem`) to track conditions.

### Comparison to Modern Tools
While `wait()` and `notify()` are classic, the `java.util.concurrent` package offers higher-level alternatives:
- **`Condition` with `Lock`**: Replaces `wait()/notify()` with `await()/signal()`.
- **`BlockingQueue`**: Built-in producer-consumer support (e.g., `ArrayBlockingQueue`).

Example with `Condition`:
```java
import java.util.concurrent.locks.*;
class QueueWithLock {
    ReentrantLock lock = new ReentrantLock();
    Condition condition = lock.newCondition();
    int item;
    boolean hasItem = false;

    void produce(int value) {
        lock.lock();
        try {
            while (hasItem) condition.await();
            item = value;
            hasItem = true;
            condition.signal();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            lock.unlock();
        }
    }
}
```

### Fun Fact
`wait()` and `notify()` date back to Java 1.0, inspired by monitor constructs from the 1970s. They’re low-level but still underpin many concurrency utilities.

