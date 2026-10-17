tests
testNoGzipOrChunkingEvenWhenTheServerUsesThem
	| response |
	server useGzipCompressionAndChunking: true.
	self serve: (self runHandler: [ :connection | (ZnServerSentEvent data: 'x') writeOn: connection ]).
	response := self get: 'events' with: [ :client | client request setAcceptEncodingGzip ].
	self deny: (response headers includesKey: 'Transfer-Encoding').
	self deny: (response headers includesKey: 'Content-Encoding').
	self assert: (self readerOn: response) next data equals: 'x'