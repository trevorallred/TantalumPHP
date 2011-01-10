<?php
require_once("util/startup.php");

try {
} catch (Exception $e) {
	die($e->getMessage());
}
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

function refresh(item) {
	var currentPanel = Ext.ComponentMgr.get('contentPanel').getActiveTab();
	var currentFunction = currentPanel.refresh;
	if (currentFunction === undefined)
		return;
	currentFunction.call(currentPanel);
}

function savePage(item) {
	var currentPanel = Ext.ComponentMgr.get('contentPanel').getActiveTab();
	var currentFunction = currentPanel.save;
	if (currentFunction === undefined)
		return;
	currentFunction.call(currentPanel);
}

function insertRecord(item) {
	var currentPanel = Ext.ComponentMgr.get('contentPanel').getActiveTab();
	var currentFunction = currentPanel.insertRecord;
	if (currentFunction === undefined)
		return;
	currentFunction.call(currentPanel);
}

function deleteRecord(item) {
	var currentPanel = Ext.ComponentMgr.get('contentPanel').getActiveTab();
	var currentFunction = currentPanel.deleteRecord;
	if (currentFunction === undefined)
		return;
	currentFunction.call(currentPanel);
}

Tantalum.Menu = Ext.extend(Ext.Panel, {
	region : 'north',
	bbar : [ {
		xtype : 'tbtext',
		text : '<b>Tantalum</b>'
	}, {
		xtype : 'tbseparator'
	}, {
		text : 'Edit',
		menu : [ {
			text : 'Refresh',
			handler : refresh,
			iconCls : 'icon-refresh'
		}, {
			text : 'Save (Ctrl+Shift+S)',
			handler : savePage,
			iconCls : 'icon-disk'
		}, {
			text : 'Insert (Ctrl+Shift+I)',
			handler : insertRecord,
			iconCls : 'icon-plus'
		}, {
			text : 'Delete (Ctrl+Shift+D)',
			handler : deleteRecord,
			iconCls : 'icon-minus'
		} ]
	}, {
		xtype : 'button',
		text : 'Test',
		handler : onMenuClick,
		iconCls : 'icon-form-edit',
		url : 'js/Tantalum.Generic.js'
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
