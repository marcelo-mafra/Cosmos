
// OmniHelp ctrl functions for related (ALinks), OHver 0.5
// Copyright (c) 2004 by Jeremy H. Griffith.  All rights reserved.

var lastRelTocId = -1
var lastRelType = -1

function useRel() {
	currNavCtrl = 3
	relType = 1
	writeRelCtrlFile()
	writeRelDocFile()
	setCookies()
}


function writeRelCtrlFile() {
	if ((lastNavCtrl == 3) && (lastRelType == relType)) {
		return
	}
	lastNavCtrl = 3
	lastRelType = (relType != 1) ? -1 : 1
	var doc = parent.navctrl.document
	doc.open()  //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Nav Control: Related, OHver 0.5</title>\n')
	parent.ctrlCSS(doc)
	doc.write('</head>\n<body class="ctrl"><table class="nav">\n')
	writeALinkCtrl(doc)
	doc.write('\n</table></body></html>')
	doc.close()
	relType = 1
}

function writeALinkCtrl(doc) {
	var str = '<tr>'
	ctrlCount = 1
	if (includeToc) {
		ctrlCount++
		str += '<th class="nav" width="' + widthTocCell + '"><a href="javascript:parent.ctrl.useToc()">' + ContentsButTxt + '</a></th>\n'
	}
	if (includeIdx) {
		ctrlCount++
		str += '<th class="nav" width="' + widthIdxCell + '"><a href="javascript:parent.ctrl.useIx()">' + IndexButTxt + '</a></th>\n'
	}
	if (includeFts) {
		ctrlCount++
		str += '<th class="nav" width="' + widthFtsCell + '"><a href="javascript:parent.ctrl.useSearch()">' + SearchButTxt + '</a></th>\n'
	}
	str += '<th class="navx" width="' + widthRelCell + '">' + RelatedButTxt + '</th></tr>\n'
	str += '<tr><td class="navx"'
	if (ctrlCount > 1) {
		str += 'colspan="' + ctrlCount + '"'
	}
	str += '><p class="navx">'
	if (relType == 1) {
		str += RelMsg
	} else if (relType == 2) {  // ALink jump info
		str += ALinkMsg
	} else if (relType == 3) {  // KLink jump info
		str += KLinkMsg
	}
	str += '</p></td></tr>\n'
	doc.write(str)
}


function writeRelDocFile(subjects) {
	if ((lastNavDoc == 3) && (lastRelTocId == currTocId) && !subjects) {
		return
	}
	lastNavDoc = 3
	lastRelTocId = subjects ? -1 : currTocId
	var doc = parent.nav.document
	doc.open()  //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Related Topics File, OHver 0.5</title>\n')
	parent.ctrlCSS(doc)
	doc.write('</head>\n<body class="nav">\n')
	if (currTocId == -1) {
		doc.write('<p class="toc1">', DocNoRelMsg, '</p>')
	} else {
		writeALinks(doc, subjects)
	}
	doc.write('\n</body></html>')
	doc.close()
	setTimeout("parent.nav.scrollTo(0,0)", 1000)
}

function numcomp(a, b) {
	return a - b
}

function writeALinks(doc, subjects) {
	var itemNum = 0
	var relItemDat = new Array()
	var itemSel = currTocId
	var topicItems = new Array()
	var idx = 0
	var idx2 = 0
	var relTopics = new Array()
	var relPos = 0
	var relName = ""
	var sName = ""
	var subPos = 0
	var ePos = 0

	if (subjects) {  // ALink jump list
		sName = subjects.toLowerCase()
		for (itemNum = 0 ; itemNum < relItems.length ; itemNum++ ) {
			relItemDat = relItems[itemNum]
			relName = relItemDat[0].toLowerCase()
			subPos = sName.indexOf(relName)
			ePos = subPos + relName.length
			if ((subPos > -1)
			 && ((subPos == 0) || (sName.charAt(subPos - 1) == ";"))
			 && ((ePos == sName.length) || (sName.charAt(ePos) == ";"))) {
				topicItems = relItemDat[1]
				for (idx = 0 ; idx < topicItems.length ; idx++) {
					if (topicItems[idx] != itemSel) {
						relTopics[relTopics.length] = topicItems[idx]
					}
				}
			}
		}
	} else {
	// go through all alink sets for those that ref the current topic
	// add all members of those sets to relTopics (except current topic)
		for (itemNum = 0 ; itemNum < relItems.length ; itemNum++ ) {
			relItemDat = relItems[itemNum]
			topicItems = relItemDat[1]
			for (idx = 0 ; idx < topicItems.length ; idx++) {
				if (topicItems[idx] == itemSel) {
					for (idx2 = 0 ; idx2 < topicItems.length ; idx2++) {
						if (topicItems[idx2] != itemSel) {
							relTopics[relTopics.length] = topicItems[idx2]
						}
					}
					break
				}
			}
		}
	}

	var lastItem = -1

	if (relTopics.length > 0) {
		relTopics.sort(numcomp)
		for (relPos = 0; relPos < relTopics.length ; relPos++) {
			itemNum = relTopics[relPos]
			if (itemNum != lastItem) {
				writeOneRelItem(doc, itemNum)
				lastItem = itemNum
			}
		}
	} else {
		doc.write('<p class="toc1">', NoRelItemMsg, '</p>')
	}
}


function writeOneRelItem(doc, num) {
	var str = '<p class="toc1"><a href="javascript:parent.ctrl.setDoc(' + num + ')">'
	str += tocItems[num][1] + '</a></p>'
	doc.writeln(str)
}


// end of relcode.js
