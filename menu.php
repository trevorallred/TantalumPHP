<?php
require_once("util/startup.php");
?>
Ext.ns('Tantalum');

function onMenuClick(item) {
	Ext.Ajax.request( {
		url : 'page.php?id='+item.pageID,
		success : function(xhr) {
			var newComponent = eval(xhr.responseText);
			newComponent.filter("DefineTableTableID = 'fce924a9-9f57-11df-936f-e37ecc873ea2'");
			var contentPanel = Ext.ComponentMgr.get('contentPanel');
			contentPanel.add(newComponent);
			contentPanel.setActiveTab(newComponent);
		},
		failure : function() {
			Ext.Msg.alert("Page Error", "Server communication failure");
		}
	});
}

Tantalum.Menu = Ext.extend(Ext.Panel, {
	region : 'north',
	bbar : [ {
		xtype : 'tbtext',
		text : '<b>Tantalum</b>'
	}, {
		xtype : 'tbseparator'
	}, {
		xtype : 'button',
		text : 'List Tables',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		pageID : 'e88065f5-9f57-11df-936f-e37ecc873ea2'
	}, {
		xtype : 'button',
		text : 'Define Table',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		pageID : 'e88068d5-9f57-11df-936f-e37ecc873ea2'
	}, {
		xtype : 'button',
		text : 'List Pages',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		pageID : 'e8806c5f-9f57-11df-936f-e37ecc873ea2'
	}, {
		xtype : 'button',
		text : 'List Models',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		pageID : 'e8806a9d-9f57-11df-936f-e37ecc873ea2'
	} ],
	initComponent : function() {
		Tantalum.Menu.superclass.initComponent.call(this);
	}
});

Ext.reg('tantalum-menu', Tantalum.Menu);
