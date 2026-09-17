# TypeScript generic default type arguments

Knowledge ID: `typescript.generic-default-type-arguments`

Topic: `typescript`

A generic type parameter can declare a default. TypeScript uses it when the caller omits the corresponding type argument:

```typescript
type ApiResponse<Data = { status: number }> = {
  data: Data;
  isError: boolean;
};
```

With no explicit argument, `Data` is `{ status: number }`:

```typescript
type Response1 = ApiResponse;
// { data: { status: number }; isError: boolean }
```

An explicit argument replaces the default:

```typescript
type Response2 = ApiResponse<string[]>;
// { data: string[]; isError: boolean }

type Response3 = ApiResponse<{ user: string; age: number }>;
// { data: { user: string; age: number }; isError: boolean }
```

Use a generic default when one shape is common enough to be convenient but the abstraction must remain customizable.

```text
ApiResponse           -> default Data
ApiResponse<string[]> -> explicit Data
ApiResponse<MyDto>    -> explicit Data
```

## What should be recallable

- When a generic parameter's default is selected.
- How an explicit type argument replaces that default.
- Why a common-but-customizable shape is a good use case.

## Sources

- Workspace: `_ai-conspects/typescript generics default type arguments/`
- Authoritative reconstructed source: `regions/R01-generic-default-type-arguments-final-transcript-v001.md`, complete transcript
- Original SVG: `source/typescript generics default type arguments.svg`
