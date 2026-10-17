initialize-release
open
	"Count me as open and start watching the connection, so a client that goes away closes me at once"

	self class register: self.
	self log: 'opened'.
	self startWatcher