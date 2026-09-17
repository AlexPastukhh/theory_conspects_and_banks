# Static members, getters, and setters

Knowledge ID: `typescript.class-members-and-accessors`

Topic: `typescript`

## Core model

Static members belong to the class constructor and are shared; instance fields belong to each object. Use statics for class-level counters, factories, configuration, or associated constants, not hidden global state.

Getters expose property syntax while executing a method. Setters accept one value and cannot return a value.

```ts
class Bands {
  private dataState: string[] = [];
  get data(): readonly string[] { return [...this.dataState]; }
  set data(value: string[]) { this.dataState = value; }
}
```

Compile-time types protect typed callers; validate again at untyped JSON/network/JavaScript boundaries. Returning a copy or readonly view prevents callers from directly mutating the backing array.

## What should be recallable

- Static versus instance ownership; valid static use cases; setter return rule; compile-time versus runtime validation; mutable backing-array exposure.

## Sources

- Workspace: `_ai-conspects/typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion/`
- Processed source: `01-final-transcript.md`, R01–R02
- Original SVG: `source/typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion.svg`
