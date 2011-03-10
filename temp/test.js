(function() {
	var Tree = Ext.tree;

	var tree = new Tree.TreePanel({
		"flex" : 10,
		dataUrl : 'data.php',
		//rootVisible : false,
		root : {
			expanded : true,
			text : 'Tables'
		}
	});

	var page = new Ext.Panel({
		"xtype" : "panel",
		"title" : "Field Report",
		"layout" : "hbox",
		"layoutConfig" : {
			"align" : "stretch",
			"flex" : 10
		},
		"items" : [ tree ]
	});

	return page;
})();
