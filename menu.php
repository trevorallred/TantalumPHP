<?php
require_once("util/startup.php");
?>
Ext.ns('Tantalum');

function onMenuClick(item) {
	Ext.Ajax.request( {
		url : item.url,
		success : function(xhr) {
			var newComponent = eval(xhr.responseText);
			var contentPanel = Ext.ComponentMgr.get('contentPanel');
			contentPanel.add(newComponent);
			contentPanel.add(newComponent);
			contentPanel.setActiveTab(newComponent);
		},
		failure : function() {
			Ext.Msg.alert("Grid create failed", "Server communication failure");
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
		text : 'Test',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'temp/test2.js'
	}, {
		xtype : 'button',
		text : 'List Tables',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'page.php?id=e88065f5-9f57-11df-936f-e37ecc873ea2'
	}, {
		xtype : 'button',
		text : 'Define Table',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'page.php?id=e88068d5-9f57-11df-936f-e37ecc873ea2'
	}, {
		xtype : 'button',
		text : 'List Pages',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'page.php?id=e8806a9d-9f57-11df-936f-e37ecc873ea2'
	}, {
		xtype : 'button',
		text : 'DefineTables3',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'js/Tantalum.DefineTable3.js'
	}, {
		xtype : 'button',
		text : 'DefineTables2',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'js/Tantalum.DefineTable2.js'
	}, {
		xtype : 'button',
		text : 'ManageTables',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'js/Tantalum.ManageTables.js'
	} ],
	initComponent : function() {
		Tantalum.Menu.superclass.initComponent.call(this);
	}
});

Ext.reg('tantalum-menu', Tantalum.Menu);
