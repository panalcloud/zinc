tests
testRingBeforeTheWaitIsKept
	| start |
	bell ring.
	self assert: bell isRung.
	start := Time millisecondClockValue.
	self assert: (bell waitAtMost: 2 seconds).
	self assert: (Time millisecondsSince: start) < 100.
	self deny: bell isRung