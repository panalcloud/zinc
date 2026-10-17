tests
testThousandRingsFromTenProcesses
	"ZSSE-STR4: 1 000 rings from 10 processes while the waiter works 10 ms per wake.
	No wait times out while rings are still coming, and a wake follows the last ring."

	| finished lock lastRing wakes timeoutsWhileRinging deadline ringing |
	lock := Mutex new.
	finished := 0.
	wakes := OrderedCollection new.
	timeoutsWhileRinging := 0.
	ringing := [ (lock critical: [ finished ]) < 10 ].
	1 to: 10 do: [ :i |
		[ [ 100 timesRepeat: [
			bell ring.
			lastRing := Time microsecondClockValue.
			(Delay forMilliseconds: 1) wait ] ]
				ensure: [ lock critical: [ finished := finished + 1 ] ] ] fork ].
	deadline := Time millisecondClockValue + 10000.
	[ (bell waitAtMost: 1 second)
		ifTrue: [ wakes add: Time microsecondClockValue ]
		ifFalse: [ ringing value ifTrue: [ timeoutsWhileRinging := timeoutsWhileRinging + 1 ] ].
	  (Delay forMilliseconds: 10) wait.
	  ringing value not and: [ wakes notEmpty and: [ wakes last > lastRing ] ] ]
		whileFalse: [ self assert: Time millisecondClockValue < deadline ].
	self assert: timeoutsWhileRinging equals: 0.
	self assert: wakes last > lastRing