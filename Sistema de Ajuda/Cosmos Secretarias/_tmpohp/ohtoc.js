
// OmniHelp functions for toc construction, OHver 0.6
// Copyright (c) 2004 by Jeremy H. Griffith.  All rights reserved.

var lastTocShow = -1
var lastDocTocShow = -1
var tocSetGroupsOpen = false
var tocSetGroupsClosed = false
var currTocDoc = ''


function useToc() {
	if (parent.tocExpand) {
		tocShow = (parent.isN4) ? 2 : 3
		lastTocShow = 0
	}
	currNavCtrl = 0
	writeTocCtrlFile()
	writeTocDocFile()
	setCookies()
}


function writeTocCtrlFile() {
	if (!parent.showNavLeft || !parent.navctrl) {
		return
	}
	if ((tocShow == lastTocShow) && (lastNavCtrl == 0)) {
		return
	}
	if (parent.isN4 && (tocShow == 3)) {
		tocShow = 2
	}
	if (!parent.isN4 && parent.tocExpand) {
		tocShow = 3
	}
	lastNavCtrl = 0
	lastTocShow = tocShow
	var doc = parent.navctrl.document
	doc.open()  //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Nav Control: Contents, OHver 0.4</title>\n')
	parent.ctrlCSS(doc)
	doc.write('</head>\n<body class="ctrl"><table class="nav">\n')
	writeTocCtrl(doc)
	doc.write('\n</table></body></html>')
	doc.close()
}


function writeTocCtrl(doc) {
	var str = '<tr>'
	ctrlCount = 1
	str = '<th class="navx" width="' + widthTocCell + '">' + ContentsButTxt + '</th>'
	if (includeIdx) {
		ctrlCount++
		str += '<th class="nav" width="' + widthIdxCell + '"><a href="javascript:parent.ctrl.useIx()">' + IndexButTxt + '</a></th>'
	}
	if (includeFts) {
		ctrlCount++
		str += '<th class="nav" width="' + widthFtsCell + '"><a href="javascript:parent.ctrl.useSearch()">' + SearchButTxt + '</a></th>'
	}
	if (includeRel) {
		ctrlCount++
		str += '<th class="nav" width="' + widthRelCell + '"><a href="javascript:parent.ctrl.useRel()">' + RelatedButTxt + '</a></th>'
	}
	str += '</tr><form name="navContents" id="navContents">\n'
	if (parent.isN4 || !parent.tocExpand) {
		str += '<tr><td class="navxsmall"'
		if (ctrlCount > 1) {
			str += 'colspan="' + ctrlCount + '"'
		}
		str += '>\n'
		str += '<input type="radio" name="tocext" value="0" '
		if (tocShow == 0) {
			str += 'checked="checked" '
		}
		str += 'onClick="javascript:parent.ctrl.setTocDisplay(0)" />' + ShortButTxt + '&nbsp;&nbsp;'
		str += '<input type="radio" name="tocext" value="1" '
		if (tocShow == 1) {
			str += 'checked="checked" '
		}
		var medtxt = (parent.isN4) ? MediumButTxt : MedButTxt
		str += 'onClick="javascript:parent.ctrl.setTocDisplay(1)" />' + medtxt + '&nbsp;&nbsp;'
		str += '<input type="radio" name="tocext" value="2" '
		if (tocShow == 2) {
			str += 'checked="checked" '
		}
		str += 'onClick="javascript:parent.ctrl.setTocDisplay(2)" />' + FullButTxt
		if (!parent.isN4) {
			str += '&nbsp;&nbsp;<input type="radio" name="tocext" value="3" '
			if (tocShow == 3) {
				str += 'checked="checked" '
			}
			str += 'onClick="javascript:parent.ctrl.setTocDisplay(3)" />' + ExpButTxt
		}
		str += '</td></tr>'
	}
	if ((parent.tocExpand || (tocShow == 3)) && !parent.isN4) {
		str += '<tr><td class="navxbtn"'
		if (ctrlCount > 1) {
			str += ' colspan="' + ctrlCount + '"'
		}
		str += '>\n'
		str += '<input type="button" class="tocbtn" value="' + OpenAllButTxt + '"\n'
		str += ' onClick="javascript:parent.ctrl.setTocGroups(true)"'
		str += ' alt="' + OpenAllButTxt + '" />&nbsp;&nbsp;'
		str += '<input type="button" class="tocbtn" value="' + CloseAllButTxt + '"\n'
		str += ' onClick="javascript:parent.ctrl.setTocGroups(false)"'
		str += ' alt="' + CloseAllButTxt + '" />'
		str += '</td></tr>'
	}
	str += '</form>'
	doc.writeln(str)
}


