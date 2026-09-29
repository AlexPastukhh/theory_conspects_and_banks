# Parameter properties, inheritance, and definite assignment

Knowledge ID: `typescript.constructor-inheritance-and-definite-assignment`

Topic: `typescript`

## Core model

An access modifier on a constructor parameter declares and initializes a property. `public`, `private`, `protected`, and `readonly` control access and reassignment.

In a derived constructor, `super(...)` initializes the base portion before `this` can be used; parameter properties do not remove that requirement.

The definite-assignment assertion `property!: Type` suppresses strict initialization checking but assigns no runtime value. Reading before the promised lifecycle initialization still yields `undefined`. Prefer constructor initialization; use `!` only when a framework, ORM, or guaranteed setup phase owns initialization.

## What should be recallable

- Parameter-property expansion; visibility modifiers; why `super` precedes `this`; compile-time-only meaning and risk of `!`.

## Sources

- Workspace: `_ai-conspects/typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion/`
- Processed source: `01-final-transcript.md`, R04
- Original SVG: `source/typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion.svg`
