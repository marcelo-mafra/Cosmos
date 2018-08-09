
// OmniHelp JS code referenced in head of frameset file, OHver 0.5
// Copyright (c) 2004 by Jeremy H. Griffith.  All rights reserved.

var isNav = true
var isN4 = true
var isN6 = false
var isIE = false
var isIE4 = false
var isIE5 = false

var projName = ""
var projTitle = ""
var showLeft = true
var hashName
var ctrlName = "ohctrl.htm"
var topNavName = "ohtop.htm"
var navCtrlName = "ohnavctrl.htm"
var navDocName = "ohnav.htm"
var mainDocName = "ohmain.htm"
var blankName = "javascript:parent.blank()"
var timeStr = ""


// loading project settings in head

function loadVars(doc) {
	if (opener && opener.projName) {
		projName = opener.projName
		projTitle = opener.projTitle
	} else if (window.location.search) {
		parseSearch(unescape(window.location.search.substr(1)))
	}
	if (projName.length == 0) {
		getFCookies()
	}
	doc.writeln('<title>', projTitle, '</title>')
	var str = '<script language="JavaScript" type="text/javascript" src="'
	str += projName + '.ohx"><' + '\/script>'
	doc.writeln(str)
}

function parseSearch(str) {
	var args = str.split("&")
	var argval = new Array()
	for (var i = 0 ; i < args.length ; i++) {
		argval = args[i].split("=")
		if (argval.length < 2) {
			break
		}
		if (argval[0] == "projName") {
			projName = argval[1]
		}
		else if (argval[0] == "projTitle") {
			projTitle = argval[1]
		}
	}
}


// functions for loading and reloading framesets

function restartOH() {
	setFCookies()
	var str = "ohframe.htm?var=" + escape(timeStr)
	window.location.replace(str)
}

function writeFramesets(doc) {
	var str = ""
	selectCSS()
	getFCookies()
	showNavLeft = showLeft
	if (showNavLeft == false) {
		writeSimpleFrameset(doc)
	} else if (topFirst) {
		writeTopFrameset(doc)
	} else {
		writeLeftFrameset(doc)
	}

  str = '<noframes><body>\n'
	str += '<p class="body">' + NoFramesMsg + '</p>\n'
  str += '</body></noframes></frameset></html>'
	doc.write(str)
	doc.close()
}

function writeSimpleFrameset(doc) {
	var str = '<frameset rows="0, 0, ' + topHigh + ', *"'
	if (frameBorder == false) {
		str += ' border="0"'
	}
	str += ' onload="frameLoaded()">\n'
	doc.write(str)
	writeFrame(doc, 'ctrl', true, true, blankName)
	writeFrame(doc, 'merge', true, true, blankName)
	writeFrame(doc, 'topnav', true, false, topNavName)
	writeFrame(doc, 'main', false, false, mainDocName)
}

function writeTopFrameset(doc) {
	var str = '<frameset rows="' + topHigh + ', *"'
	if (frameBorder == false) {
		str += ' border="0"'
	}
	str += ' onload="frameLoaded()">\n'
	str += '<frameset rows="0, 0, *" >\n'
	doc.write(str)
	writeFrame(doc, 'ctrl', true, true, blankName)
	writeFrame(doc, 'merge', true, true, blankName)
	writeFrame(doc, 'topnav', true, false, (isIE ? topNavName : blankName))
	str = '</frameset>\n'
	str += '<frameset id="leftNav" cols="' + leftWide + ', *">\n'
 	str += '<frameset rows="' + midHigh + ', *">\n'
	doc.write(str)
	writeFrame(doc, 'navctrl', true, false, navCtrlName)
	writeFrame(doc, 'nav', false, false, (isIE ? navDocName : blankName))
	str = '</frameset>\n'
	doc.write(str)
	writeFrame(doc, 'main', false, false, (isIE ? mainDocName : blankName))
	str = '</frameset>\n'
	doc.write(str)
}

