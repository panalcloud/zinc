tests
testByteOrderMarkAtTheEndIsIgnored
	"An ignored U+FEFF that ends the input reads as nothing: the reader ends without an element for it"

	| bom |
	bom := String with: (Character value: 16rFEFF).
	#( 'data: a\n\n' 'data: a\n\ndata: b\n' 'data: a\n\ndata: b' ) do: [ :input | | events |
		events := self eventsIn: input , bom.
		self assert: (events collect: [ :each | each data ]) equals: #( 'a' ) ].
	self assert: (self eventsIn: bom) isEmpty