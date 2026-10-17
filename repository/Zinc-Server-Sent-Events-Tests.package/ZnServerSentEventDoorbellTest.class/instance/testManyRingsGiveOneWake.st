tests
testManyRingsGiveOneWake
	10 timesRepeat: [ bell ring ].
	self assert: (bell waitAtMost: 1 second).
	self deny: (bell waitAtMost: 50 milliSeconds)