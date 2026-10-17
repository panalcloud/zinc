accessing
lastEventId
	"The Last-Event-ID header a reconnecting client sent, nil when absent"

	^ request ifNotNil: [ request headers at: 'Last-Event-ID' ifAbsent: [ nil ] ]