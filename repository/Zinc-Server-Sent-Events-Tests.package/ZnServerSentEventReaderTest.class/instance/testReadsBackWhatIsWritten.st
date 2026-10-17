tests
testReadsBackWhatIsWritten
	| written bytes read |
	written := {
		ZnServerSentEvent data: 'one'.
		ZnServerSentEvent type: 'update' id: '7' data: (self wire: 'a\r\nb\rc\n').
		ZnServerSentEvent withComment: 'ping'.
		ZnServerSentEvent type: 'ünï' data: ' leading space €'.
		ZnServerSentEvent data: '' }.
	bytes := ByteArray streamContents: [ :out | written do: [ :each | each writeOn: out ] ].
	read := (ZnServerSentEventReader on: bytes readStream) upToEnd.
	self assert: read size equals: 4.
	self assert: (read collect: [ :each | each data ]) asArray equals: { 'one'. self wire: 'a\nb\nc\n'. ' leading space €'. '' }.
	self assert: (read collect: [ :each | each event ]) asArray equals: #( nil 'update' 'ünï' nil ).
	self assert: (read collect: [ :each | each id ]) asArray equals: #( nil '7' '7' '7' )