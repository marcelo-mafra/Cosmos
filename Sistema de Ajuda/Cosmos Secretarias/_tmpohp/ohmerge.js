// OmniHelp JavaScript project merge functions, OHver 0.1
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.

// functions for merging subprojects

var mergeFile = ""
var mergeProj = ""
var mergeSize = 0
var mergeIndex = -1
var mergingAll = false
var mergePause = 2000
var mergeShortPause = 100

// called when doc loaded in main that is not in tocItems
function checkMerge(baseName) {
	var str = ''
	var len = 0
	var per = baseName.lastIndexOf('.')
	if (per != -1) {
		baseName = baseName.substr(0, per)
	}
	for (var i = 0 ; i < parent.mergeProjects.length ; i++) {
		for (var j = 0 ; j < parent.mergeProjects[i][4].length ; j++) {
			str = parent.mergeProjects[i][4][j]
			len = str.length - 1
			if (((str.charAt(len) == '*')
			  && (str.substr(0, len) == baseName.substr(0, len)))
			 || (baseName == str)) {
				str = MergeFileStartMsg + parent.mergeProjects[i][0] + MergeFileEndMsg
				if (confirm(str)) {
					mergeFile = baseName
					mergeIndex = i
					setTimeout("doMerge()", mergeShortPause)
					merging = true
					return true
				} else {
					return false
				}
			}
		}
	}
	return false
}


// called by clicking on a merge Toc item
function setTocMerge(subName) {
	mergeFile = ''
	var str = ''
	for (var i = 0 ; i < parent.mergeProjects.length ; i++) {
		if (subName == parent.mergeProjects[i][0]) {
			str = MergeProjStartMsg + subName + MergeProjEndMsg
			if (confirm(str)) {
				currTocId = parent.mergeProjects[i][3]
				mergeIndex = i
				setTimeout("doMerge()", mergeShortPause)
				//currTocId = mergePos
			}
			return
		}
	}
}

// called when setting made to merge everything at init load
function mergeAll() {
	// process all parent.mergeProjects entries in order,
	// including those added to end during traversal
	// have each one, when ending, start the next one
	mergeIndex = -1
	mergingAll = true
	window.status = MergeAllMsg
	setTimeout("setNextMerge()", mergePause)
}

function setNextMerge() {
	mergeIndex++
	if (mergeIndex >= parent.mergeProjects.length) {
		mergingAll = false
		mergedAll = true
		mergePos = -1
		window.status = MergeDoneMsg
		setTimeout("setMergeEnd()", mergePause)
	} else {
		var str = MergeNextMsg + parent.mergeProjects[mergeIndex][0]
		window.status = str
		setTimeout("doMerge()", mergePause)
	}
}

// functions for doing the merge

function doMerge() {
	var projDat = parent.mergeProjects[mergeIndex]
	mergeProj = projDat[0]
	mergePos = projDat[3]

	var doc = parent.merge.document
	var jsStr = js1Str

	// ensure not already loaded, then mark as loaded
	// so that if we get an error, we don't try again
	if (projDat[1] != 0) {
		if (mergingAll) {
			setTimeout("setNextMerge()", mergeShortPause)
		}
		return
	}
	projDat[1] = 1
	merging = true
	var str = MergingProjStartMsg + mergeProj + MergingProjEndMsg
	window.status = str
	// write temp cookie to tell new doc where to get dats
	document.cookie = "mergeProj=" + mergeProj
	// load file into merge frame (0-row frame below ctrl)
	// that loads the js .oh* files from the subproject
	parent.merge.location.href = "ohmerged.htm"
}


