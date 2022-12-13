<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>


if(data.length > 0){

	var status1 = '0';
	var status2 = '0';
	var status3 = '0';
	for(var i=0; i < data.length; i++){
		if(data[i].docStatus == '1'){
			status1 = '1';
		}else if(data[i].docStatus == '2' || data[i].docStatus == '4' || data[i].docStatus == '5'){
			status2 = '1';
		}else if(data[i].docStatus == '3' || data[i].docStatus == '6'){
			status3 = '1';
		}
		if(status1 == '1' && status2 == '1' && status3 == '1'){
			break;
		}
	}


{$<div class="lui-common-tree">$}
	
	
	if(status1 == '1'){
		{$<dl>
			<dt><i class="icon-dot dot-wranning"></i><span>${lfn:message('km-supervise:kmSupervise.task.docStatus.1')}</span></dt>
		$}
		
		for(var i=0; i < data.length; i++){
		
			<%-- 未启动 --%>
			if(data[i].docStatus == '1'){
				
					{$
						<dd>
							<span class="line"></span>
							<div class="taskList-wrap">
								<div class="task_title">
									<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
								</div>
								<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
								<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
								<div class="status">
									<!-- <i v-if="list.statusBtn" class="btn-status" :class="list.statusBtn.statusType">
									{{list.statusBtn.txt}}</i> -->
								</div>
								<!-- 进度条 -->
								<div class="progress">
									<div class="progress-bar">
										<span class="rate">{%data[i].fdProgress%}%</span>
										<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
									</div>
								</div>
							</div>
						</dd>
					$}
					
			}
		
		}
		{$</dl>$}
	}
	
	
	if(status2 == '1'){
		{$<dl>
			<dt><i class="icon-dot dot-normal"></i><span>${lfn:message('km-supervise:kmSupervise.task.docStatus.2')}</span></dt>
		$}	
			<%-- 进行中--%>
			for(var i=0; i < data.length; i++){
				if(data[i].docStatus == '2'){
					if(data[i].fdPastDue == '1'){
						{$
							<dd>
								<span class="line"></span>
								<div class="taskList-wrap">
									<div class="task_title">
										<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
									</div>
									<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
									<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
									<div class="status">
										<i class="btn-status error">超时</i>
									</div>
									<!-- 进度条 -->
									<div class="progress">
										<div class="progress-bar">
											<span class="rate">{%data[i].fdProgress%}%</span>
											<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
										</div>
									</div>
								</div>
							</dd>
						$}
					}else{
						{$
							<dd>
								<span class="line"></span>
								<div class="taskList-wrap">
									<div class="task_title">
										<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
									</div>
									<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
									<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
									<div class="status">
										<!-- <i v-if="list.statusBtn" class="btn-status" :class="list.statusBtn.statusType">
										{{list.statusBtn.txt}}</i> -->
									</div>
									<!-- 进度条 -->
									<div class="progress">
										<div class="progress-bar">
											<span class="rate">{%data[i].fdProgress%}%</span>
											<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
										</div>
									</div>
								</div>
							</dd>
						$}
					}
				}
				if(data[i].docStatus == '4'){
				
					{$
						<dd>
							<span class="line"></span>
							<div class="taskList-wrap">
								<div class="task_title">
									<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
								</div>
								<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
								<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
								<div class="status">
									<i class="btn-status warning">暂停</i>
								</div>
								<!-- 进度条 -->
								<div class="progress">
									<div class="progress-bar">
										<span class="rate">{%data[i].fdProgress%}%</span>
										<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
									</div>
								</div>
							</div>
						</dd>
					$}
					
				}
				if(data[i].docStatus == '5'){
					
					{$
						<dd>
							<span class="line"></span>
							<div class="taskList-wrap">
								<div class="task_title">
									<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
								</div>
								<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
								<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
								<div class="status">
									<i class="btn-status error">驳回</i>
								</div>
								<!-- 进度条 -->
								<div class="progress">
									<div class="progress-bar">
										<span class="rate">{%data[i].fdProgress%}%</span>
										<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
									</div>
								</div>
							</div>
						</dd>
					$}
					
				}
			}
		{$</dl>$}
	}
	
		
	if(status3 == '1'){
		{$<dl>
			<dt><i class="icon-dot dot-success"></i><span>${lfn:message('km-supervise:kmSupervise.task.docStatus.3')}</span></dt>
		$}	
			<%-- 已完成--%>
			for(var i=0; i < data.length; i++){
				if(data[i].docStatus == '3'){
					if(data[i].fdPastDue == '1'){
						{$
							<dd>
								<span class="line"></span>
								<div class="taskList-wrap">
									<div class="task_title">
										<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
									</div>
									<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
									<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
									<div class="status">
										<i class="btn-status success">超时完成</i>
									</div>
									<!-- 进度条 -->
									<div class="progress">
										<div class="progress-bar">
											<span class="rate">{%data[i].fdProgress%}%</span>
											<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
										</div>
									</div>
								</div>
							</dd>
						$}
					}else{
						{$
							<dd>
								<span class="line"></span>
								<div class="taskList-wrap">
									<div class="task_title">
										<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
									</div>
									<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
									<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
									<div class="status">
										<!-- <i v-if="list.statusBtn" class="btn-status" :class="list.statusBtn.statusType">
										{{list.statusBtn.txt}}</i> -->
									</div>
									<!-- 进度条 -->
									<div class="progress">
										<div class="progress-bar">
											<span class="rate">{%data[i].fdProgress%}%</span>
											<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
										</div>
									</div>
								</div>
							</dd>
						$}
					}
				}
				if(data[i].docStatus == '6'){
					if(data[i].fdPastDue == '1'){
						{$
							<dd>
								<span class="line"></span>
								<div class="taskList-wrap">
									<div class="task_title">
										<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
									</div>
									<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
									<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
									<div class="status">
										<i class="btn-status error">延迟办结</i>
									</div>
									<!-- 进度条 -->
									<div class="progress">
										<div class="progress-bar">
											<span class="rate">{%data[i].fdProgress%}%</span>
											<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
										</div>
									</div>
								</div>
							</dd>
						$}
					}else{
						{$
							<dd>
								<span class="line"></span>
								<div class="taskList-wrap">
									<div class="task_title">
										<a href="${LUI_ContextPath }/sys/task/sys_task_main/sysTaskMain.do?method=view&fdId={%data[i].fdId%}" target="_blank">{%data[i].docSubject%}</a>
									</div>
									<div class="leader textEllipsis">{%data[i].fdPerformName%}</div>
									<div class="date"><i class="v-line"></i><span>{%data[i].createDate%}</span></div>
									<div class="status">
										<i class="btn-status success">成功办结</i>
									</div>
									<!-- 进度条 -->
									<div class="progress">
										<div class="progress-bar">
											<span class="rate">{%data[i].fdProgress%}%</span>
											<span class="chart" style="width:{%data[i].fdProgress%}%"></span>
										</div>
									</div>
								</div>
							</dd>
						$}
					}
				}
			}
		{$</dl>$}
	}
	
{$</div>$}
}else{
	{$${lfn:message('km-supervise:kmSuperviseMain.not.null.record')}$}
}
