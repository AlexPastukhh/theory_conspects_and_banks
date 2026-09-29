# Interfaces and implements

Knowledge ID: `typescript.interfaces-and-class-contracts`

Topic: `typescript`

## Core model

An interface describes a structural compile-time contract. `implements` checks a class instance shape but does not copy implementation or create runtime interface metadata; interfaces are erased from emitted JavaScript.

```ts
interface Musician { name: string; play(action: string): string; }
class Guitarist implements Musician {
  constructor(public name: string) {}
  play(action: string) { return `${this.name} ${action}`; }
}
```

A class may implement multiple interfaces but extends only one base class. Interfaces suit public object contracts, dependency boundaries, parameters, and mockable abstractions.

## What should be recallable

- What `implements` checks; what it does not generate; runtime erasure; multiple interfaces versus one base class.

## Sources

- Workspace: `_ai-conspects/typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion/`
- Processed source: `01-final-transcript.md`, R03
- Original SVG: `source/typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion.svg`
