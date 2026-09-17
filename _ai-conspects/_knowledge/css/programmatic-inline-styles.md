# Programmatic inline CSS styles

Knowledge ID: `css.programmatic-inline-styles`

Topic: `css`

DOM style properties use camelCase. `setProperty` uses CSS spelling and supports custom properties; `removeProperty` removes a declaration. The optional `important` priority should follow an explicit cascade contract.

```js
element.style.backgroundColor = "black";
element.style.setProperty("--accent-color", "#09f");
element.style.setProperty("color", "red", "important");
element.style.removeProperty("background-color");

const resolvedColor = getComputedStyle(element).color;
```

`element.style` reads inline declarations only; `getComputedStyle` returns resolved values after stylesheets, inheritance, and browser resolution. React style objects add `px` to many numeric lengths. Use inline styles/CSS variables for truly dynamic values and classes for reusable states, themes, pseudo-classes, and media queries. Imperative effects should clean up their styles.

```tsx
<div style={{ color: active ? "red" : "black", marginTop: 8 }} />
<div className={active ? "box box--active" : "box"} />

useEffect(() => {
  const element = ref.current;
  if (!element) return;

  element.style.setProperty("--progress", String(progress));
  return () => element.style.removeProperty("--progress");
}, [progress]);
```

## Sources

- Workspace: `_ai-conspects/prog inline styles css/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript and examples
