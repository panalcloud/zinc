tests
testTimeout
	| start |
	start := Time millisecondClockValue.
	self deny: (bell waitAtMost: 100 milliSeconds).
	self assert: (Time millisecondsSince: start) >= 90