tests
testFieldWithoutColon
	"A line without colon is a field with an empty value"

	| events |
	events := self eventsIn: 'data\n\n'.
	self assert: events size equals: 1.
	self assert: events first data equals: ''