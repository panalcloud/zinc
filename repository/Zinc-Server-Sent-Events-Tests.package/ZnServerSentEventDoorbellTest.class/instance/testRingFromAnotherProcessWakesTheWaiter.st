tests
testRingFromAnotherProcessWakesTheWaiter
	| start rung elapsed ringer |
	ringer := [ (Delay forMilliseconds: 50) wait. bell ring ] fork.
	start := Time millisecondClockValue.
	rung := bell waitAtMost: 5 seconds.
	elapsed := Time millisecondsSince: start.
	self assert: rung.
	self assert: elapsed < 1000