// called from query doc in parent.merge
function mergeLoaded(doc) {
	if (!merging) {
		return
	}
	if (!parent.merge.tocItems || (parent.merge.tocItems.length == 0)) {
		// abject failure, empty or missing list, give up now
		if (mergingAll) {
			window.status = NoMergeMsg
			mergingAll = false
		}
		return
	}

	// create new arrays by merging each of the current *Items
	// with those in merge, then assign back to current names.  
	window.status = MergeTocMsg
	mergeSize = parent.merge.tocItems.length
	parent.mergeProjects[mergeIndex][2] = mergeSize
	tocItems = mergeContentsList(tocItems, parent.merge.tocItems)

	// Fixup all toc ref nums in both projects while merging.
	// old nums after mergePos only are + mergeSize - 1
	// new nums are all + mergePos
	// when merging nums, scan oldnum list until > mergePos,
	// then insert entire newnum list, then rest of oldnums

	// merge of index requires compare of first-level items
	// if match, compare second levels, etc., and merge refs,
	// must handle any number of levels, so use recursion
	if (includeIdx) {
		window.status = MergeIdxMsg
		idxItems = mergeIdxList(idxItems, parent.merge.idxItems)
		firstIdxUse = true
	}

	// merge of search is simple compare of term and merge of refs when
	// they match, will be harder if we try to coalesce s, ed, ing, etc.
	if (includeFts) {
		window.status = MergeFtsMsg
		ftsItems = mergeSimpleItemList(ftsItems, parent.merge.ftsItems)
	}

	// merge of rel is essentially same as for search
	if (includeRel) {
		window.status = MergeRelMsg
		relItems = mergeSimpleItemList(relItems, parent.merge.relItems)
	}

	// merge of csh is simple interleave
	window.status = MergeCshMsg
	cshItems = mergeSimpleTextList(cshItems, parent.merge.cshItems)

	// add new file's merge list to ours, eliminating any entry for us
	mergeMergeList(parent.mergeProjects, parent.merge.mergeProjects)

	// fix up any other globals
	if (!mergingAll && (currTocId > mergePos)) {
		currTocId = currTocId + mergeSize - 1
	}
	mergedOffset += mergeSize - 1
	mergeDone = true
	merging = false

	if (mergingAll) {
		setTimeout("setNextMerge()", mergeShortPause)
	}
	else {
		setMergeEnd()
	}
}


function setMergeEnd() {
	window.status = MergeDoneMsg
	firstLoad = true
	lastTocId = -1
	if (includeToc) {
		lastTocShow = -1
		lastDocTocShow = -1
	}
	if (includeIdx) {
		firstIdxUse = true
	}
	if (mergedAll) {
		setTimeout("ctrlLoaded()", mergeShortPause)
	} else {
		setTimeout("mainChanged()", mergeShortPause)
	}
}


function mergeContentsList(oItems, aItems) {
	var newToc = new Array(oItems.length + mergeSize - 1)
	var newPos = 0
	var oldPos = 0
	var addPos = 0
	for (newPos = 0 ; newPos < newToc.length ; newPos++ ) {
		if (newPos < mergePos) {
			newToc[newPos] = oItems[oldPos]
			oldPos++
		} else if (addPos < mergeSize) {
			newToc[newPos] = aItems[addPos]
			newToc[newPos][3] = mergeIndex + 1
			addPos++
		  // check for other merges to prevent circular refs
			if (newToc[newPos][2].charAt(0) == '*') {
				if (newToc[newPos][2].substr(1) == parent.projName) {
					// mark deleted, removal would throw off numbering
					newToc[newPos][2] = '!'
				}
			}
		} else if (oldPos < oItems.length) {
			// discard merge toc entry for file being merged
			if (oldPos == mergePos) {
				oldPos++
			}
			newToc[newPos] = oItems[oldPos]
			oldPos++
		}
	}
	return newToc
}

