A ZnServerSentEvent is used to send data from a server to an HTTP client, on the initiative of the server, often called a push notification.

ZnServerEvents are written out according to the text/event-stream MIME type: UTF-8, one 'field: value' line per field, LF line ends, a blank line after each event, and a flush.

Instances variables

 comment <String> optional comment text, written as ': text' lines that clients ignore; an empty comment is the shortest keep-alive
 event <String> optional event type tag, without CR, LF or NUL
 id <String> optional event id tag, without CR, LF or NUL; an empty id resets the client's last event id
 retry <Integer> optional number of milliseconds for connection retry, non-negative
 data <String> the actual data; CR, LF and CRLF split it into several data lines, which the client joins again with LF

Fields are written in the order comment, event, id, retry, data. An event without data (only an id, a retry or a comment) is processed by the client but does not fire a message event. Invalid values signal ZnInvalidServerSentEvent when set.

References

 https://html.spec.whatwg.org/multipage/server-sent-events.html
 https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events

  ZnServerSentEvent type: 'counter' data: 100.
  ZnServerSentEvent withComment: ''.
  ZnServerSentEvent retry: 5000.

Part of Zinc HTTP Components