
// OmniHelp main JavaScript control functions, OHver 0.1
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.

// usage for each possible navigation element
var includeToc = true
var includeIdx = true
var includeFts = true
var includeRel = true

// cell widths total 180 for elements used
var widthTocCell = 65
var widthIdxCell = 65
var widthFtsCell = 65
var widthRelCell = 65

// variables used for internal state info
var ctrlCount = 4
var currNavCtrl = 0
var lastNavCtrl = -1
var lastNavDoc = -1
var currTocId = 0
var lastTocId = 0
var mergedOffset = 0
var mergePos = 0
var merging = false
var mergeDone = false
var mergedAll = false
var currIxId = "0"
var tocShow = 1
var tocExpPos = -1
var boolSearch = "new"
var lastSearch = ""
var relType = 1
var firstLoad = true
var lastMainFile = ""
var backCount = 0
var fwdCount = 0
var goingBack = false
var goingFwd = false
var backList = new Array()
var backUrl = new Array()


// functions used to load frames in sequence
var js1Str = '<script language="JavaScript" type="text/javascript" src="'
var js2Str = '\/script>'

function loadData(doc) {
	ctrlCount = 0
	if (parent.useNavToc) {
		ctrlCount++
		includeToc = true
	} else {
		includeToc = false
	}
	if (parent.useNavIdx) {
		ctrlCount++
		includeIdx = true
	} else {
		includeIdx = false
	}
	if (parent.useNavFts) {
		ctrlCount++
		includeFts = true
	} else {
		includeFts = false
	}
	if (parent.useNavRel) {
		ctrlCount++
		includeRel = true
	} else {
		includeRel = false
	}

	if (ctrlCount == 3) {
		widthTocCell = 60
		widthIdxCell = 60
		widthFtsCell = 60
		widthRelCell = 60
	} else if (ctrlCount == 2) {
		widthTocCell = 90
		widthIdxCell = 90
		widthFtsCell = 90
		widthRelCell = 90
	} else if (ctrlCount == 1) {
		widthTocCell = 180
		widthIdxCell = 180
		widthFtsCell = 180
		widthRelCell = 180
	}

	// always include toc data even if not displaying toc itself
	window.status = LoadMsg
	var str = js1Str + parent.projName + '.ohc"><' + js2Str
	doc.writeln(str)
	if (includeToc) {
		str = js1Str + 'ohtoc.js"><' + js2Str
		doc.writeln(str)
	}
	if (includeIdx) {
		str = js1Str + 'ohidx.js"><' + js2Str
		doc.writeln(str)
		str = js1Str + parent.projName + '.ohk"><' + js2Str
		doc.writeln(str)
	}
	if (includeFts) {
		str = js1Str + 'ohfts.js"><' + js2Str
		doc.writeln(str)
		str = js1Str + parent.projName + '.ohs"><' + js2Str
		doc.writeln(str)
	}
	if (includeRel) {
		str = js1Str + 'ohrel.js"><' + js2Str
		doc.writeln(str)
		str = js1Str + parent.projName + '.ohl"><' + js2Str
		doc.writeln(str)
	}
	// always include CSH info
	str = js1Str + parent.projName + '.oha"><' + js2Str
	doc.writeln(str)
	// include merge code if subprojects defined
	if (parent.mergeProjects.length > 0) {
		str = js1Str + 'ohmerge.js"><' + js2Str
		doc.writeln(str)
	}
}

function ctrlLoaded() {
	window.status = (mergedAll) ? MergeDoneMsg : LoadDoneMsg
	getCookies()
	if ((parent.mergeProjects.length > 0) && parent.mergeFirst) {
		if (!mergedAll) {
			mergeAll()
			return
		}
	} else if (mergedOffset) {
		if (currTocId > mergePos) {
			if (currTocId > mergedOffset) {
				currTocId -= mergedOffset
			} else {
				currTocId = mergePos + 1
			}
		}
		mergedOffset = 0
		mergePos = 0
	}
	if ((currTocId <= 0) || (currTocId >= tocItems.length)) {
		var ch = ''
		for (currTocId = 0 ; currTocId < tocItems.length ; currTocId++) {
			ch = tocItems[currTocId][2].charAt(0)
			if ((ch != '*') && (ch != '!')) {
				break
			}
		}
	}
	var origTocId = currTocId
	if (parent.hashName) {
		var str = parent.hashName
		if (str.lastIndexOf('.') == -1) {
			checkCshItem(str)
		} else {
			checkTocItem(str)
		}
		if (currTocId == -1) {
			currTocId = origTocId
			parent.hashName = ""
		}
		else {
			setCookies()
		}
	}
	if (parent.showNavLeft) {
		setTimeout("writeNavCtrlFile()", 1000)
	}
	setTimeout("writeMainFile()", 1000)
}

