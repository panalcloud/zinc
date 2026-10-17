running
runEventStream: stream
	"Send a status update every 2 seconds until the client goes away.
	Ids count up, so a reconnecting client resumes after the Last-Event-ID it sends.
	Waiting on a doorbell instead of a Delay ends the loop as soon as the stream closes."

	| doorbell id |
	doorbell := ZnServerSentEventDoorbell new.
	id := (stream lastEventId ifNotNil: [ :last | last asInteger ]) ifNil: [ 0 ].
	stream sendRetry: 2000.
	[ (stream
		sendEvent: 'status-update'
		data: self statusString
		id: (id := id + 1) printString)
			and: [ (stream waitFor: doorbell atMost: 2 seconds) not and: [ stream isOpen ] ] ] whileTrue