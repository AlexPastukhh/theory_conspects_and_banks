# Streaming gzip JSON with custom HttpContent

Knowledge ID: `dotnet.streaming-gzip-httpcontent`

Topic: `dotnet`

## Core model

A custom `HttpContent` can serialize JSON and compress it while writing to the outgoing transport stream. This avoids first creating a giant UTF-16 string or a complete uncompressed `MemoryStream`.

```csharp
sealed class GzipJsonContent<T> : HttpContent
{
    private readonly T _value;
    private readonly JsonSerializerOptions? _options;

    public GzipJsonContent(
        T value,
        JsonSerializerOptions? options = null)
    {
        _value = value;
        _options = options;

        Headers.ContentType =
            new MediaTypeHeaderValue("application/json");

        Headers.ContentEncoding.Add("gzip");
    }
}
```

## Streaming serialization

```csharp
protected override async Task SerializeToStreamAsync(
    Stream stream,
    TransportContext? context)
{
    await using var gzip = new GZipStream(
        stream,
        CompressionLevel.Fastest,
        leaveOpen: true);

    await JsonSerializer.SerializeAsync(
        gzip,
        _value,
        _options);
}

protected override bool TryComputeLength(out long length)
{
    length = 0;
    return false;
}
```

The serializer writes JSON into `GZipStream`, which emits compressed bytes to the outgoing stream. `Content-Type` remains `application/json`, while `Content-Encoding: gzip` describes the representation encoding.

Returning `false` from `TryComputeLength` means the compressed size is not known before serialization. A precomputed `Content-Length` is therefore usually unavailable; HTTP/1.1 normally uses chunked transfer for the unknown-length content.

## Trade-off and use

```csharp
request.Content = new GzipJsonContent<MyType>(payload);
```

The design combines low working memory with compression at the cost of compression CPU and an unknown final length. It concerns sending custom request content; `ResponseHeadersRead` concerns when receiving a response completes and does not select this outbound serialization behavior.

## What should be recallable

- How can JSON be compressed without a full uncompressed memory buffer?
- Which content headers describe the JSON and gzip layers?
- Why does `TryComputeLength` normally return `false` here?
- What memory and CPU trade-off does on-the-fly compression make?
- Why is this request-content behavior separate from `ResponseHeadersRead`?

## Related knowledge

- `dotnet.httpcontent-read-stream-buffering` — the general hooks and buffering model of `HttpContent`.
- `dotnet.httpclient-response-streaming` — progressive response consumption.

## Sources

- Workspace: `_ai-conspects/httpcontent,custom one, readasstream buffering, compression directly to network/`
- Processed source: `FINAL_TRANSCRIPT.md`, S-001, S-006, S-010, and S-013
- Original SVG: `source/httpcontent,custom one, readasstream buffering, compression directly to network.svg`
