tests
testByteOrderMarkAtTheStartIsSkipped
	| events |
	events := self eventsIn: (String with: (Character value: 16rFEFF)), 'data: x\n\n'.
	self assert: events size equals: 1.
	self assert: events first data equals: 'x'