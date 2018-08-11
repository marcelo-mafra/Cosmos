
// OmniHelp functions for search, OHver 0.5
// Copyright (c) 2004 by Jeremy H. Griffith.  All rights reserved.

var foundSearch = new Array()
var foundLastSearch = false
var didSearch = false
var searchDone = false
var lastNewSearch = ""
var lastBoolSearch = ""
var lastDocBoolSearch = ""


function useSearch() {
	currNavCtrl = 2
	writeSearchCtrlFile()
	writeSearchDocFile(false)
	setCookies()
}


function writeSearchCtrlFile() {
	if ((boolSearch == lastBoolSearch) && (lastNavCtrl == 2)) {
		return
	}
	lastNavCtrl = 2
	lastBoolSearch = boolSearch
	var doc = parent.navctrl.document
	doc.open()  //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Nav Control: Search, OHver 0.4</title>\n')
	parent.ctrlCSS(doc)
	doc.write('</head>\n<body class="ctrl"><table class="nav">\n')
	writeSearchCtrl(doc)
	doc.write('\n</table></body></html>')
	doc.close()
}

function writeSearchCtrl(doc) {
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
	str += '<th class="navx" width="' + widthFtsCell + '">' + SearchButTxt + '</th>\n'
	if (includeRel) {
		ctrlCount++
		str += '<th class="nav" width="' + widthRelCell + '"><a href="javascript:parent.ctrl.useRel()">' + RelatedButTxt + '</a></th>\n'
	}
	str += '</tr><form name="navSearch" method="post" action="javascript: void parent.ctrl.doSearch()">\n'
	str += '<tr><td class="navxsmall" colspan="4">&nbsp;\n'
	str += '<input type="text" name="searchstring"'
	if (lastSearch.length > 0) {
		str += ' value="' + lastSearch + '"'
	}
	str += ' size="21" />&nbsp;&nbsp;\n'
	str += '<input type="submit" value="' + FindButTxt + '" onClick="javascript:void parent.ctrl.doSearch(); return false" />\n'
	str += '</td></tr><tr><td class="navxxsmall" colspan="4">\n'
	str += '<input type="button" value="' + ListButTxt + '" onClick="javascript:parent.ctrl.doList()" />\n'
	str += '<input type="radio" name="bools" value="new"'
	if (boolSearch == "new") {
		str += 'checked="checked" '
	}
	str += ' onclick="javascript:parent.ctrl.setSearch(\'new\')" />' + NewButTxt + '\n'
	str += '<input type="radio" name="bools" value="and"'
	if (boolSearch == "and") {
		str += 'checked="checked" '
	}
	str += ' onclick="javascript:parent.ctrl.setSearch(\'and\')" />' + ANDButTxt + '\n'
	str += '<input type="radio" name="bools" value="or"'
	if (boolSearch == "or") {
		str += 'checked="checked" '
	}
	str += ' onclick="javascript:parent.ctrl.setSearch(\'or\')" />' + ORButTxt + '\n'
	str += '<input type="radio" name="bools" value="not"'
	if (boolSearch == "not") {
		str += 'checked="checked" '
	}
	str += ' onclick="javascript:parent.ctrl.setSearch(\'not\')" />' + NOTButTxt + '\n'
	str += '</td></tr></form>\n'
	doc.write(str)
}

function setSearch(str) {
	boolSearch = str
	setCookies()
}


function doList() {
	writeSearchDocFile(true)
	return false
}


function doSearch() {
	lastSearch = parent.navctrl.document.navSearch.searchstring.value
	didSearch = true
	searchDone = false
	writeSearchDocFile(false)
	setCookies()
}


function writeSearchDocFile(list) {
	lastNavDoc = 2
	var doc = parent.nav.document
	doc.open()  //'text/html', "replace")
	doc.write('<html><head><title>OmniHelp Search File, OHver 0.1</title>\n')
	parent.ctrlCSS(doc)
	doc.write('</head>\n<body class="nav">\n')
	if (ftsItems.length == 0) {
		doc.write('<p class="fts">', NoSearchMsg, '</p>')
	} else if (list) {
		writeSearchTermList(doc)
	} else if (didSearch) {
		writeSearchItems(doc)
	} else {
		doc.write('<p class="fts">', EnterSearchMsg, '</p>')
	}
	doc.write('\n</body></html>')
	doc.close()

	setTimeout("parent.nav.scrollTo(0,0)", 2000)
}


