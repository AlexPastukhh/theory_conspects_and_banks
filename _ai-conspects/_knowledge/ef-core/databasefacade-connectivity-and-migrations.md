# EF Core DatabaseFacade connectivity and migrations

Knowledge ID: `ef-core.databasefacade-connectivity-and-migrations`

Topic: `ef-core`

`DbContext.Database` is a `DatabaseFacade`, EF Core's API surface for database-level operations such as connectivity checks, migrations, raw SQL, and connection access. It is not the database itself.

## CanConnect for reachability checks

`CanConnect()` and `CanConnectAsync()` are reachability probes: they answer "Can I successfully connect to the configured database right now?" They catch connection exceptions and return false instead of throwing. Microsoft notes that a successful connection does not mean the schema is current or valid.

Typical uses:

- health checks for app startup
- readiness endpoints for Kubernetes or load balancers
- "is the DB reachable?" checks

Not for:

- "Did I apply migrations?"
- "Does this table exist?"
- "Is the schema correct?"

It only answers connectivity, not schema or migration state.

## EnsureCreated and EnsureDeleted

`EnsureCreated()` creates the database and schema from the current EF model if needed. Its behavior:

- if the database exists and has any tables, EF does nothing
- if the DB exists but has no tables, EF creates the schema
- if the DB does not exist, EF creates the DB and schema

`EnsureDeleted()` deletes the entire database if it exists.

Important warning: `EnsureCreated` does not use migrations. A database created this way is not meant to later be evolved with migrations. Microsoft recommends using migrations instead if you plan to use migrations at all.

Good for:

- prototypes
- tests
- local caches
- transient databases
- some non-relational providers that do not support migrations well

Not good for:

- production cleanup
- selective schema management

Common pattern in testing: call `EnsureDeleted()` and then `EnsureCreated()` to start from a clean DB.

## Migrate and migration inspection

`Migrate()` and `MigrateAsync()` apply all pending migrations to the database, and create the database if it does not already exist. Use these when your app uses EF Core migrations as the schema management strategy.

Migration inspection methods do not change the database:

- `GetPendingMigrations()` — migrations known by the app but not yet applied
- `GetAppliedMigrations()` — migrations already recorded as applied in the database
- `GetMigrations()` — all migrations known in the assembly/context model

Common usage: log pending migrations at startup, or fail startup if pending migrations exist in an environment where they should already be applied.

`HasPendingModelChanges()` checks whether the current model has changes not represented by a migration. This is useful in tests or CI to detect "you changed entities/configuration but forgot to add a migration."

## Migration class structure

The migration class defines:

- `Up(MigrationBuilder)` — build operations to apply the migration
- `Down(MigrationBuilder)` — build operations to revert the migration
- `BuildTargetModel(ModelBuilder)` — build the model snapshot for the target state

Important migration properties:

- `ActiveProvider` — name of the current database provider
- `UpOperations` — operations used to migrate "up"
- `DownOperations` — operations used to migrate "down"
- `TargetModel` — the model shape after this migration is applied

## What should be recallable

- What does `CanConnect` actually check?
- When is `CanConnect` useful versus not useful?
- What does `EnsureCreated` create and what does it not use?
- Why should `EnsureCreated` not be used for databases that will later use migrations?
- What does `Migrate` do and when should it be used?
- What do the migration inspection methods return?
- What does `HasPendingModelChanges` detect?
- What are the main migration class methods and properties?

## Sources

- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB01-databasefacade-connectivity-migrations.md`
