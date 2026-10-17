private
checkSingleLine: object named: fieldName
	| forbidden |
	object ifNil: [ ^ self ].
	forbidden := { Character cr. Character lf. Character null }.
	(object asString anySatisfy: [ :each | forbidden includes: each ])
		ifTrue: [ ZnInvalidServerSentEvent signal: fieldName, ' cannot contain CR, LF or NUL' ]