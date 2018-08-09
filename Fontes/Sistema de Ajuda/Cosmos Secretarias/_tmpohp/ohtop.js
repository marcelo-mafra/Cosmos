// OmniHelp functions for top nav table construction, OHver 0.4
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.

function writeTopNavTable(doc) {
	var str = ""

	function writeHSButton() {
		if (parent.topButtons) {
			str += '<td class="topnav" valign="top">'
			str += '<input type="button" value="'
			str += (parent.showNavLeft) ? HideButTxt : ShowButTxt
			str += '"\n id="topHS" onclick="parent.ctrl.getHS()" alt="'
			str += (parent.showNavLeft) ? HideButTitle : ShowButTitle
			str += '" /></td>\n'
		} else {
			str += '<td class="topnav">'
			str += '<a href="javascript:parent.ctrl.getHS()">'
			if (parent.isNav) {
				str += (parent.showNavLeft) ? HideButTxt : ShowButTxt
			} else {
				str += HideShowTxt
			}
			str += '</a></td>\n'
		}
	}

	function writeButton(name, title) {
		if (parent.topButtons) {
			str += '<input type="button" value="' + name + '"\n'
			str += ' onclick="parent.ctrl.get' + name + '()"'
			str += ' alt="' + title + '" />\n'
		} else {
			str += '<a href="javascript:parent.ctrl.get' + name + '()">'
			str += name + '</a>\n'
		}
	}

	function writeButtonCell(name1, title1, wid, name2, title2) {
		str += '<td class="topnav"'
		if (parent.topButtons) {
			str += ' valign="top"'
		}	
		if (wid > 0) {
			str += ' width="' + wid + '"'
		}
		str += '>'
		writeButton(name1, title1)
		if (name2) {
			str += '&nbsp;'
			writeButton(name2, title2)
		}
		str += '</td>\n'
	}

	str += '<table class="topnav" border="0" height="' + parent.topHigh + '" width="100%"><tr>\n'
	if (parent.topFirst) {
		str += '<td class="topnav" valign="top" width="' + parent.leftWide + '">\n'
		if (parent.topLeft) {
			str += parent.topLeft
		} else {
			str += '<img src="ohlogo.jpg" height="25" width="50" alt="Logo" />&nbsp;OmniHelp &nbsp;'
		}
		str += '</td>\n'
	}
	str += '<form name="ctrlForm" method="post" action="javascript:parent.ctrl.getNext()">\n'
	writeButtonCell(StartButTxt, StartButTitle, 0)
	writeButtonCell(PrevButTxt, PrevButTitle, 0, NextButTxt, NextButTitle)
	if (parent.useBackForward) {
		writeButtonCell(BackButTxt, BackButTitle, 0, FwdButTxt, FwdButTitle)
	}
	if (parent.useHideShow) {
		writeHSButton()
	}
	str += '</form>\n'
	str += '<td class="topnav" valign="top">'
	if (parent.topRight) {
		str += parent.topRight
	} else {
		str += '<img src="' + parent.validImg + '" border="0"\n alt="' + parent.validAlt + '" height="25" width="71" />'
	}
	str += '</td></tr></table>\n'
	doc.write(str)
}


// end of ohtop.js


