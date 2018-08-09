
// OmniHelp functions for ix construction, OHver 0.5
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.

var lastIxId = ""
var lastDocIxId = ""
var idxScroll = ""
var firstIdxUse = true
var ixList = new Array()
var ixIdList = new Array()
var ixIDs = new Array()


function useIx() {
	currNavCtrl = 1
	writeIxCtrlFile()
	writeIxDocFile()
	setCookies()
}

// click on letter in navctrl second row
function setIxId(str) {
	currIxId = str
	writeIxCtrlFile()
	writeIxDocFile()
	setCookies()
}

// click on See ref to another part of the Idx
function setIdx(newId, hash) {
	idxScroll = escape(hash)
	if (currIxId != newId) {
		setIxId(newId)
	} else {
		idxLoaded(parent.nav.document)
	}
}

function writeIxCtrlFile() {
	if ((currIxId == lastIxId) && (lastNavCtrl == 1)) {
		return
	}
	lastNavCtrl = 1
	lastIxId = currIxId
	var doc = parent.navctrl.document
	doc.open() //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Nav Control: Index, OHver 0.5</title>\n')
	parent.ctrlCSS(doc)
	doc.write('</head>\n<body class="ctrl"><table class="nav">\n')
	writeIxCtrl(doc)
	doc.write('\n</table></body></html>')
	doc.close()
}

function writeIxCtrl(doc) {
	var str = '<tr>'
	ctrlCount = 1
	if (includeToc) {
		ctrlCount++
		str += '<th class="nav" width="' + widthTocCell + '"><a href="javascript:parent.ctrl.useToc()">' + ContentsButTxt + '</a></th>'
	}
	str += '<th class="navx" width="' + widthIdxCell + '">' + IndexButTxt + '</th>'
	if (includeFts) {
		ctrlCount++
		str += '<th class="nav" width="' + widthFtsCell + '"><a href="javascript:parent.ctrl.useSearch()">' + SearchButTxt + '</a></th>'
	}
	if (includeRel) {
		ctrlCount++
		str += '<th class="nav" width="' + widthRelCell + '"><a href="javascript:parent.ctrl.useRel()">' + RelatedButTxt + '</a></th>'
	}
	str += '</tr><tr><td class="navx"'
	if (ctrlCount > 1) {
		str += 'colspan="' + ctrlCount + '"'
	}
	str += '>'
	doc.writeln(str)
	if (idxItems.length == 0) {
		doc.writeln(NoIdxMsg)
	} else {
		writeIxList(doc)
	}
	doc.writeln('</td></tr>')
}


function writeIxList(doc) {
	var dat = new Array()
	var curr = ""
	var str = ""

	if (firstIdxUse) {
		setIxList()
		if (currIxId == "0") {  // starting, set to first entry
			currIxId = ixIdList[0]
		}
		firstIdxUse = false
	}

	for (var i = 0 ; i < ixIdList.length ; i++) {
		curr = ixIdList[i]
		if (curr == currIxId) {
			str = '<span class="currix">'
		} else {
			str = '<a href="javascript:parent.ctrl.setIxId' + "('" + curr + "')" + '">'
		}
		str += curr
		if (curr == currIxId) {
			str += '</span>'
		} else {
			str += '</a>'
		}
		doc.writeln(str)
	}
}

function setIxList()  {
	var dat = new Array()
	var curr = ""
	var last = ""
	var pos = 0

	ixList = new Array()
	ixIdList = new Array()
	ixIDs = new Array()

	for (var num = 0 ; num < idxItems.length ; num++) {
		dat = idxItems[num]
		if (dat[0] != 1) {
			continue
		}
		curr = getIxID(dat[1])
		if (curr != last) {
			if ((curr.length == 1) && (last.length == 1) && (curr < last)) {
				continue
			}
			if (((curr == SymTxt) || (curr == NumTxt)) && (last.length == 1) && (last >= "A")) {
				continue
			}
			ixList[pos] = num
			ixIdList[pos] = curr
			ixIDs[curr] = pos
			pos++
			last = curr
		}
	}
}

function getIxID(str) {
	var pos = 0
	var ch = ""
	while (pos < str.length) {
		ch = str.charAt(pos).toUpperCase()
		if (ch == '&') {
			while ((pos < str.length) && (ch != ';')) {
				pos++
				ch = str.charAt(pos).toUpperCase()
			}
		} else if (parent.ignoreCharsIX.indexOf(ch) != -1) {
			pos++
		} else if ((ch >= "0") && (ch <= "9")) {
			return NumTxt
		} else if ((ch < "A") || (ch > "Z")) {
			return SymTxt
		} else {
			return ch
		}
	}
	return "0"
}

function writeIxDocFile(items) {
	if ((currIxId == lastDocIxId) && (lastNavDoc == 1) && !items) {
		return
	}
	lastNavDoc = 1
	lastDocIxId = items ? -1 : currIxId
	var doc = parent.nav.document
	doc.open()  //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Index File, OHver 0.5</title>\n')
	parent.ctrlCSS(doc)
	//doc.writeln('</head>\n<body class="nav" onload="parent.ctrl.idxLoaded(document)" >\n')
	doc.writeln('</head>\n<body class="nav" >\n')
	if (items) {
		writeSelIdxItems(doc, items)
	} else {
		writeidxItems(doc)
	}
	doc.write('\n</body></html>')
	doc.close()
	if (!idxScroll) {
		setTimeout("parent.nav.scrollTo(0,0)", 1000)
	}
	else {
		idxLoaded(doc)
	}
}

