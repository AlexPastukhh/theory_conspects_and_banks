# JavaScript async semaphore permits and waiter lifecycle

Knowledge ID: `javascript.async-semaphore-permits-and-waiter-lifecycle`

Topic: `javascript`

A semaphore bounds how many asynchronous operations may enter a critical region. A capacity of one behaves like a mutex; a larger capacity protects a scarce connection/API/browser resource. It limits concurrency, not requests per time window, so it is not a rate limiter.

`acquire()` either consumes a free permit immediately or returns a pending promise queued for a future release. `release()` should hand the permit directly to the oldest waiter; incrementing a counter first lets a newer caller steal it and harms FIFO fairness.

```js
class Semaphore {
  #permits;
  #waiters = [];

  constructor(permits) {
    if (!Number.isInteger(permits) || permits <= 0) throw new RangeError("permits");
    this.#permits = permits;
  }

  acquire() {
    if (this.#permits > 0) {
      this.#permits--;
      return Promise.resolve(this.#makeRelease());
    }
    return new Promise(resolve => this.#waiters.push(resolve))
      .then(() => this.#makeRelease());
  }

  #makeRelease() {
    let released = false;
    return () => {
      if (released) return;
      released = true;
      const next = this.#waiters.shift();
      if (next) next();
      else this.#permits++;
    };
  }
}
```

Always release in `finally`:

```js
const release = await semaphore.acquire();
try { await useResource(); }
finally { release(); }
```

Make the release handle idempotent so accidental double release cannot create permits. Return release ownership only from a successful `acquire`; do not expose an unrestricted raw `release()` callable without ownership. Production queues also need cancellation/timeout removal; abandoning a waiting promise without removing its entry leaks memory and may later hand a permit to work that no longer wants it.

## Sources

- Workspace: `_ai-conspects/semaphoreslim for ts js, pending promise without resolve/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01-R02
- Original SVG: `source/semaphoreslim for ts js, pending promise without resolve.svg`
