tests
testEventWithoutDataIsNotDispatched
	"The event type is reset too, so it does not leak into the next event"

	| events |
	events := self eventsIn: 'event: lost\n\ndata: y\n\n'.
	self assert: events size equals: 1.
	self assert: events first event isNil.
	self assert: events first data equals: 'y'