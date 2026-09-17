# Monitor condition waiting and signaling

Knowledge ID: `dotnet.monitor-condition-waiting-and-signaling`

Topic: `dotnet`

`Monitor.Wait`, `Pulse`, and `PulseAll` coordinate threads around a condition protected by a monitor. They are not a queue, semaphore, communication channel, or general event broadcast.

All three calls require the current thread to own the monitor. `Wait` then:

```text
releases the monitor temporarily
-> suspends the caller
-> becomes eligible after a signal
-> reacquires the same monitor
-> returns only after reacquisition
```

`Pulse` makes one current waiter eligible; `PulseAll` makes all current waiters eligible. Neither call releases the monitor immediately, so awakened threads still wait until the signaling thread leaves the critical section.

## Guard waits with `while`

A signal means the condition may have changed, not that it is guaranteed true for a particular awakened thread. Recheck under the lock:

```csharp
private readonly object _gate = new();
private readonly Queue<int> _queue = new();

public void Enqueue(int value)
{
    lock (_gate)
    {
        _queue.Enqueue(value);
        Monitor.Pulse(_gate);
    }
}

public int Dequeue()
{
    lock (_gate)
    {
        while (_queue.Count == 0)
            Monitor.Wait(_gate);

        return _queue.Dequeue();
    }
}
```

The lifecycle is:

```text
consumer owns gate, finds queue empty
-> Wait releases gate and suspends consumer
-> producer acquires gate, enqueues, and pulses
-> producer eventually releases gate
-> consumer reacquires gate
-> consumer rechecks queue condition
-> consumer dequeues
```

Using `if` instead of `while` is incorrect because another awakened thread may consume the available item first, or the relevant condition may no longer hold by the time this waiter reacquires the monitor.

## Choose `Pulse` versus `PulseAll` deliberately

Use `Pulse` when one state change permits one waiter to progress: one item arrived, one slot became free, or only one consumer can use the new state.

If consumers A, B, and C are waiting and one item arrives, `PulseAll` wakes all three. They reacquire the monitor one at a time; one consumes the item, while the others find the condition false and wait again. That creates avoidable scheduling and lock contention.

Use `PulseAll` when multiple waiters may now proceed or every waiter must re-evaluate a global state change, such as shutdown:

```csharp
lock (_gate)
{
    _stopping = true;
    Monitor.PulseAll(_gate);
}
```

Even after `PulseAll`, waiters never run inside the same monitor simultaneously. Each reacquires it in turn and rechecks its own condition.

## Sources
- Workspace: `_ai-conspects/lock-monitor/`
- Authoritative processed source: `04-source-preserving-transcript-v002.md`, S-016 through S-024
- Corrected semantic boundaries: `00-stage0-source-verification-and-corrected-boundaries-v002.md`, R03