function writeMainFile() {
	if (!parent.mainName) {
		parent.mainName = tocItems[0][2]
	}
	if (parent.hashName) {
		lastMainFile = parent.hashName
		parent.hashName = ""
	} else if (merging || (currTocId <= 0)) {
		lastMainFile = parent.mainName
	} else {
		// step off any merge items
		var ch = tocItems[currTocId][2].charAt(0)
		while ((currTocId < tocItems.length)
				&& ((ch == '*') || (ch == '!'))) {
			currTocId++
			ch = tocItems[currTocId][2].charAt(0)
		}
		while ((currTocId > 0)
				&& ((ch == '*') || (ch == '!'))) {
			currTocId--
			ch = tocItems[currTocId][2].charAt(0)
		}
		lastMainFile = tocItems[currTocId][2]
	}
	parent.main.location.replace(lastMainFile)
	writeNavDocFile(true)
	setCookies()
}

function mainChanged() {
	if (merging) {
		return
	}
	getCookies()
	if (checkTocItem()) {
		setCookies()
		writeNavDocFile(firstLoad)
	}
	if (goingFwd) {
		goingFwd = false
	} else if (goingBack) {
		goingBack = false
	} else {
		if (!firstLoad) {
			backCount++
			fwdCount = 0
		} else {
			firstLoad = false
		}
		backList[backCount] = currTocId
		backUrl[backCount] = parent.main.location.href
	}
}

function writeNavCtrlFile() {
	if (!parent.showNavLeft) {
		return
	}
	if (currNavCtrl == 0) {
		if (includeToc) {
			writeTocCtrlFile()
		} else {
			currNavCtrl = 1
		}
	}
	if (currNavCtrl == 1) {
		if (includeIdx) {
			writeIxCtrlFile()
		} else {
			currNavCtrl = 2
		}
	}
	if (currNavCtrl == 2) {
		if (includeFts) {
			writeSearchCtrlFile()
		} else {
			currNavCtrl = 3
		}
	}
	if (currNavCtrl == 3) {
		if (includeRel) {
			writeRelCtrlFile()
		} else {
			currNavCtrl = 0
			writeTocCtrlFile()
		}
	}
}

function writeNavDocFile(all) {
	if (!parent.showNavLeft) {
		return
	}
	if (currNavCtrl == 0) {
		writeTocDocFile()
	} else if (all && (currNavCtrl == 1)) {
  	writeIxDocFile()
	} else if (all && (currNavCtrl == 2)) {
  	writeSearchDocFile(false)
	} else if (currNavCtrl == 3) {
  	writeRelDocFile()
	}
}


// functions to handle ALink and KLink jumps

function alink(str) {
	// switch to Related, set description for ALinks
	relType = 2
	currNavCtrl = 3
	writeRelCtrlFile()
	writeRelDocFile(str)
	lastNavCtrl = -1
}

function klink(str) {
	// switch to Related, set description for KLinks
	relType = 3
	currNavCtrl = 3
	writeRelCtrlFile()
	writeIxDocFile(str)
	lastNavCtrl = -1
}


// functions to store and retrieve current state in cookies

function getCookies() {
	var str = unescape(document.cookie)
	var pos = str.indexOf("=")
	if (pos == -1) {
		return false
	}
	var start = 0
	var end = str.indexOf(";")
	while (end != -1) {
		getCookVal(str.substring(start, end))
		start = end + 2
		end = str.indexOf(";", start)
	}
	getCookVal(str.substring(start, str.length))
	return true
}

function getCookVal(cook) {
	var pos = cook.indexOf("=")
	if (pos == -1) {
		return
	}
	var name = cook.substring(0, pos)
	var val = cook.substring(pos + 1)
	if (name == "currTocId") {
		currTocId = parseInt(val)
	} else if (name == "mergedOffset") {
		mergedOffset = parseInt(val)
	} else if (name == "mergePos") {
		mergePos = parseInt(val)
	} else if (name == "currNavCtrl") {
		currNavCtrl = parseInt(val)
	} else if (name == "lastSearch") {
		lastSearch = val
	} else if (name == "boolSearch") {
		boolSearch = val
	} else if (name == "tocShow") {
		tocShow = parseInt(val)
	} else if (name == "currIxId") {
		currIxId = val
	} else if (name == "showNavLeft") {
		parent.showNavLeft = (val == "true") ? true : false
	}
}

