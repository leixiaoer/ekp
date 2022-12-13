<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no" width="90%">
	<template:replace name="title">
		<c:out value="${lfn:message('km-vote:button.viewVoted')} - ${ lfn:message('km-vote:module.km.vote') }"></c:out>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams 
				moduleTitle="${ lfn:message('km-vote:module.km.vote') }" 
				modulePath="/km/vote/" 
				modelName="com.landray.kmss.km.vote.model.KmVoteCategory" 
				autoFetch="false"
				href="/km/vote/"
				categoryId="${fdCategoryId}" />
		</ui:combin>
	</template:replace>	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="2">
			<%-- 导出Excel --%>
			<c:if test="${queryPage.totalrows != 0}">
				<ui:button text="${lfn:message('km-vote:button.exportExcel')}" 
					onclick="Com_OpenWindow('${ LUI_ContextPath }/km/vote/km_vote_record/kmVoteRecord.do?method=exportVotedDetailExcel&fdMainId=${param.fdMainId}','_self');" order="4">
				</ui:button>
			</c:if>
			<%-- 返回 --%>
			<ui:button text="${lfn:message('button.back')}" 
				onclick="Com_OpenWindow('${ LUI_ContextPath }/km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=${param.fdMainId}','_self');" order="5">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
		<script>
		  LUI.ready(function(){
				seajs.use('lui/topic',function(topic){
					var evt = {page: {currentPage:"${queryPage.pageno}", pageSize:"${queryPage.rowsize}", totalSize:"${queryPage.totalrows}"}};
				    topic.publish('list.changed',evt);
			        topic.subscribe('paging.changed',function(evt){
					    var  arr = evt.page;
					    var pageno=arr[0].value;
					    var rowsize=arr[1].value;
					    window.open('${LUI_ContextPath}/km/vote/km_vote_record/kmVoteRecord.do?method=viewVotedDetail&fdMainId=${fdMainId}&pageno='+pageno+"&rowsize="+rowsize,"_self");
		         	});
				});
			});
		</script>
		<link href="${LUI_ContextPath}/km/vote/resource/css/vote.css" rel="stylesheet" type="text/css" />
		<table class="tb_normal lui_vote_votedDetail" width="100%" id="mainTable">
			<%-- 标题--%>
			<p class="txttitle">
				<bean:message key="kmVoteRecord.votedDetail.title" bundle="km-vote"/>
			</p>
			<tr class="title">
				<td >${lfn:message('km-vote:kmVoteRecord.docCreator')}</td><td>${lfn:message('km-vote:kmVoteRecord.docCreator.dept')}</td><td>${lfn:message('km-vote:kmVoteRecord.fdMainItems')}</td><td>${lfn:message('km-vote:kmVoteRecord.voteComment')}</td><td>${lfn:message('km-vote:kmVoteRecord.docCreateTime')}</td>
			</tr>
			<c:forEach items="${queryPage.list}" var="record" varStatus="vstatus">
				<tr height="30">
					<td style="width:9%;">${record.docCreator.fdName}</td>
					<td style="width:12%;">${record.docCreator.fdParent.fdName}</td>
					<td style="width:30%;"><c:out value="${record.fdMainItemNames}"/></td>
					<td>
						<input type="hidden" id="${record.kmVoteComment.fdId}" value='<c:out value="${record.kmVoteComment.docContent}"/>'>
						<c:out value="${record.kmVoteComment.docContent}"/>
					</td>
					<td style="width:11%;"><kmss:showDate value="${record.docCreateTime}" /> </td>
				</tr>
			</c:forEach>
			<c:if test="${queryPage.totalrows==0}">
				<tr>
					<td colspan="5"><%@ include file="/resource/jsp/list_norecord.jsp"%></td>
				</tr>
			</c:if>
		</table>
		<list:paging></list:paging>	
		<!-- 投票结果 -->
		<p class="txttitle">
			<bean:message key="kmVoteMain.viewVote.voteResult" bundle="km-vote"/>
		</p>
		<div class="vote_tb_w">
			<table>
			      <c:forEach items="${kmVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
			          <tr>                    
			              <td style="width:15px;padding-bottom: 10px;padding-top: 3px;">
			              </td>
			         		<td style="display:none;">		                      			
			         		</td>
			            <td style="padding-bottom: 10px;font-size:13px;" class="com_subject" colspan="2">
			            <label for="_fdVoteItemIds${vstatus.index+1}_">
			             <script type="text/javascript">     
			               	document.write('<c:out value="${kmVoteMainItemForm.fdName}"  />');																			
						</script>								
						<br/>
			  			<div class="barline" >
						<div style="width:260px;height:15px;float:left;background: none no-repeat scroll left 50% #efefef;"><span class="charts color${kmVoteMainItemForm.fdColor}" ></span></div>
			         	<span class="num">
			           		<script type="text/javascript">
								document.write('<c:out value="${kmVoteMainItemForm.fdVoteItemNum}" />');
								var voteItemNum = ${kmVoteMainItemForm.fdVoteItemNum};
								var voteNum = ${kmVoteNum};
								var res = voteItemNum/voteNum;
								var d = document.querySelectorAll(".charts");
								d[${vstatus.index}].style.width= (res*100)+"%";
							</script>
			          			(<script>document.write((res.toFixed(4)*100).toFixed(2)+"%");</script>)
			          	</span>
			          	</div>
			           </label>
			          </td>
			       </tr>
			    </c:forEach>
			</table>
		</div>

	</template:replace>
</template:include>