function writeTocDocFile() {
	if ((tocShow == lastDocTocShow)
	 && (lastNavDoc == 0)
	 && (lastTocId == currTocId)) {
		return
	}
	var doc = parent.nav.document

	function setTocItemClass(num, sel) {
		var dat = tocItems[num]
		var lev = 'toc' + dat[0]
		if (sel) {
			lev += 'x'
		}
		var item = 'c' + num.toString()
		var obj
		if (parent.isIE4) {
			obj = doc.all[item]
		} else {
			obj = doc.getElementById(item)
		}
		obj.className = lev
		if (sel) {
			setDocScrollPos(doc, 0, item)
		}
	}

	if ((lastNavDoc != 0)
	 || (lastDocTocShow != 2)
	 || (tocShow != 2)
	 || (tocItems.length == 0)) {
		doc.open() //'text/html', "replace")
		doc.write('<html><head><title>OmniHelp Contents File, OHver 0.3</title>\n')
		parent.ctrlCSS(doc)
		doc.write('</head>\n<body class="nav">\n')
		if (tocItems.length == 0) {
			doc.write('<p class="toc1">', NoTocMsg, '</p>')
		} else if (currTocId == -1) {
			doc.write('<p class="toc1">', DocNoTocMsg, '</p>')
		} else {
			// doc.write(' onload="parent.ctrl.tocLoaded(document)">\n')
			writeTocItems(doc)
		}
		doc.write('\n</body></html>')
		doc.close()
	} else if (!parent.isN4) {  // N4 can only reposition
	  // must be change of selection in full TOC
		setTocItemClass(lastTocId, false)
		setTocItemClass(currTocId, true)
	}
	lastDocTocShow = tocShow
	lastNavDoc = 0
	lastTocId = currTocId
	currTocDoc = doc
	setTimeout('tocTimeLoaded()', 1)
}

function tocTimeLoaded() {
	tocLoaded(currTocDoc)
}

function tocLoaded(doc) {
	var item = 'c' + currTocId.toString()
	//alert('Item is ' + item)
	var i = 0
	if (parent.isN4) {
		for (i = 0 ; i < doc.anchors.length ; i++) {
			if (doc.anchors[i].name == item) {
				break
			}
		}
		if (i == doc.anchors.length) {
			return
		}
	}
	var pos = setDocScrollPos(doc, i, item)
	if (parent.isN4 && (tocShow >= 2)) {
		// use layers to position marker at selection pos
		var layer = doc.tocpoint
		layer.top = pos
		layer.height = 12
		layer.width = 12
		layer.visibility = "show"
	}
}

function setTocDisplay(val) {
	if (parent.isN4 && (val == 3)) {
		val = 2
	}
	if (((tocShow == 3) && (val < 3)) || ((tocShow < 3) && (val == 3))) {
		tocShow = val
		writeTocCtrlFile()
	} else {
		tocShow = val
		parent.navctrl.document.navContents.tocext[tocShow].checked = true
	}
	writeTocDocFile()
	setCookies()
}

function setTocGroups(open) {
	if (open) {
		tocSetGroupsOpen = true
	} else {
		tocSetGroupsClosed = true
	}
	lastDocTocShow = 0
	writeTocDocFile()
}

// functions for toc construction

// ico number is (tocItems[i][3] + tocItems[i][4]) + 2 if first item
// 1 open group (minus sign)
// 2 open group corner
// 3 open group top
// 4 open group top and corner
// 5 closed group (plus sign)
// 6 closed group corner
// 7 closed group top
// 8 closed group top and corner
// 9 non-group that isn't last of level (vertical bar)
// 10 bottom non-group (corner)
// 11 top non-group
// 12 top-level non-group (empty)
// 13 passing line (vertical bar)

