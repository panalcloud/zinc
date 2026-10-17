sending
sendEvent: typeString data: aString id: idStringOrNil
	"One event; aString may contain line breaks, typeString and idStringOrNil may be nil"

	^ self send: (ZnServerSentEvent new
		event: typeString;
		id: idStringOrNil;
		data: aString;
		yourself)