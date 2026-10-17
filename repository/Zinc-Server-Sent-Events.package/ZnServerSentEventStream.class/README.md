I am the server side of one open text/event-stream: what a handler's #runEventStream: gets from ZnServerSentEventResponse.

Sending (each answers true when written and flushed, false when I am or became closed):
  sendEvent: typeString data: aString id: idStringOrNil
  sendData: aString
  sendComment: aString      (keep-alive)
  sendRetry: milliseconds
  send: aZnServerSentEvent

Sends are serialised and callable from any process. A network failure while writing closes me; no exception reaches the caller. Invalid field values (see ZnServerSentEvent) still signal ZnInvalidServerSentEvent, since they are programming errors.

Also: #request (the request that opened me), #lastEventId (its Last-Event-ID header or nil), #isOpen, #close (from any process, without waiting for a send), #logEvents: (log each event through the server; off by default).

A watcher process per stream, named 'ZnServerSentEvent watcher <path>', waits on the socket's read semaphore and closes me as soon as the client goes away, even while the handler sends nothing. Measured on macOS: about 1 ms after the client closes, about 150 bytes per parked watcher, no extra VM semaphores. The handler only writes and the watcher only reads, so they do not compete for the socket. The watcher ends with the connection.

Part of Zinc HTTP Components.