function alertBox(str)
{
	var overlay = document.createElement("div");
	overlay.setAttribute("id", "overlay");
	
	var win = document.createElement("div");
	win.setAttribute("id", "alertW");
	
	var innerwin = document.createElement("div");
	innerwin.setAttribute("id", "alertIW");
	
	var h = document.createElement("H2");
	var content = document.createTextNode(str);
	
	h.appendChild(content);
	innerwin.appendChild(h);
	win.appendChild(innerwin);
	
	document.body.appendChild(overlay);
    document.body.appendChild(win);
	win.onclick = alertRestore;
}
function alertRestore()
{
	 document.body.removeChild(document.getElementById("overlay"));
	 document.body.removeChild(document.getElementById("alertW"));
}