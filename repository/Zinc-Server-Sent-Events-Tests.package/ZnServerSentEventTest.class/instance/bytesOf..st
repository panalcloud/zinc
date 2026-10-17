private
bytesOf: event
	^ ByteArray streamContents: [ :stream | event writeOn: stream ]