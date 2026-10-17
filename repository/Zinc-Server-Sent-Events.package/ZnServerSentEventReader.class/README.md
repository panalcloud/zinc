I read Server-Sent Events from a binary text/event-stream, following the parsing rules of the HTML standard: UTF-8, CR, LF or CRLF line ends, a leading BOM skipped, one space after a colon removed, unknown fields ignored, an event dispatched at each blank line that ends some data, the event type reset after each blank line, and the last event id kept across events.

#next answers each dispatched event as a ZnServerSentEvent (event nil when the server gave no type; id the last event id), or nil when the stream ends; an unfinished last event is dropped. It blocks while the stream waits for input, so a socket stream's timeout bounds a read. Comment lines, which clients normally ignore, are passed to an optional #commentHandler:. #lastEventId and #retry hold what a client would use when reconnecting.

Departure from the standard: an event type containing NUL is ignored, like an id containing NUL, because ZnServerSentEvent refuses such values.

  (ZnServerSentEventReader on: (ZnClient new streaming: true; get: url; response) entity stream) next.

Used by tests of server-side streams and by Pharo clients of SSE endpoints.

Part of Zinc HTTP Components.