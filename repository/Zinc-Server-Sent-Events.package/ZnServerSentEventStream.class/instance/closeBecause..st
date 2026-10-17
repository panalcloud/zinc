private
closeBecause: reason
	isOpen ifFalse: [ ^ self ].
	isOpen := false.
	waitingOn ifNotNil: [ :doorbell | doorbell ring ].
	self log: reason