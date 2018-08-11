
// OmniHelp JS code referenced in head of all content files, OHver 0.1
// Copyright (c) 2002 by Jeremy H. Griffith.  All rights reserved.

if (opener) {
	opener.parent.mainCSS(document)
} else if (parent) {
	parent.mainCSS(document)
	parent.ctrl.mainChanged()
}

function sec(item, wide, high, param) {
	if (!opener) {
		parent.ctrl.secWin(item, wide, high, param)
	}
}

function alink(str) {
	if (parent) {
		parent.ctrl.alink(str)
	}
}

function klink(str) {
	if (parent) {
		parent.ctrl.klink(str)
	}
}

// end of ohmain.js
