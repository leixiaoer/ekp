<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

{$
	<div class="lui_matrix_card_item_inner">
        <!-- 状态 -->
        $}
        if(grid['isAvailable'] == 'true') {
        {$
        <span class="card_status status_start">${lfn:message('sys-organization:sys.org.available.true')}</span>
        $}
        } else {
        {$
        <span class="card_status status_disable">${lfn:message('sys-organization:sys.org.available.false')}</span>
        $}
        }
        {$
        <h4 class="card_title">
        $}
       	if(grid['edit_auth'] == 'true') {
       	{$
        	<input type="checkbox" data-lui-mark="table.content.checkbox" name="List_Selected" value="{%grid['fdId']%}">
        $}
        }
        {$
        	<a data-href="<c:url value="/sys/organization/sys_org_matrix/sysOrgMatrix.do"/>?method=view&fdId={%grid['fdId']%}" target="_blank" onclick="Com_OpenNewWindow(this)" title="{%grid['fdName']%}">{%grid['fdName']%}</a>
        </h4>
        <p class="card_summary">{%grid['fdDesc']%}{%grid['matrixType']%}</p>
        <p class="card_info"><span class="card_info_item"><em>${lfn:message('sys-organization:sysOrgMatrix.fdCategory')}：</em>{%grid['fdGroupCate']%}</span></p>
        <!-- 操作条 -->
        $}
       	if(grid['edit_auth'] == 'true') {
       	{$
        <p class="card_tip">
            <span class="card_tip_item" onclick="edit('{%grid['fdId']%}', 0);">
                <i class="card_icon icon_baseinfo"></i>
                <span class="card_tip_txt"><i class="card_tip_arrow"></i>
                <i class="card_tip_txt_inner">${lfn:message('sys-organization:sysOrgMatrix.base')}</i></span>
            </span>
            <span class="card_tip_item" onclick="edit('{%grid['fdId']%}', 1);">
                <i class="card_icon icon_field"></i>
                <span class="card_tip_txt"><i class="card_tip_arrow"></i>
                <i class="card_tip_txt_inner">${lfn:message('sys-organization:sysOrgMatrix.field')}</i></span>
            </span>
            <span class="card_tip_item" onclick="edit('{%grid['fdId']%}', 2);">
                <i class="card_icon icon_data"></i>
                <span class="card_tip_txt"><i class="card_tip_arrow"></i>
                <i class="card_tip_txt_inner">${lfn:message('sys-organization:sysOrgMatrix.fdContent')}</i></span>
            </span>
             $}
        	if(grid['isAvailable'] == 'true') {
        	{$
            <span class="card_tip_item" onclick="invalidated('{%grid['fdId']%}', false);">
                <i class="card_icon icon_disable"></i>
                <span class="card_tip_txt"><i class="card_tip_arrow"></i>
                <i class="card_tip_txt_inner">${lfn:message('sys-organization:sys.org.available.false')}</i></span>
            </span>
            $}
        	} else {
        	{$
        	<span class="card_tip_item" onclick="invalidated('{%grid['fdId']%}', true);">
                <i class="card_icon icon_start"></i>
                <span class="card_tip_txt"><i class="card_tip_arrow"></i>
                <i class="card_tip_txt_inner">${lfn:message('sys-organization:sys.org.available.true')}</i></span>
            </span>
        	$}
        	}
        	{$
        </p>
        $}
       	} else 
       	/*分组维护者*/
       	if(grid['data_cate_auth'] == 'true') {
       	{$
        <p class="card_tip">
            <span class="card_tip_item" style="width: 100%;" onclick="dataCate('{%grid['fdId']%}');">
                <i class="card_icon icon_baseinfo"></i>
                <span class="card_tip_txt"><i class="card_tip_arrow"></i>
                <i class="card_tip_txt_inner">${lfn:message('sys-organization:sysOrgMatrix.fdContent')}</i></span>
            </span>
        </p>
        $}
       	}
       	{$
    </div>
$}