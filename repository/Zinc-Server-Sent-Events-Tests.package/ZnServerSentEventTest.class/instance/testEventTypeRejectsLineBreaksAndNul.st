tests
testEventTypeRejectsLineBreaksAndNul
	{ String cr. String lf. String crlf. String with: (Character value: 0) } do: [ :each |
		self
			should: [ ZnServerSentEvent type: 'a', each, 'b' data: 'x' ]
			raise: ZnInvalidServerSentEvent ]