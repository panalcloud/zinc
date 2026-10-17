A ZnServerSentEventResponse is a ZnResponse that keeps using the open HTTP connection after its headers are written, for a text/event-stream.

  ZnServerSentEventResponse request: request handler: handler

When the server calls #useConnection:, a handler that understands #runEventStream: gets a ZnServerSentEventStream over the connection and the request; returning from it ends the stream. A handler with only #run: gets the raw connection, as before.

The handler runs in the server's worker process for this connection (at Processor lowIOPriority), named 'ZnServerSentEvent <path>' meanwhile. It should wait rather than spin. An Error from #runEventStream: is logged as a server handler error (passed in debug mode); the server then closes the connection.

The written headers always have Content-Type text/event-stream;charset=utf-8, no Content-Length, and, unless the caller set them, Cache-Control: no-cache and X-Accel-Buffering: no (so nginx does not buffer). Server-side gzip and chunking are refused, since events are written raw.

Server settings that matter for streams
- #socketStreamTimeout (ZnServer>>#timeout:, 30 s by default) bounds socket reads and writes. Nothing reads on the server side of a stream, so an idle stream is not closed by it, with or without keep-alive; only a write that stays blocked that long (a client that stopped reading) ends the stream.
- #maximumNumberOfConcurrentConnections (32 by default) limits ZnManagingMultiThreadedServer, and every open stream holds one connection for its whole life. Raise it for many browser tabs.
- Each socket uses 3 slots of the VM external semaphore table (Smalltalk vm maxExternalSemaphores).
- Stopping a ZnManagingMultiThreadedServer closes its connections and so its streams at once; a plain ZnMultiThreadedServer does not, and its streams notice at their next keep-alive (see ZnServerSentEventStream>>#waitFor:keepAliveEvery:).

Part of Zinc HTTP Components.