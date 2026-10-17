ZnServerSentEventStatusHandler is an example of a Server-Sent Events application.

This handler will send status updates every 2 seconds.

The status update contains the full precision current date and time and the memory usage.

#runEventStream: is the example to follow: it sends a retry hint, numbers its events so a reconnecting browser resumes after its Last-Event-ID, and ends as soon as the client goes away. #run: is the older way, writing ZnServerSentEvents on the raw connection; it ends only when a write fails.

See ZnServerSentEventDelegate's class comment for installation/usage instructions.

Part of Zinc HTTP Components.