A ZnServerSentEventResponse is a ZnResponse that keeps using the open HTTP connection after its headers are written, for a text/event-stream.

  ZnServerSentEventResponse request: request handler: handler

When the server calls #useConnection:, a handler that understands #runEventStream: gets a ZnServerSentEventStream over the connection and the request; returning from it ends the stream. A handler with only #run: gets the raw connection, as before.

The handler runs in the server's worker process for this connection (at Processor lowIOPriority), named 'ZnServerSentEvent <path>' meanwhile. It should wait rather than spin. An Error from #runEventStream: is logged as a server handler error (passed in debug mode); the server then closes the connection.

The written headers always have Content-Type text/event-stream;charset=utf-8, no Content-Length, and, unless the caller set them, Cache-Control: no-cache and X-Accel-Buffering: no (so nginx does not buffer). Server-side gzip and chunking are refused, since events are written raw.

Part of Zinc HTTP Components.