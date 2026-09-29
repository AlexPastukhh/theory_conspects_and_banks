# EF Core migrations in development and deployment

Knowledge ID: `ef-core.migrations-development-and-deployment-workflows`

Topic: `ef-core`

## Applying migrations deliberately

`Database.MigrateAsync` creates the database when necessary and applies pending migrations. Running it automatically at startup is convenient in local development and simple tools, but production introduces concurrent instances, startup blocking, unavailable databases, and unreviewed destructive changes. Reviewed scripts, migration bundles, or a dedicated deployment step normally provide a safer production boundary.

## CLI workflow

```text
dotnet ef migrations add <Name>
  -> capture model changes in a new migration

dotnet ef database update [TargetMigration]
  -> apply pending migrations or move to a named migration

dotnet ef migrations list
  -> list migrations in the project

dotnet ef migrations remove
  -> remove only the latest unapplied migration
```

If the latest migration has already been applied, move the database back to the prior migration before removing it. Adding a migration and applying a migration are distinct operations.

## Scripts and bundles

`dotnet ef migrations script` generates SQL either from an empty baseline or between two migrations; it does not create a migration. An idempotent script consults `__EFMigrationsHistory` and applies only missing migrations, which lets environments at different versions use the same reviewed artifact.

A migration bundle is an executable migration runner. The deployment flow is:

```text
create migrations in source project
-> build migration bundle
-> publish bundle as deployment artifact
-> run it with the production connection string
-> read migration history and apply pending migrations
```

The server does not need the full SDK or source tree to run that bundle.

## What should be recallable

- Why is automatic startup migration risky with multiple production instances?
- What do `migrations add`, `database update`, `migrations list`, and `migrations remove` each change?
- Why must an applied migration be rolled back before removal?
- How do ordinary, ranged, and idempotent SQL scripts differ from creating a migration?
- What artifact and runtime dependencies define the migration-bundle flow?

## Sources

- Workspace: `_ai-conspects/ef migrations, dotnet-counters/`
- Authoritative processed source: `regions/full-svg-reconciliation-v002.md`, R01–R04
- Original SVG: `source/source-complete-v002.svg`
