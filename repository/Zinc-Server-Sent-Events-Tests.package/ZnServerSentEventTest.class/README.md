I test the wire format of ZnServerSentEvent: what #writeOn: puts on a binary stream, field validation and backward compatible constructors.

Expected wire text is written with \n for LF and \r for CR, see #wire:.