function writeSearchItems(doc) {
	var itemNum = 0
	var searchStr = ''
	var wordDat = new Array()
	var searchWord = new Array()
	var searchWordFound = false
	var searchWordPos = 0
	var regEx = false
	var searchEx = new RegExp('.*')
	var searchList = new Array()
	var i = 0

	function mergeRefs(oRef, aRef) {
		var nRef = new Array()
		var oPos = 0
		var aPos = 0
		var nPos = 0
		var oLen = searchWord.length
		var aLen = aRef.length

		while ((oPos < oLen) || (aPos < aLen)) {
			if ((oPos < oLen) && (aPos < aLen)) {
				if (oRef[oPos] == aRef[aPos]) {
					nRef[nPos] = oRef[oPos]
					oPos++
					aPos++
				} else if (oRef[oPos] < aRef[aPos]) {
					nRef[nPos] = oRef[oPos]
					oPos++
				} else {
					nRef[nPos] = aRef[aPos]
					aPos++
				}
			} else if (aPos >= aLen) {
				nRef[nPos] = oRef[oPos]
				oPos++
			} else {
				nRef[nPos] = aRef[aPos]
				aPos++
			}
			nPos++
		}
		return nRef
	}


	if (searchDone) {
		// just redisplay last results if any
		if (!foundLastSearch) {
			writeSearchFailed(doc)
		} else {
			foundLastSearch = false
			for (itemNum = 0 ; itemNum < tocItems.length ; itemNum++) {
				if (foundSearch[itemNum]) {
					writeOneSearchItem(doc, itemNum)
				}
			}
		}
		return
	}

	foundLastSearch = false
	searchDone = true

	// find array for word(s) in searchWords[]
	var fullSearchStr = lastSearch.toLowerCase()
	var searchArr = fullSearchStr.split(" ");
	var searchNum = 0;
	var searchType = boolSearch

	for (searchNum = 0; searchNum < searchArr.length; searchNum++) {
		searchStr = searchArr[searchNum]
		if (searchStr.length == 0) {
			continue
		}
		searchWordFound = false
		searchWordPos = 0
		regEx = (searchStr.charAt(0) == '/')

		if (regEx) {
			var term = searchStr.lastIndexOf('/')
			if (term > 1) {
				searchEx = new RegExp(searchStr.substring(1, term))
			} else {
				searchEx = new RegExp(searchStr.substring(1))
			}
			for (itemNum = 0 ; itemNum < ftsItems.length ; itemNum++) {
				wordDat = ftsItems[itemNum]
				if (wordDat[0].match(searchEx)) {
					searchWord = mergeRefs(searchWord, wordDat[1])
					searchWordFound = true
				}
			}
		} else {
			for (itemNum = 0 ; itemNum < ftsItems.length ; itemNum++) {
				wordDat = ftsItems[itemNum]
				if (searchStr == wordDat[0]) {
					searchWord = wordDat[1]
					searchWordFound = true
					break
				}
			}
		}

		if (!lastNewSearch && (searchType != "new")) {
			searchType = "new"
			parent.navctrl.document.navSearch.bools[0].checked = true
		}

		if (searchType == "new") {
			lastNewSearch = '"' + searchStr + '"'
		} else {
			lastNewSearch += ' '
			lastNewSearch += (searchType == "and") ? ANDButTxt : ((searchType == "or") ? ORButTxt : NOTButTxt)
			lastNewSearch += ' "' + searchStr + '"'
		}

		if (searchWordFound) {
			if (searchType == "new") {
				for (itemNum = 0 ; itemNum < tocItems.length ; itemNum++) {
					foundSearch[itemNum] = false
					if ((searchWordPos < searchWord.length) && (itemNum == searchWord[searchWordPos])) {
						if (checkCondToc(itemNum)) {
							foundSearch[itemNum] = true
						}
						searchWordPos++
					}						
				}
			} else if (searchType == "and") {
				for (itemNum = 0 ; itemNum < tocItems.length ; itemNum++) {
					if (foundSearch[itemNum]) {
						while ((searchWordPos < searchWord.length) && (itemNum > searchWord[searchWordPos])) {
							searchWordPos++
						}
						if ((searchWordPos >= searchWord.length) || (itemNum < searchWord[searchWordPos])) {
							foundSearch[itemNum] = false
						} else {
							searchWordPos++
						}
					}
				}
			} else if (searchType == "or") {
				for (itemNum = 0 ; itemNum < tocItems.length ; itemNum++) {
					if (foundSearch[itemNum] == false) {
						if ((itemNum == searchWord[searchWordPos]) && checkCondToc(itemNum)) {
							foundSearch[itemNum] = true
							searchWordPos++
						}
					}
				}
			} else if (searchType == "not") {
				for (itemNum = 0 ; itemNum < tocItems.length ; itemNum++) {
					if (foundSearch[itemNum]) {
						while ((searchWordPos < searchWord.length) && (itemNum > searchWord[searchWordPos])) {
							searchWordPos++
						}
						if ((searchWordPos < searchWord.length) && (itemNum == searchWord[searchWordPos])) {
							foundSearch[itemNum] = false
							searchWordPos++
						}
					}
				}
			}
		}

		searchType = "and"
	}

	for (itemNum = 0 ; itemNum < tocItems.length ; itemNum++) {
		if (foundSearch[itemNum] == true) {
			writeOneSearchItem(doc, itemNum)
		}
	}

	if (!foundLastSearch) {
		writeSearchFailed(doc)
	}
}


function writeOneSearchItem(doc, num) {
	if (!foundLastSearch) {
		doc.write('<p class="fts">', SearchResultsMsg)
		doc.write(lastNewSearch)
		doc.writeln(':<br /></p>')
		foundLastSearch = true
	}

	var str = '<p class="fts"><a href="javascript:parent.ctrl.setDoc(' + num + ')">'
	str += tocItems[num][1] + '</a></p>'
	doc.write(str)
}

function writeSearchFailed(doc) {
	if (boolSearch != "new") {
		boolSearch = "new"
		parent.navctrl.document.navSearch.bools[0].checked = true
	}
	doc.write('<p class="fts">', NoSearchResultsMsg)
	doc.write(lastNewSearch)
	doc.writeln('.</p>')
}

function writeSearchTermList(doc) {
	var itemNum = 0
	var wordDat = new Array()
	var str

	doc.write('<p class="fts">', SearchTermsMsg, '<br>')
	for (itemNum = 0 ; itemNum < ftsItems.length ; itemNum++) {
		wordDat = ftsItems[itemNum]
		str = '<br><a href="javascript: void parent.ctrl.setTerm(\''
		str += wordDat[0] + '\')">'
		str += wordDat[0] + ' (' + wordDat[1].length + ')</a>\n'
		doc.write(str)
	}
	doc.write('</p>')
}

function setTerm(link) {
	lastSearch = link
	parent.navctrl.document.navSearch.searchstring.value = lastSearch
	setCookies()
}


// end of srchcode.js

