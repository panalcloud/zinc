private
closeBecause: reason
	isOpen ifFalse: [ ^ self ].
	isOpen := false.
	self class unregister: self.
	waitingOn ifNotNil: [ :doorbell | doorbell ring ].
	self log: reason