// when clicked on +/- icon, toggle state, show/hide subs
// preserve open/closed state of hidden subs
function setTocExp(val) {
	var dat = tocItems[val]
	if (dat[3] == 1) {
		dat[3] = 5
	} else if (dat[3] == 5) {
		dat[3] = 1
	}
	lastDocTocShow = 0
	if (parent.isNav) {
		tocExpPos = parent.nav.pageYOffset
	} else {
		tocExpPos = parent.nav.document.body.scrollTop
	}
	writeTocDocFile()
}

function writeTocItems(doc) {
	if (currTocId == -1) {
		checkTocItem()
	}

	var i = 0
	var str = ""
	var itemNum = currTocId
	var itemDat = tocItems[itemNum]
	var itemLev = itemDat[0]
	var currLev = itemLev
	var prevSibs = true
	var ownChildren = true
	var itemList = new Array()
	var low = parent.lowMem
	var tcdef = parent.tocGroupsOpen ? 1 : 5
	var tcico = parent.tocIcoBase
	var vis = true
	var iDat = tocItems[0]
	var nDat = tocItems[1]
	var iLev = 1
	var nLev = 1
	var levList = new Array()
	var firstLev = tocItems[0][0]

	function writeOneTocItem(num) {
		var dat = tocItems[num]
		var flag = dat[2].charAt(0)
		var ico = 12
		var lev = dat[0]
		var clev = 1

		if ((flag == '!') || ((flag == '*') && !parent.mergeProjects.length)) {
			return
		}
		if ((tocShow == 3) && parent.isN4) {
			str += '<tr><td width=0>'
		}
		str += (parent.isN4) ? '<a name' : '<p id'
		str += '="c' + num
		str += (parent.isN4) ? '"></a><p ' : '"'
		str += ' class="toc' 
		if (tocShow == 3) {
			str += 'v'
		} else {
			str += lev
		}
		if ((!parent.isN4 || (tocShow < 2)) && (num == currTocId)) {
			str += 'x'
		} 
		str += '">'
		if (tocShow == 3) {
			if (lev > firstLev) {
				for (clev = firstLev; clev < lev; clev++) {
					str += '<img src="' + tcico + levList[clev] + '.gif" class="tcv" />'
				}
			}
			ico = dat[3] + dat[4]
			if ((num == 0) && (ico < 11)) {
				ico += 2
			}
			if (ico < 9) {
				str += '<a href="javascript:parent.ctrl.setTocExp(' + num + ')">'
			}
			str += '<img src="' + tcico + ico + '.gif" class="tcv" />'
			if (ico < 9) {
				str += '</a>'
			}
		}
		str += '<a href="javascript:parent.ctrl.'
		if (flag == '*') {
			str += 'setTocMerge(\'' + dat[2].substr(1) + '\')">'
		} else {
			str += 'setDoc(' + num + ')">'
		}
		if ((tocShow == 3) && (!parent.isN4 || (tocShow < 2)) && (num == currTocId)) {
			str += '<span class="tcvx">'
		} 
		str += dat[1]
		if ((tocShow == 3) && (!parent.isN4 || (tocShow < 2)) && (num == currTocId)) {
			str += '</span>'
		} 
		str += '</a></p>\n'
		if (low) {
			doc.write(str)
			str = ''
		}
	}


	if (tocShow == 3) {  // expando, write visible nodes

		// if expandable (has subs), show image + if closed and - if open; else |.
		// do not show subs if closed
		// start with all closed (default) or all open.
		for (i = 0; i < 10; i++) {
			levList[i] = -1
		}

		for (i = 0; i < (tocItems.length - 1); i++) {
			iDat = tocItems[i]
			iDat[4] = 0
			iLev = iDat[0]
			nDat = tocItems[i + 1]
			nLev = nDat[0]
			levList[iLev] = i
			if (nLev > iLev) {  // sub so this is group
				if (tocSetGroupsOpen) {
					iDat[3] = 1
				} else if (tocSetGroupsClosed) {
					iDat[3] = 5
				} else if (!iDat[3]) {  // never set, use default
					iDat[3] = tcdef
				}
			} else if (nLev < iLev) { // ending sub
				iDat[3] = 9
				iDat[4] = 1
				while (--iLev > nLev) {
					if (levList[iLev] > -1) {
						tocItems[levList[iLev]][4] = 1
						levList[iLev] = -1
					}
				}
			} else { // same level as next, not a group
				iDat[3] = 9
			}
			tocItems[i] = iDat
		}

		i = tocItems.length - 1
		// last item in list
		iDat = tocItems[i]
		iLev = iDat[0]
		levList[iLev] = i
		if (iLev == 1) { // top level
			iDat[3] = 12
			iDat[4] = 0
		} else {
			iDat[3] = 9
			iDat[4] = 1
			while (--iLev > 0) {
				if (levList[iLev] > -1) {
					tocItems[levList[iLev]][4] = 1
					levList[iLev] = -1
				}
			}
		}
		tocItems[i] = iDat
		tocSetGroupsOpen = false
		tocSetGroupsClosed = false

		// when content changed, ensure current node and parents open and
		// prevent closing any ancestor of current topic; alternative is
		// if you close an ancestor of current, to move to that ancestor
		for (itemNum = (currTocId - 1) ; itemNum >= 0 ; itemNum--) {
			iLev = tocItems[itemNum][0]
			if (iLev < currLev) {  // scan back for ancestors
				// mark as open
				tocItems[itemNum][3] = 1
				currLev = iLev
				if (currLev == 1) {
					break
				}
			}
		}

		// do the actual writing of visible items
		vis = true
		nLev = 0
		for (i = 0; i < 10; i++) {
			levList[i] = 13
		}
		for (i = 0; i < tocItems.length; i++) {
			iDat = tocItems[i]
			if (iDat[0] <= nLev) {  // invisible group ended
				vis = true
				nLev = 0
			}
			if (vis) {
				writeOneTocItem(i)
				if (iDat[4] == 1) {       // corner, last of level
					levList[iDat[0]] = 12    // below it is empty
				} else if (iDat[3] < 9) { // beginning of group
					levList[iDat[0]] = 13    // below it is vert line
				}
				if (iDat[3] == 5) {  // invisible group starting
					nLev = iDat[0]
					vis = false
				}
			}
		}

	} else if (tocShow == 2) {  // write everything
		if (parent.isN4) {
			str += '<layer name="tocpoint" bgcolor="white" width="15" height="15" left="0"'
			str += ' top="0" visibility="hide"><p class="tocpt">&gt;&gt;</p></layer>\n'
		}
		for (i = 0; i < tocItems.length; i++) {
			writeOneTocItem(i)
		}

	} else {
		// for short or medium, scan back for sibs and ancestors
		for (itemNum = (currTocId - 1) ; itemNum >= 0 ; itemNum--) {
			itemDat = tocItems[itemNum]
			if (tocShow && prevSibs && (itemDat[0] == itemLev)) {
				itemList[itemList.length] = itemNum
			}
			if (itemDat[0] < currLev) {
				prevSibs = false
				itemList[itemList.length] = itemNum
				currLev = itemDat[0]
				if (currLev == 1) {
					break
				}
			}
		}

		// write out scanned items
		for (i = itemList.length - 1 ; i >= 0 ; i--) {
			writeOneTocItem(itemList[i])
		}

		// write selected item
		writeOneTocItem(currTocId)

		// write following sibs and direct children
		for (itemNum = (currTocId + 1) ; itemNum < tocItems.length ; itemNum++) {
			currLev = tocItems[itemNum][0]
			if (currLev < itemLev) {   // higher-level head
				writeOneTocItem(itemNum)
				break
			}
			if (currLev == itemLev) {  // next head at same level
				if (!tocShow && (ownChildren == false)) {
					continue
				}
				ownChildren = false
			}
			if (!ownChildren && (currLev > itemLev)) {  // nephews
				continue
			}
			if (!tocShow && (currLev > (itemLev + 1))) {  // grandchildren
				continue
			}
			writeOneTocItem(itemNum)
		}
	}
	
	str += (parent.isN4) ? '<a name="x00"></a><p' : '<p id="x00"'
	str += ' class="toc1">&nbsp;</p>\n'
	doc.write(str)
}


// end of toccode.js

