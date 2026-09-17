# React SVG import contracts and accessibility

Knowledge ID: `react.svg-import-contracts-and-accessibility`

Topic: `react`

Vite normally imports SVG as a URL for `<img src={iconUrl}>`; SVGR with `?react` imports a component. Keep module declarations separate because runtime values differ, and align plugin, suffix, `.d.ts`, barrel export, and prop type.

```tsx
import EyeIcon from "./eye.svg?react";

declare module "*.svg?react" {
  const Component: React.FunctionComponent<
    React.SVGProps<SVGSVGElement> & { title?: string }
  >;
  export default Component;
}

export { default as EyeIcon } from "./eye.svg?react";

type SvgComponent = React.FunctionComponent<
  React.SVGProps<SVGSVGElement> & { title?: string }
>;

function AccountNav({ Icon }: { Icon: SvgComponent }) {
  return <Icon aria-hidden="true" />;
}
```

Dynamic JSX component identifiers must be uppercase (`Icon`); lowercase is treated as an intrinsic tag. Ambient declarations must be included by TypeScript and should avoid problematic application imports.

Use `1em` sizing to follow text and `fill="currentColor"` for theme color. Mark decorative icons `aria-hidden`/non-focusable. Give standalone meaningful graphics a role/title; for icon buttons, put the accessible name on the button and hide the inner icon:

```tsx
<button type="button" aria-label="Show password">
  <EyeIcon aria-hidden="true" focusable="false" />
</button>
```

## Sources
- Workspace: `_ai-conspects/svg react/`
- Processed source: `regions/final-transcript.md`, complete transcript and configuration examples
