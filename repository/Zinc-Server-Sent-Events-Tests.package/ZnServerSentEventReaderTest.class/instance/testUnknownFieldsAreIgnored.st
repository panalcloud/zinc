tests
testUnknownFieldsAreIgnored
	| events |
	events := self eventsIn: 'foo: bar\ndata: x\nData: y\n\n'.
	self assert: events size equals: 1.
	self assert: events first data equals: 'x'