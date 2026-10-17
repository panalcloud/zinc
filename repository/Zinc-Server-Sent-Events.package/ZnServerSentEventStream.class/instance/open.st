initialize-release
open
	"Start watching the connection, so a client that goes away closes me at once"

	self log: 'opened'.
	self startWatcher