function setCookies() {
	var str = ''
	if (parent.persistSettings) {
		var exp = new Date()
		var nextYear = exp.getTime() + (365 * 24 * 60 * 60 * 1000)
		exp.setTime(nextYear)
		str = '; expires=' + exp.toGMTString()
	}
	document.cookie = "currTocId=" + currTocId + str
	document.cookie = "mergedOffset=" + mergedOffset + str
	document.cookie = "mergePos=" + mergePos + str
	document.cookie = "currNavCtrl=" + currNavCtrl + str
	document.cookie = "lastSearch=" + lastSearch + str
	document.cookie = "boolSearch=" + boolSearch + str
	document.cookie = "tocShow=" + tocShow + str
	document.cookie = "currIxId=" + currIxId + str
	document.cookie = "showNavLeft=" + (parent.showNavLeft ? "true" : "false") + str
}



// functions for topnav control buttons

function getStart() {
	currTocId = 0
	currNavCtrl = 0
	firstLoad = true
	if (includeToc) {
		lastTocShow = -1
		lastDocTocShow = -1
	}
	if (includeIdx) {
		firstIdxUse = true
	}
	if (!parent.mainName) {
		var str = ""
		str += tocItems[0][2]
		parent.mainName = str
	} else {
		checkTocItem(parent.mainName)
		if (currTocId == -1) {
			currTocId = 0
		}
	}
	setDoc(currTocId, parent.mainName)
	if (parent.showNavLeft) {
		writeTocCtrlFile()
		writeTocDocFile()
	}
}

function getPrev() {
	checkTocItem()
	if (currTocId < 0) { // invalid, no idea what is prev
		getStart()
	}

	var sel = currTocId
	if (sel > 0) {
		sel--
	}
	var item = tocItems[sel]
	while (sel > 0) {
		if (checkCondToc(item)) {
			break
		}
		sel--
		item = tocItems[sel]
	}
	setDoc(sel)
}

function getNext() {
	checkTocItem()
	if (currTocId < 0) { // invalid, no idea what is next
		getStart()
	}

	var sel = currTocId
	var prev = tocItems[sel]
	if (sel < (tocItems.length - 1)) {
		sel++
	}
	var item = tocItems[sel]
	while (sel < (tocItems.length - 1)) {
		if ((item[2] != prev[2]) && checkCondToc(item)) {
			break
		}
		sel++
		item = tocItems[sel]
	}
	setDoc(sel)
}

function getBack() {
	if (backCount > 0) {
		backCount--
		fwdCount++
		goingBack = true
		setDoc(backList[backCount], backUrl[backCount], true)
	}
}

function getFwd() {
	if (fwdCount > 0) {
		fwdCount--
		backCount++
		goingFwd = true
		setDoc(backList[backCount], backUrl[backCount], true)
	}
}

function getHS() {
	var str = ''
	if (parent.isNav) {
		str = SHNav4StartMsg
		str += SHNav4EndMsg
		if (mergeDone && !confirm(str)) {
			return
		}
		parent.showNavLeft = !parent.showNavLeft
		setCookies()
		parent.restartOH()
	} else {
		parent.showNavLeft = !parent.showNavLeft
		setCookies()
		var obj = parent.isIE4 ? parent.document.all["leftNav"] : parent.document.getElementById("leftNav")
		str = '' + ((parent.showNavLeft) ? parent.leftWide : 0) + ', *'
		obj.cols = str
		if (parent.topButtons) {
			obj = parent.isIE4 ? parent.topnav.document.all["topHS"] : parent.topnav.document.getElementById("topHS")
			obj.value = (parent.showNavLeft) ? parent.topnav.HideButTxt : parent.topnav.ShowButTxt
			obj.title = (parent.showNavLeft) ? parent.topnav.HideButTitle : parent.topnav.ShowButTitle
		}
	}
}


function setDoc(num, ref, full) {
	if (num >= tocItems.length) {
		return
	}
	if (num == currTocId) { 
		if (!firstLoad) {
			return
		}
	} else if (num == -1) {
		currTocId = -1
		return
	}
	var str = ''
	if (full && ref) {
		str = ref
	} else {
		str += tocItems[num][2]
	}
	parent.main.location.href = str
	currTocId = num
	writeNavCtrlFile()
	writeNavDocFile(false)
	lastMainFile = parent.main.location.href
	setCookies()
}


// checking to see if item valid in helpset

function checkCshItem(str) {
	var itemNum = 0
	var itemName = ""
	var fileName = ""
	var tstr = str.toLowerCase()
	for (itemNum = 0 ; itemNum < cshItems.length ; itemNum++) {
		itemName = cshItems[itemNum][0]
		if (tstr == itemName.toLowerCase()) {
			fileName = cshItems[itemNum][1]
			break
		}
	}
	if (!fileName) {
		currTocId = -1
	} else {
		checkTocItem(fileName)
	}

	if (currTocId >= 0) {
		parent.hashName = fileName + '#' + itemName
	}
}


