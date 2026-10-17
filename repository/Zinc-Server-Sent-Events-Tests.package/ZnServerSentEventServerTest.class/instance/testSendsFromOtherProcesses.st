tests
testSendsFromOtherProcesses
	"Sends are serialised, so events from several processes arrive whole"

	| response events |
	self serve: (self handler: [ :stream | | done |
		done := Semaphore new.
		1 to: 5 do: [ :i |
			[ 20 timesRepeat: [ stream sendData: i printString, String lf, i printString ]. done signal ] fork ].
		5 timesRepeat: [ done waitTimeoutSeconds: 5 ] ]).
	response := self get: 'events'.
	events := (self readerOn: response) upToEnd.
	self assert: events size equals: 100.
	self assert: (events allSatisfy: [ :each | | lines | lines := each data lines. lines size = 2 and: [ lines first = lines last ] ])