private
wire: aString
	"Answer aString with each \n replaced by LF and each \r by CR"

	^ (aString copyReplaceAll: '\n' with: String lf) copyReplaceAll: '\r' with: String cr