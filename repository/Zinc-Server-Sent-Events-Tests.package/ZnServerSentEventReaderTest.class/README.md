I test ZnServerSentEventReader on in-memory byte streams: reading back what ZnServerSentEvent writes, and the parsing rules of the text/event-stream format (line ends, colons, comments, ids, retry, dispatch).

Input text is written with \n for LF and \r for CR, see #wire:.