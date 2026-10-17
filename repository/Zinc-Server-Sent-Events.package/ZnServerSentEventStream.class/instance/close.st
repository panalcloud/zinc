initialize-release
close
	"After close every send does nothing and answers false. The server closes the connection when the handler returns."

	isOpen := false