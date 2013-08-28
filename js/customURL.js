var CustomURLPlugin = Class(function () {
    NATIVE.events.registerHandler('customURLPlugin', function(e) {
		console.log("{CustomURLPlugin} received return event");
		if (e.method == "handleURL") {
			console.log("{CustomURLPlugin} GC received game "+e.gameID+" notification for player "+e.playerID);
		}
	});

	//plugins.customURLPlugin.clearBadge
	this.clearBadge = function() {	
		console.log("{CustomURLPlugin} Requesting Badge Clear");
		var e = {method:"clearBadge"}
		NATIVE.plugins.sendEvent("CustomURLPlugin", "onRequest", JSON.stringify(e));
	}
});

exports = new CustomURLPlugin();