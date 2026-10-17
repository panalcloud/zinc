waiting
waitFor: aDoorbell atMost: aDuration
	"Wait until aDoorbell rings or aDuration passes. Answer true when rung while I am open.
	Closing me rings the doorbell I wait on, so a close or a client going away ends the wait at once."

	| rung |
	waitingOn := aDoorbell.
	[ isOpen ifFalse: [ ^ false ].
	  rung := aDoorbell waitAtMost: aDuration ]
		ensure: [ waitingOn := nil ].
	^ rung and: [ isOpen ]