function mergeIdxList(oItems, aItems) {
	// retain positioning across recursive invocations
	var	nItems = new Array()
	var nPos = 0
	var oPos = 0
	var aPos = 0
	var oLen = oItems.length
	var aLen = aItems.length

	function mergeIdxLevel(idxLevel) {
		var oVal = 0
		var aVal = 0
		var oStr = ''
		var aStr = ''
		var oRef = false
		var aRef = false

		while (((oPos < oLen)
				 && (oItems[oPos][0] > idxLevel))
				|| ((aPos < aLen)
				 && (aItems[aPos][0] > idxLevel))) {
			if (oPos < oLen) {
				oStr = oItems[oPos][1].toLowerCase()
			}
			if (aPos < aLen) {
				aStr = aItems[aPos][1].toLowerCase()
			}

			if ((aPos >= aLen)
			 || (aItems[aPos][0] <= idxLevel)
			 || ((oPos < oLen)
				&& (oStr < aStr))) {
				nItems[nPos] = oItems[oPos]
				nPos++
				oPos++
				while ((oPos < oLen)
						&& (oItems[oPos][0] > (idxLevel + 1))) {
					nItems[nPos] = oItems[oPos]
					if ((oItems[oPos].length > 2)
					 && (oItems[oPos][1].charAt(0) != '#')) {
						nItems[nPos][2] = fixOldNumRef(oItems[oPos][2])
					}
					nPos++
					oPos++
				}
			} else if ((oPos >= oLen)
							|| (oItems[oPos][0] <= idxLevel)
							|| ((aPos < aLen)
							 && (oStr > aStr))) {
				nItems[nPos] = aItems[aPos]
				nPos++
				aPos++
				while ((aPos < aLen)
						&& (aItems[aPos][0] > (idxLevel + 1))) {
					nItems[nPos] = aItems[aPos]
					if ((aItems[aPos].length > 2)
					 && (aItems[aPos][1].charAt(0) != '#')) {
						nItems[nPos][2] = fixAddNumRef(aItems[aPos][2])
					}
					nPos++
					aPos++
				}
			} else if ((oPos < oLen)
							&& (aPos < aLen)
							&& (oStr == aStr)) {
				// match, so merge num ref items if any, then go through sublevel items
				nItems[nPos] = oItems[oPos]
				nPos++
				oPos++
				aPos++
				oRef = (oPos < oLen) && (oItems[oPos].length > 2) && (oItems[oPos][1].charAt(0) != '#')
				aRef = (aPos < aLen) && (aItems[aPos].length > 2) && (aItems[aPos][1].charAt(0) != '#')
				while (oRef || aRef) {
					nItems[nPos] = new Array()
					if (oRef) {
						oVal = fixOldNumRef(oItems[oPos][2])
					}
					if (aRef) {
						aVal = fixAddNumRef(aItems[aPos][2])
					}
					if (oRef && aRef) {
						if (oVal <= aVal) {
							nItems[nPos][0] = oItems[oPos][0]
							nItems[nPos][1] = oItems[oPos][1]
							nItems[nPos][2] = oVal
							oPos++
							if (oVal == aVal) {
								aPos++
							}
						} else {
							nItems[nPos][0] = aItems[aPos][0]
							nItems[nPos][1] = aItems[aPos][1]
							nItems[nPos][2] = aVal
							aPos++
						}
					} else if (oRef) {
						nItems[nPos][0] = oItems[oPos][0]
						nItems[nPos][1] = oItems[oPos][1]
						nItems[nPos][2] = oVal
						oPos++
					} else {
						nItems[nPos][0] = aItems[aPos][0]
						nItems[nPos][1] = aItems[aPos][1]
						nItems[nPos][2] = aVal
						aPos++
					}
					nPos++
					oRef = (oPos < oLen) && (oItems[oPos].length > 2) && (oItems[oPos][1].charAt(0) != '#')
					aRef = (aPos < aLen) && (aItems[aPos].length > 2) && (aItems[aPos][1].charAt(0) != '#')
				}
				mergeIdxLevel(idxLevel + 1)
			}
		}
	}

	mergeIdxLevel(0)
	return nItems
}

// used for ftsItems and relItems 
function mergeSimpleItemList(oldList, addList) {
	// merges lists consisting of a string identifier and a num ref list
	var newList = new Array()
	var newPos = 0
	var oldPos = 0
	var addPos = 0
	while ((oldPos < oldList.length) && (addPos < addList.length)) {
		if (oldList[oldPos][0] < addList[addPos][0]) {
			newList[newPos] = new Array()
			newList[newPos][0] = oldList[oldPos][0]
			newList[newPos][1] = fixOldNumRefList(oldList[oldPos][1])
			newPos++
			oldPos++
		} else if (oldList[oldPos][0] > addList[addPos][0]) {
			newList[newPos] = new Array()
			newList[newPos][0] = addList[addPos][0]
			newList[newPos][1] = fixAddNumRefList(addList[addPos][1])
			newPos++
			addPos++
		} else {
			newList[newPos] = new Array()
			newList[newPos][0] = oldList[oldPos][0]
			newList[newPos][1] = mergeRefLists(oldList[oldPos][1], addList[addPos][1])
			newPos++
			oldPos++
			addPos++
		}
	}
	while (oldPos < oldList.length) {
		newList[newPos] = new Array()
		newList[newPos][0] = oldList[oldPos][0]
		newList[newPos][1] = fixOldNumRefList(oldList[oldPos][1])
		oldPos++
		newPos++
	}
	while (addPos < addList.length) {
		newList[newPos] = new Array()
		newList[newPos][0] = addList[addPos][0]
		newList[newPos][1] = fixAddNumRefList(addList[addPos][1])
		addPos++
		newPos++
	}
	return newList
}

