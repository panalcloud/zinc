private
closeBecause: reason
	isOpen ifFalse: [ ^ self ].
	isOpen := false.
	self log: reason