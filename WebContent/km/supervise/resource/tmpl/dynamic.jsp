<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length>0){
	var status1 = '0';
	var status2 = '0';
	var status3 = '0';
	for(var i=0; i < data.length; i++){
		if(data[i].fdStatus == '50'){
			status1 = '1';
		}else if(data[i].fdStatus == '40'){
			status2 = '1';
		}else if(data[i].fdStatus == '30'){
			status3 = '1';
		}
		if(status1 == '1' && status2 == '1' && status3 == '1'){
			break;
		}
	}
	
{$<div class="lui-common-tree">$}
	
	if(status1 == '1'){
		{$<dl>
			<dt><i class="icon-dot dot-danger"></i><span>${lfn:message('km-supervise:enums.doc_status.50')}</span></dt>
		$}
		for(var i=0;i < data.length;i++){
			var fdStatus = data[i].fdStatus;
			if(fdStatus=='50'){
				{$
					<dd class="trendList-dd">
						<!-- 督办动态列表 -->
						<div class="trendList-wrap">
							<div class="statusList-detail">
								<span class="line"></span>
									<span class="date">{%data[i].docCreateTime%}</span>
									<span class="leader">{%data[i].docCreator%}</span>
									<span class="content">{%data[i].fdContent%}</span>
							</div>
							<div class="attach-wrap" id="div2"></div>
						</div>
					</dd>
				$}
			}
		}
		{$</dl>$}
	}
	
	if(status2 == '1'){
		{$<dl>
			<dt><i class="icon-dot dot-success"></i><span>${lfn:message('km-supervise:enums.doc_status.40')}</span></dt>
		$}
		for(var i=0;i < data.length;i++){
			var fdStatus = data[i].fdStatus;
			if(fdStatus=='40'){
				{$
					<dd class="trendList-dd">
						<!-- 督办动态列表 -->
						<div class="trendList-wrap">
							<div class="statusList-detail">
								<span class="line"></span>
								<span class="date">{%data[i].docCreateTime%}</span>
								<span class="leader">{%data[i].docCreator%}</span>
								<span class="content">{%data[i].fdContent%}</span>
							</div>
							<div class="attach-wrap" id="div1"></div>
						</div>	
					</dd>
				$}
			}
		}
		{$</dl>$}
	}
	
	if(status3 == '1'){
		{$<dl>
			<dt><i class="icon-dot dot-normal"></i><span>${lfn:message('km-supervise:enums.doc_status.30')}</span></dt>
		$}
		for(var i=0;i < data.length;i++){
			var fdStatus = data[i].fdStatus;
			if(fdStatus=='30'){
				{$
					<dd class="trendList-dd">
						<!-- 督办动态列表 -->
						<div class="trendList-wrap">
							<div class="statusList-detail">
									<span class="line"></span>
									<span class="date">{%data[i].docCreateTime%}</span>
									<span class="leader">{%data[i].docCreator%}</span>
									<span class="content">{%data[i].fdContent%}</span>
							</div>
							<div class="attach-wrap" id="div3"></div>
						</div>
					</dd>
				$}
			}
		}
		{$</dl>$}
	}
	
{$</div>$}
}else{
	{$${lfn:message('km-supervise:kmSuperviseMain.not.null.record')}$}
}