// used for cshItems 
function mergeSimpleTextList(oldList, addList) {
	// merges lists consisting of a string identifier and whatever
	var newList = new Array()
	var newPos = 0
	var oldPos = 0
	var addPos = 0
	while ((oldPos < oldList.length) && (addPos < addList.length)) {
		if (oldList[oldPos][0] < addList[addPos][0]) {
			newList[newPos] = oldList[oldPos]
			newPos++
			oldPos++
		} else if (oldList[oldPos][0] > addList[addPos][0]) {
			newList[newPos] = addList[addPos]
			newPos++
			addPos++
		} else {
			// match, can't merge so keep old one and discard added item
			newList[newPos] = oldList[oldPos]
			newPos++
			oldPos++
			addPos++
		}
	}
	while (oldPos < oldList.length) {
		newList[newPos] = oldList[oldPos]
		oldPos++
		newPos++
	}
	while (addPos < addList.length) {
		newList[newPos] = addList[addPos]
		addPos++
		newPos++
	}
	return newList
}

function mergeRefLists(oldList, addList) {
	var newList = new Array()
	var	nPos = 0
	var oPos = 0
	var	aPos = 0
	var oVal = 0
	var aVal = 0
	while ((oPos < oldList.length) && (aPos < addList.length)) {
		oVal = fixOldNumRef(oldList[oPos])
		aVal = fixAddNumRef(addList[aPos])
		if (oVal < aVal) {
			newList[nPos] = oVal
			nPos++
			oPos++
		} else if (oVal > aVal) {
			newList[nPos] = aVal
			nPos++
			aPos++
		} else {
			newList[nPos] = oVal
			nPos++
			oPos++
			aPos++
		}
	}
	while (oPos < oldList.length) {
		newList[nPos] = fixOldNumRef(oldList[oPos])
		nPos++
		oPos++
	}
	while (aPos < addList.length) {
		newList[nPos] = fixAddNumRef(addList[aPos])
		nPos++
		aPos++
	}
	return newList
}


function mergeMergeList(oldList, addList) {
	var oldPos = 0
	var addPos = 0
	var pname = ''
	var i = 0

	for (oldPos = 0 ; oldPos < oldList.length ; oldPos++) {
		oldList[oldPos][3] = fixOldNumRef(oldList[oldPos][3])
	}
	for (addPos = 0 ; addPos < addList.length ; addPos++) {
		pname = addList[addPos][0]
		for (i = 0 ; i < oldPos ; i++) {
			if (pname == oldList[i][0]) {
				break
			} 
		}
		if ((i == oldPos) && (pname != parent.projName)) {
			oldList[oldPos] = new Array()
			oldList[oldPos][0] = addList[addPos][0]
			oldList[oldPos][1] = addList[addPos][1]
			oldList[oldPos][2] = addList[addPos][2]
			oldList[oldPos][3] = fixAddNumRef(addList[addPos][3])
			oldList[oldPos][4] = addList[addPos][4]
			oldPos++
		}
	}
}


// fixup functions for toc ref numbers
function fixOldNumRef(val) {
	// old nums after mergePos only are + mergeSize - 1
	return ((val > mergePos) ? (val + mergeSize - 1) : val)
}

function fixAddNumRef(val) {
	// new nums are all + mergePos
	return (val + mergePos)
}

function fixOldNumRefList(oldList) {
	var newList = new Array()
	var n = 0
	for (var i = 0 ; i < oldList.length ; i++) {
		newList[n] = fixOldNumRef(oldList[i])
		n++
	}
	return newList
}

function fixAddNumRefList(addList) {
	var newList = new Array()
	var n = 0
	for (var i = 0 ; i < addList.length ; i++) {
		newList[n] = fixAddNumRef(addList[i])
		n++
	}
	return newList
}

// end of ohmerge.js

