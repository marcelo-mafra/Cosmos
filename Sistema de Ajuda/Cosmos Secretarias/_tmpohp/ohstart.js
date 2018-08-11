// OmniHelp frameset configuration and loading functions, OHver 0.2
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.


function loadFrameset() {
	document.cookie = "projName=" + projName
	document.cookie = "projTitle=" + escape(projTitle)

	var str = 'projName=' + projName + '&projTitle=' + projTitle
	var url = 'ohframe.htm?' + escape(str)

	if (newWindow) {
		var props = 'titlebar,title,status,resizable'
		if (frameHigh > 0) {
			props += ',height=' + frameHigh
		}
		if (frameWide > 0) {
			props += ',width=' + frameWide
		}
		if (frameOptions) {
			props += ',' + frameOptions
		}

		// open new window without chrome, sized per settings or curr window
		var nwin = window.open(url, "_blank", props)
		if (nwin == null) {
			window.location.replace(url)
			return false
		}
	} else {
		window.location.replace(url)
	}
	return closeWindow;
}


// end of ohstart.js