function checkTocItem(url) {

	if (!url) {
		url = parent.main.location.href
	}
	var pathEnd = url.lastIndexOf("/") + 1
	var currFile = unescape(url.substring(pathEnd, url.length))

	if ((currTocId >= 0) && (tocItems[currTocId][2] == currFile)) {
	  // correct Id, no need to reload
		return firstLoad
	}
	// otherwise change currTocId to match the file loaded
	for (var i = 0 ; i < tocItems.length ; i++) {
		if (tocItems[i][2] == currFile) {
			currTocId = i
			// found in list, reload
			return true
		}		
	}

	// try again, matching base name only
	var hash = url.indexOf("#")
	if (hash == -1) {
		hash = url.length
	}
	currFile = unescape(url.substring(pathEnd, hash))
	currFile = currFile.toLowerCase()
	if (checkTocBaseName(currFile)) {
		// found in list, reload
		return true
	}

	// see if in subproject to merge
	if (!merging && parent.mergeProjects.length && checkMerge(currFile)) {
		return true
	}

	// mark as invalid (may be external Web page)
	currTocId = -1
	// not in list, no use reloading
	return false
}

function checkTocBaseName(name) {
	var itemName = ""
	var baseName = ""
	var hash = 0
	for (var i = 0 ; i < tocItems.length ; i++) {
		itemName = tocItems[i][2]
		hash = itemName.indexOf("#")
		if (hash == -1) {
			hash = itemName.length
		}
		baseName = itemName.substring(0, hash)
		baseName = baseName.toLowerCase()
		if (baseName == name) {
			currTocId = i
			return true
		}		
	}
	return false
}


// functions for secondary and pop-up windows

var nextPop = 0
var popProps = "dependent,scrollbars,resizable"
var popWins = new Array()
var secProps = "dependent,scrollbars,resizable,title,titlebar,status,menubar,toolbar"
var secWins = new Array()


function secWin(link, wide, high, props) {
	// called from onClick handler in <a> link tag
	var win = link.target
	var url = link.href
	var nwin = 0
	var pprop = ""

	if (win == "popup") {  // make fresh each time
		nextPop++
		var pname = 'pop' + nextPop
		pprop = props ? props : popProps
		if (wide) {
			pprop += ",width=" + wide
		}
		if (high) {
			pprop += ",height=" + high
		}
		nwin = window.open(url, pname, pprop)
		if (nwin) {
			popWins[nextPop] = nwin
		}
	} else {  // secondary window, re-use if open
		var found = false
		var loaded = false
		var len = secWins.length
		var i = 0

		for (i = 0 ; i < len ; i++) {
			if (secWins[i][0] == win) {
				found = true
				// if still open, use it
				nwin = secWins[i][1]
				if (!nwin.closed) {
					nwin.location.href = url
					loaded = true
					nwin.focus()
				}
				break
			}
		}
		if (!loaded) {
			pprop = props ? props : secProps
			if (wide) {
				pprop += ",width=" + wide
			}
			if (high) {
				pprop += ",height=" + high
			}
			nwin = window.open(url, win, pprop)
			if (nwin) {
				if (found) {
					secWins[i][1] = nwin
				} else {
					secWins[len] = new Array(win, nwin)
				}
			}
		}
	}
}


// position doc in nav frame so item is visible

function setDocScrollPos(doc, anch, id) {
	var vpos = 0
	var last = "x00"
	var epos = 0
	var vhigh = 0
	var npos = 0
	var velem = 0
	var eelem = 0

	if (parent.isN4) {
		vpos = doc.anchors[anch].y
		epos = doc.anchors[doc.anchors.length - 1].y
	} else if (parent.isIE4) {
		vpos = doc.all[id].offsetTop
		epos = doc.all[last].offsetTop
	} else {
		velem = doc.getElementById(id)
		eelem = doc.getElementById(last)
		vpos = velem.offsetTop
		epos = eelem.offsetTop
	}
	if (parent.isNav) {
		vhigh = parent.nav.innerHeight
	} else {
		vhigh = doc.body.clientHeight
	}

	var ihigh = 50
	var lpg = (epos - vhigh) + ihigh
	if (vpos > (vhigh - ihigh)) {  // if curr anchor is not in view
		npos = vpos - (vhigh / 3)    // scroll so it is a bit above center
		if (npos > lpg) {            // if that puts it on last page
			npos = lpg                 // scroll to top of last page
		}
	}
	if (tocExpPos > -1) {
		npos = tocExpPos
		tocExpPos = -1
	}

	parent.nav.scrollTo(0, npos)
	return vpos
}



// stub functions for cond:

function checkCondToc(num) {
	return true
}

function checkCondIx(num) {
	return true
}

// end of ctrl.js
