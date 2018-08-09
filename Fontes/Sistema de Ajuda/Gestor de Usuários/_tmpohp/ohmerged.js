// OmniHelp JavaScript merged project functions, OHver 0.1
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.

// functions for loading merged subprojects

var mergeProj = ""

var js1Str = '<script language="JavaScript" type="text/javascript" src="'
var js2Str = '\/script>'


function loadMergeData(doc) {
	if (parent && parent.mergeProj) {
		mergeProj = parent.mergeProj
	} else {
		getMCookies()
	}
	var jsStr = js1Str + mergeProj
	var str = jsStr + '.ohc"><' + js2Str
	doc.writeln(str)
	str = jsStr + '.ohk"><' + js2Str
	doc.writeln(str)
	str = jsStr + '.ohs"><' + js2Str
	doc.writeln(str)
	str = jsStr + '.ohl"><' + js2Str
	doc.writeln(str)
	str = jsStr + '.oha"><' + js2Str
	doc.writeln(str)
	// and get its settings, for its own merge info
	str = jsStr + '.ohx"><' + js2Str
	doc.writeln(str)
}

function mergedLoaded(doc) {
	parent.ctrl.mergeLoaded(doc)
}


function getMCookies() {
	var str = unescape(document.cookie)
	var pos = str.indexOf("=")
	if (pos == -1) {
		return false
	}
	var start = 0
	var end = str.indexOf(";")
	while (end != -1) {
		getMCookVal(str.substring(start, end))
		start = end + 2
		end = str.indexOf(";", start)
	}
	getMCookVal(str.substring(start, str.length))
	return true
}

function getMCookVal(cook) {
	var pos = cook.indexOf("=")
	if (pos == -1) {
		return
	}
	var name = cook.substring(0, pos)
	var val = cook.substring(pos + 1)
	if (name == "mergeProj") {
		mergeProj = val
	}
}


// end of ohmerged.js


