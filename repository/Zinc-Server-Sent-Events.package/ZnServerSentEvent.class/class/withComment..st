instance creation
withComment: string
	"A comment-only event, ignored by clients; an empty string makes the shortest keep-alive"

	^ self new
		comment: string;
		yourself