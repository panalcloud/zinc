tests
testUtf8
	| data bytes |
	data := 'Grüße € ', (String with: (Character value: 16r1F600)).
	bytes := self bytesOf: (ZnServerSentEvent type: 'ünï' data: data).
	self assert: bytes equals: (self wire: 'event: ünï\ndata: ', data, '\n\n') utf8Encoded.
	self assert: bytes utf8Decoded equals: (self wire: 'event: ünï\ndata: ', data, '\n\n')