function writeLeftFrameset(doc) {
	var str = '<frameset id="leftNav" cols="' + leftWide + ', *"'
	if (frameBorder == false) {
		str += ' border="0"'
	}
	str += ' onload="frameLoaded()">\n'
	str += '<frameset rows="' + midHigh + ', *">\n'
	doc.write(str)
	writeFrame(doc, 'navctrl', true, false, navCtrlName)
	writeFrame(doc, 'nav', false, false, (isIE ? navDocName : blankName))
	str = '</frameset>\n'
	str += '<frameset rows="0, 0,' + topHigh + ', *" >\n'
	doc.write(str)
	writeFrame(doc, 'ctrl', true, true, blankName)
	writeFrame(doc, 'merge', true, true, blankName)
	writeFrame(doc, 'topnav', true, false, (isIE ? topNavName : blankName))
	writeFrame(doc, 'main', false, false, (isIE ? mainDocName : blankName))
	str = '</frameset>\n'
	doc.write(str)
}

function writeFrame(doc, name, noscroll, nores, src) {
	var str = '<frame id="' + name + '" name="' + name 
	str += '" src="' + src + '"\n'
	str += ' frameborder="1"'  
	if (nores) {
		str += ' noresize="noresize"'
	}
	str += ' marginwidth="1" marginheight="1" '
	if (noscroll) {
		str += 'scrolling="no" '
	}
	str += '/>\n'
	doc.write(str)
}

function getFCookies() {
	var str = unescape(document.cookie)
	var pos = str.indexOf("=")
	if (pos == -1) {
		return false
	}
	var start = 0
	var end = str.indexOf(";")
	while (end != -1) {
		getFCookVal(str.substring(start, end))
		start = end + 2
		end = str.indexOf(";", start)
	}
	getFCookVal(str.substring(start, str.length))
	return true
}

function getFCookVal(cook) {
	var pos = cook.indexOf("=")
	if (pos == -1) {
		return
	}
	var name = cook.substring(0, pos)
	var val = cook.substring(pos + 1)
	if (name == "showNavLeft") {
		showLeft = (val == "true") ? true : false
	}
	else if (name == "projName") {
		projName = val
	}
	else if (name == "projTitle") {
		projTitle = unescape(val)
	}
}

function setFCookies() {
	var str = ''
	var exp = new Date()
	var nextYear = exp.getTime() + (365 * 24 * 60 * 60 * 1000)
	exp.setTime(nextYear)
	timeStr = exp.toGMTString()
	str = '; expires=' + timeStr
	document.cookie = "showNavLeft=" + (showNavLeft ? "true" : "false") + str
}


// function used to start frameset operation

function frameLoaded() {
	if (window.location.hash) {
		hashName = window.location.hash.substr(1)
	}
	ctrl.location.href = ctrlName
	topnav.location.href = topNavName
}

// functions used to set CSS per browser type

function selectCSS() {
	var ver = parseInt(navigator.appVersion)
	var v5 = false
	if (ver >= 4) {
		v5 = (parseInt(navigator.appVersion.substring(0,1)) >= 5)
		isNav = (navigator.appName == "Netscape")
		isIE = (navigator.appName.indexOf("Microsoft") != -1)
		isN4 = isNav && !v5 && !isIE
		isN6 =  v5 && !isIE
		isIE4 = isIE && (ver == 4)
		isIE5 = isIE && v5
		isNav = isNav && !isIE
	}

	if (isIE) {
		mainCssName = IECssName
		ctrlCssName = IECtrlCssName
	} else if (isN6) {
		mainCssName = N6CssName
		ctrlCssName = N6CtrlCssName
	} else if (isN4) {
		mainCssName = N4CssName
		ctrlCssName = N4CtrlCssName
	}
}

function ctrlCSS(doc) {
	var str = '<base href="' + parent.ctrl.location.href + '">\n'
	str += '<link rel="stylesheet" href="' + ctrlCssName + '" type="text/css" />'
	doc.writeln(str)
}

function mainCSS(doc) {
	var path = parent.ctrl.location.href
	var str = '<link rel="stylesheet" href="'
	str += path.substring(0, path.lastIndexOf('/') + 1)
	str += mainCssName + '" type="text/css" />'
	doc.writeln(str)
}


// function used to produce empty files for initial load

function blank() {
	return "<html></html>"
}


// end of ohframe.js

