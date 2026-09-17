# IntersectionObserver lifecycle in React

Knowledge ID: `react.intersection-observer-lifecycle`

Topic: `react`

One observer can watch many targets, so callbacks receive an entries array. Each `IntersectionObserverEntry` exposes `target`, `isIntersecting`, `intersectionRatio`, `boundingClientRect`, `intersectionRect`, `rootBounds`, and `time`. Iterate all entries or match `entry.target`; do not assume callback order or `entries[0]` unless the single-target assumption is explicit.

Create/attach after DOM commit, capture the observed element, and clean up the same identity:

```tsx
useEffect(() => {
  const element = sentinelRef.current;
  if (!element) return;

  const observer = new IntersectionObserver(entries => {
    const entry = entries.find(item => item.target === element);
    if (entry) setVisible(entry.isIntersecting);
  }, { threshold: 0.2 });

  observer.observe(element);
  return () => observer.disconnect();
}, []);
```

`root: null` means viewport; a DOM root observes within a scroll container. Thresholds are target-visible fractions. Positive `rootMargin` expands and negative contracts the CSS-ordered root rectangle, enabling prefetch/early load/delayed activation. `unobserve` stops one target; `disconnect` stops all.

## Sources
- Workspace: `_ai-conspects/interseption observer/`
- Processed source: `regions/final-transcript.md`, complete transcript
