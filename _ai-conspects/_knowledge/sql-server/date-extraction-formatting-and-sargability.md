# SQL Server date extraction, formatting, and SARGability

Knowledge ID: `sql-server.date-extraction-formatting-and-sargability`

Topic: `sql-server`

`YEAR(value)` (equivalent to `DATEPART(year, value)`) is concise for projection/grouping and returns NULL for NULL. `DATEPART` additionally extracts quarter, month, day/dayofyear, time parts, `iso_week`, weekday, and timezone offset. Weekday depends on `SET DATEFIRST`; calendar and timezone rules must be explicit.

```sql
SELECT DATEPART(iso_week, CreatedAt) AS IsoWeek
FROM Events;
```

Wrapping an indexed date column in `YEAR`, `DATEPART`, conversion, or `FORMAT` commonly makes filtering non-SARGable. Use typed half-open ranges that keep the column untouched:

```sql
WHERE OrderDate >= @Start
  AND OrderDate <  @End;
```

Inclusive start/exclusive next boundary handles all supported time precisions and avoids fragile end-of-day constants. Compute boundaries in the correct business timezone before querying UTC timestamps. Persisted indexed computed columns or calendar tables can support recurring fiscal/local component searches.

`FORMAT` returns `nvarchar` through .NET/CLR formatting and supports custom format/culture:

```sql
SELECT FORMAT(OrderDate, 'yyyy-MM', 'en-US') AS MonthLabel
FROM Orders;
```

It is often much slower than native functions and is best reserved for final presentation when the application cannot format. Formatted strings are not dates and sort chronologically only when deliberately designed. Prefer application formatting at volume and inspect actual plans/logical reads to confirm expected seeks.

## Sources
- Workspace: `_ai-conspects/date/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
