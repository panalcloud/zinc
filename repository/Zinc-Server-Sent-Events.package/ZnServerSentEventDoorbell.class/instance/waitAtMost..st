waiting
waitAtMost: aDuration
	"Answer true when rung, at once if a ring came since the last wait, or false after aDuration.
	All rings so far are taken: rings during the work that follows give the next wait.
	So post the work first, then ring; after a wait, look at all posted work."

	| rung |
	rung := (semaphore waitTimeoutMilliseconds: aDuration asMilliSeconds) not.
	semaphore consumeAllSignals.
	^ rung