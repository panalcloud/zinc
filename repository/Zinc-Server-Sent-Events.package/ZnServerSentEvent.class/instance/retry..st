accessing
retry: milliseconds
	(milliseconds isNil or: [ milliseconds isInteger and: [ milliseconds >= 0 ] ])
		ifFalse: [ ZnInvalidServerSentEvent signal: 'retry must be a non-negative integer, got ', milliseconds printString ].
	retry := milliseconds