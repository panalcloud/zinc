tests
testIdRejectsLineBreaksAndNul
	{ String cr. String lf. String crlf. String with: (Character value: 0) } do: [ :each |
		self
			should: [ ZnServerSentEvent id: 'a', each, 'b' data: 'x' ]
			raise: ZnInvalidServerSentEvent ]