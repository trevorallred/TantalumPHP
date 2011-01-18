(function() {
	var saveQueue = new Object();
var writer = new Ext.data.JsonWriter({});
Tantalum.DefineTableStore = Ext.extend(Ext.data.JsonStore, {
	constructor : function(cfg) {
		cfg = cfg || {};
		Tantalum.DefineTableStore.superclass.constructor.call(this, Ext.apply( {
			url : 'data.php?id=095e0978-9f58-11df-936f-e37ecc873ea2', 				autoDestroy : true,
			batch : true,
			autoSave : false,
			pruneModifiedRecords : true,
			writer : writer,
			root : 'DefineTable',
			idProperty : 'DefineTableTableID',
			fields : [ { name: 'DefineTableTableID'}, { name: 'DefineTableName'}, { name: 'DefineTableDatabaseName'} ]
		}, cfg));
	}
});
var DefineTableStore = new Tantalum.DefineTableStore();
DefineTableStore.addListener('beforewrite', function(store, action, rs, options) {
	saveQueue[action] = [];
	if (Ext.isArray(rs)) {
		saveQueue[action] = rs;
	} else {
		saveQueue[action].push(rs);
	}
	return false;
});
		DefineTableStore.on('load', function(store) {
						DefineTableColumnStore.loadData(DefineTableStore.reader.jsonData);
			if (DefineTableStore.getCount() > 0) {
				DefineTableColumnStore.filter('DefineTableColumnTableID', DefineTableStore.getAt(0).data.DefineTableTableID);
			}
					});
	
		var saveQueue = new Object();
var writer = new Ext.data.JsonWriter({});
Tantalum.DefineTableColumnStore = Ext.extend(Ext.data.JsonStore, {
	constructor : function(cfg) {
		cfg = cfg || {};
		Tantalum.DefineTableColumnStore.superclass.constructor.call(this, Ext.apply( {
							autoDestroy : true,
			batch : true,
			autoSave : false,
			pruneModifiedRecords : true,
			writer : writer,
			root : 'DefineTableColumn',
			idProperty : 'DefineTableColumnName',
			fields : [ { name: 'DefineTableColumnName'}, { name: 'DefineTableColumnID'}, { name: 'DefineTableColumnRequired'}, { name: 'DefineTableColumnDisplayOrder'}, { name: 'DefineTableColumnDbName'}, { name: 'DefineTableColumnTableID'}, { name: 'ColumnColumnType'} ]
		}, cfg));
	}
});
var DefineTableColumnStore = new Tantalum.DefineTableColumnStore();
DefineTableColumnStore.addListener('beforewrite', function(store, action, rs, options) {
	saveQueue[action] = [];
	if (Ext.isArray(rs)) {
		saveQueue[action] = rs;
	} else {
		saveQueue[action].push(rs);
	}
	return false;
});
	DefineTableStore.load();

var page = new Ext.Container({
	currentStore : null,
	height : 300,
	title : 'Define Table',
	layout:'vbox',
	layoutConfig: {
	    align : 'stretch'
	},
	items: [{
    	xtype: 'toolbar',
		items: [{
			iconCls : 'icon-magnifier',
			text: 'Search'
		},{
			iconCls : 'icon-refresh',
			handler: function(b, e) {
				DefineTableStore.reload();
			},
			text: 'Refresh'
		},{
			iconCls : 'icon-disk',
			handler: function(button, event) {
				var savejson = new Object();
				var savejsonModel = new Object();
				saveQueue = new Object();
				DefineTableStore.save();
				for ( var action in saveQueue) {
					if (Ext.isDefined(action)) {
						savejsonModel[action] = [];
						for ( var i = 0; i < saveQueue[action].length; i++) {
							savejsonModel[action].push(saveQueue[action][i].data);
						}
					}
				}
				savejson['DefineTable'] = savejsonModel;
				
				Ext.Ajax.request( {
					url : 'data.php',
					method: 'POST',
					success : function(response, opts) {
						var obj = Ext.decode(response.responseText);
	
						if (obj.success === false) {
							alert("Failed to save data");
							return;
						}
						for ( var action in saveQueue) {
							if (Ext.isDefined(action)) {
								this['on' + Ext.util.Format.capitalize(action) + 'Records'](obj.success, saveQueue[action],
										obj.DefineTable[action]);
							}
						}
					},
					failure : function(response, opts) {
						alert("Failed to save data with status code " + response.status);
					},
					params : {
						action : 'save',
						id : '095e0978-9f58-11df-936f-e37ecc873ea2'
					},
					scope : DefineTableStore,
					jsonData : Ext.util.JSON.encode(savejson)
				});
			},
			text: 'Save'
		},{
			iconCls : 'icon-minus',
			handler: function(b, e) {
				if (this.currentStore === null)
					return;
				DefineTableStore.removeAt(0);
			},
			text: 'Delete'
		},{
			iconCls : 'icon-plus',
			handler: function(b, e) {
				if (this.currentStore === null)
					return;
				DefineTableStore.reload();
			},
			text: 'Add'
		},
		'->', // same as {xtype: 'tbfill'}, // Ext.Toolbar.Fill
		{
			iconCls : 'icon-arrow-left',
			text: 'Previous'
		},{
			iconCls : 'icon-arrow-right',
			iconAlign: 'right',
			text: 'Next'
		}]
	}
	, {
		xtype: 'editorgrid',
		flex:1,
		defaults : {
			sortable : true
		},
		stripeRows : true,
		sm : new Ext.grid.RowSelectionModel( {
			listeners : {
				rowselect : {
					fn : function(sm, index, record) {
						page.currentStore = DefineTableStore;
														DefineTableColumnStore.filter('DefineTableColumnTableID', record.data.DefineTableTableID);
													}
				}
			}
		}),
		viewConfig : {
		},
		columns : [ {
					header: 'Table name',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableName',
					editor : {
						xtype : 'textfield'
					}
				}, {
					header: 'DB name',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableDatabaseName',
					editor : {
						xtype : 'textfield'
					}
				} ],
		refresh : function() {
			this.store.reload();
		},
		store : DefineTableStore
	}
			, {
		xtype: 'editorgrid',
		flex:2,
		defaults : {
			sortable : true
		},
		stripeRows : true,
		sm : new Ext.grid.RowSelectionModel( {
			listeners : {
				rowselect : {
					fn : function(sm, index, record) {
						page.currentStore = DefineTableColumnStore;
												}
				}
			}
		}),
		viewConfig : {
		},
		columns : [ {
					header: 'Name',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableColumnName',
					editor : {
						xtype : 'textfield'
					}
				}, {
					header: 'Required',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableColumnRequired',
					editor : {
						xtype : 'textfield'
					}
				}, {
					header: 'Order',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableColumnDisplayOrder',
					editor : {
						xtype : 'textfield'
					}
				}, {
					header: 'Database',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableColumnDbName',
					editor : {
						xtype : 'textfield'
					}
				}, {
					header: 'TableID',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'DefineTableColumnTableID',
					editor : {
						xtype : 'textfield'
					}
				}, {
					header: 'Type',
					xtype : 'gridcolumn',
					width : 150,
					editable : true,
					sortable : true,
					dataIndex : 'ColumnColumnType',
					editor : {
						xtype : 'textfield'
					}
				} ],
		refresh : function() {
			this.store.reload();
		},
		store : DefineTableColumnStore
	}
			]
});

page.currentStore = DefineTableStore;
return page;
})();
