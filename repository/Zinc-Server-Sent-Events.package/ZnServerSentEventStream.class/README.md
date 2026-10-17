I am the server side of one open text/event-stream: what a handler's #runEventStream: gets from ZnServerSentEventResponse.

Sending (each answers true when written and flushed, false when I am or became closed):
  sendEvent: typeString data: aString id: idStringOrNil
  sendData: aString
  sendComment: aString      (keep-alive)
  sendRetry: milliseconds
  send: aZnServerSentEvent

Sends are serialised and callable from any process. A network failure while writing closes me; no exception reaches the caller. Invalid field values (see ZnServerSentEvent) still signal ZnInvalidServerSentEvent, since they are programming errors.

Waiting for something to send, woken by a ZnServerSentEventDoorbell rung from any process:
  waitFor: aDoorbell keepAliveEvery: aDuration   (true when rung, false when closed; an empty comment each idle interval)
  waitFor: aDoorbell atMost: aDuration           (true when rung, false on timeout or when closed)
Closing me rings the doorbell I wait on, so a wait ends as soon as I close.

Also: #request (the request that opened me), #lastEventId (its Last-Event-ID header or nil), #server, #isOpen, #close (from any process, without waiting for a send), #logEvents: (log each event through the server; off by default).

I close when the handler returns, when #close is sent, when a write fails, when the client goes away, and when the server stops. A watcher process per stream, named 'ZnServerSentEvent watcher <path>', waits on the socket's read semaphore and closes me as soon as the connection closes, whether the client went away or a ZnManagingMultiThreadedServer stopped, even while the handler sends nothing. Measured on macOS: about 1 ms after the client closes, about 150 bytes per parked watcher, no extra VM semaphores. The handler only writes and the watcher only reads, so they do not compete for the socket. A server that does not close its connections on stop is noticed at the next keep-alive.

Monitoring: #openStreams, #openStreamsFor: aServer and #numberOfOpenStreamsFor: aServer on the class side.

Part of Zinc HTTP Components.