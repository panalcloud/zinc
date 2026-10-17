private
startWatcher
	| socket |
	(connection respondsTo: #socket) ifFalse: [ ^ self ].
	(socket := connection socket) ifNil: [ ^ self ].
	watcher := [ self watch: socket ]
		forkAt: Processor activePriority
		named: 'ZnServerSentEvent watcher ', self path