function idxLoaded(doc) {
	if (idxScroll) {
		var anch = 0
		if (parent.isN4) {
			for (anch = 0 ; anch < doc.anchors.length ; anch++) {
				if (unescape(doc.anchors[anch].name) == idxScroll) {
					break
				}
			}
			if (anch >= doc.anchors.length) {
				return
			}
		}
		setDocScrollPos(doc, anch, idxScroll)
		idxScroll = ""
	}
}

function writeidxItems(doc) {
	if ((idxItems.length == 0)
	 || (ixIDs.length <= currIxId)
	 || (ixList.length <= ixIDs[currIxId])) {
		doc.write('<p class="toc1">', NoIdxItemMsg, '<p>')
		return
	}

	var pos = ixIDs[currIxId]
	var epos = ((pos + 1) < ixList.length) ? ixList[pos + 1] : idxItems.length

	for (var i = ixList[pos] ; i < epos ; i++) {
		writeOneIxItem(doc, idxItems[i])
	}
	doc.write('<a id="x00" name="x00"></a>')
}

function writeOneIxItem(doc, dat) {
	if (!checkCondIx(dat)) {
		return
	}
	var str = '<p class="toc' + dat[0] + '">'
	if (dat.length == 2) {
		if (dat[0] == 1) {
			str += '<a id="' + escape(dat[1]) + '" name="' + escape(dat[1]) + '"></a>'
		}
		str += dat[1]
	} else {
		str += '<a href="'
		if (dat[1].charAt(0) == "#") {  // for See and See Also entries
			var newId = getIxID(dat[2])
			var targ = dat[1].substr(1)
			var len = dat[1].indexOf(',')
			if (len > 1) {
				targ = dat[1].substr(1, len - 1)
			}
			str += 'javascript:parent.ctrl.setIdx(\'' + newId + '\',\'' + escape(targ) + '\')">'
			str += dat[2]
		} else {
			var num = dat[2]
			str += 'javascript:parent.ctrl.setDoc(' + num + ',\'' + dat[1] + '\')">' + tocItems[num][1]
		}
		str += '</a>'
	}
	str += '</p>'
	doc.writeln(str)
}


function writeSelIdxItems(doc, items) {
	var i = 0
	var lname = ""
	var klist = new Array()

	// split up item list at semis
	var ilist = items.split(";")
	for (i = 0 ; i < ilist.length ; i++) {
		lname = ilist[i].toLowerCase()
		ilist[i] = lname
	}

	// sort items (to allow one pass through index)
	ilist.sort(comp)

	// for each item, look for matching text item for all levels
	var state = 1
	var ipos = 0
	var iname = ilist[ipos]
	var xname = ""
	var npos = 0
	var reflev = 0
	var ch = ''
	var num = 0
	var spos = 0

	for (num = 0 ; num < idxItems.length ; num++) {
		dat = idxItems[num]
		xname = dat[1].toLowerCase()
		switch (state) {
			case 1: // scanning for first-level match
				if (dat[0] == 1) {
					while (iname < xname) {
						ipos++
						if (ipos >= ilist.length) {
							break
						} else {
							iname = ilist[ipos]
						}
					}
					spos = num - 1
					if (iname.indexOf(xname) == 0) {  // matched at start
						reflev = 2
						if (iname.length == xname.length) {  // full match
							state = 3
						} else {  // matched start, look for rest
							state = 2
							npos = xname.length
							ch = iname.charAt(npos)
							if ((ch == ',') || (ch == ':')) {
								npos++
							}
						}
					}
				}
				break
			case 2: // scanning for lower-level match
				if (dat[0] < reflev) {  // failed to find sub
					state = 1
					// advance to next iname
					ipos++
					// go back to last first-level item to rescan for next iname
					num = spos
				}
				if ((dat[0] == reflev) && !dat[2]) {
					if (iname.indexOf(xname, npos) == npos) {  // matched at start
						reflev++
						if ((iname.length - npos) == xname.length) {  // full match
							state = 3
						} else {  // matched start, keep looking for rest
							npos += xname.length
							ch = iname.charAt(npos)
							if ((ch == ',') || (ch == ':')) {
								npos++
							}
						}
					}
				}
				break
			case 3: // store copies of refs in klist
				if ((dat[0] >= reflev) && dat[2]) {
					klist[klist.length] = num
				} else if (dat[0] < reflev) {
					ipos++
					state = 1
					num = spos
				}
				break
			default:
				break
		}
		if (ipos >= ilist.length) {
			break
		} else {
			iname = ilist[ipos]
		}
	}

	var hash = ""

	if (klist.length) {
		// sort klist by topic numbers
		klist.sort(ixncomp)

		// put out list excluding duplicates and current topic
		for (i = 0; i < klist.length ; i++) {
			// will miss non-adjacent dups, needs slice and sort by dat[1]
			dat = idxItems[klist[i]]
			xname = dat[1].toLowerCase()
			if ((hash != xname) && (currTocId != dat[2])) {
				hash = xname
				writeSelIxItem(doc, dat)
			}
		}
	} else {
		doc.write('<p class="toc1">', NoKLinkItemMsg, '<p>')
	}
}

function comp(a, b) {
	if (a < b) {
		return -1
	}
	if (a > b) {
		return 1
	}
	return 0
}

function ixncomp(ax, bx) {
	a = idxItems[ax][2]
	b = idxItems[bx][2]
	return (a - b)
}

function ixscomp(ax, bx) {
	a = idxItems[ax][1]
	b = idxItems[bx][1]
	if (a < b) {
		return -1
	}
	if (a > b) {
		return 1
	}
	return 0
}


function writeSelIxItem(doc, dat) {
	var num = dat[2]
	var str = '<p class="toc1"><a href="javascript:parent.ctrl.setDoc('
	str += num + ',\'' + dat[1] + '\')">\n' + tocItems[num][1] + '</a></p>'
	doc.writeln(str)
}



// end of ixcode.js

