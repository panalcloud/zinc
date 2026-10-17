reading
do: block
	| event |
	[ (event := self next) isNil ] whileFalse: [ block value: event ]