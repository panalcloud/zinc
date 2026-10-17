accessing
clientHtml
	^ '<html>
	<head>
	<title>Zinc Server-Side Events Status Demo</title>
	<script language="javascript" type="text/javascript">
	var source, statusElement;
	function init() {
		statusElement = document.getElementById("status");
		source = new EventSource(''sse-status'');
		source.addEventListener(
			''status-update'', 
			function(event) {
				setStatus(''#'' + event.lastEventId + '' '' + event.data); 
			},
			false);
		source.addEventListener(
			''error'', 
			function(event) {
				setStatus(''(reconnecting)''); 
			},
			false);
	}
	function setStatus(text) {
		statusElement.textContent = text;
	}
	window.addEventListener("load", init, false);
	</script>
	</head>
	<body>
	<h1>Zinc Server-Side Events Status Demo</h1>
	<div><pre id="status"></pre></div>
	</body>
	</html>'