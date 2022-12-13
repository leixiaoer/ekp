<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no" width="90%">
	<template:replace name="title">
		<c:out value="${lfn:message('km-vote:kmVoteMainVoter.fdVoterId')} - ${ lfn:message('km-vote:module.km.vote') }"></c:out>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams 
				moduleTitle="${ lfn:message('km-vote:module.km.vote') }" 
				modulePath="/km/vote/" 
				modelName="com.landray.kmss.km.vote.model.KmVoteCategory" 
				autoFetch="false"
				href="/km/vote/"
				categoryId="${param.fdCategoryId}" />
		</ui:combin>
	</template:replace>	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="2">
			<%-- 提交 --%>
			<c:if test="${queryPage.totalrows != 0}">
				<ui:button text="${lfn:message('km-vote:button.updateVote')}" 
					onclick="submitBtn()">
				</ui:button>
			</c:if>
			<%-- 关闭 --%>
			<ui:button text="${lfn:message('button.close')}" onclick="Com_CloseWindow();"></ui:button>
			
		</ui:toolbar>
	</template:replace>
	<template:replace name="content">
	    <table class="tb_normal" width="100%">
	           <tr>
                   <td class="td_normal_title" style="width:15%">
                       ${lfn:message('km-vote:kmVoteMain.changeMethod')}
                   </td>
                   <td class="td_normal_title" style="width:85%;">
                  		 ${lfn:message('km-vote:kmVoteMain.canChangeVoter')}
                   		<!-- <labal><input id = "addRadio" type="radio" checked="checked" name="addAndDelete" value="1" /></labal> -->
                   		<%-- <label><input id="deleteRadio" type="radio" name="addAndDelete" value="2"/>${lfn:message('km-vote:kmVoteMain.deleteVoter')}</label> --%>
                   </td>
               </tr>
               <tr id="voter">
               		<td style="width:15%;">${lfn:message('km-vote:kmVoteMain.Voters')}</td>
               		<td>
               			<xform:address idValue="${fdVoterIds}" nameValue="${fdVoterNames}" isLoadDataDict="false" required="false" mulSelect="true" textarea="true"  subject="${lfn:message('km-vote:kmVoteMain.fdVoters')}" 
							           propertyId="fdVoterIds" propertyName="fdVoterNames" showStatus="edit" >
						</xform:address>
						<span class="txtstrong"><bean:message bundle="km-vote" key="kmVoteMain.voter.isNull.message"/></span>
               		</td>
               </tr>
          
        </table>

     	<script type="text/javascript">
  			var oldVoters = $("input[name=fdVoterIds]").val();
     		
			
			function submitBtn(){
				var newVoters = $("input[name=fdVoterIds]").val();
				var removeIds = getChangePerson(oldVoters.split(";"),newVoters.split(";"));
				var addIds = getChangePerson(newVoters.split(";"),oldVoters.split(";"));
				addIds = addIds.length>0?addIds.join(";"):"";
				removeIds = removeIds.length>0?removeIds.join(";"):"";	
				var AuthFlag = oldVoters?"true":"false";
			  	 $.ajax({
					type:"POST",
					url:"kmVoteMain.do?method=editVoterRes",
					data:{
						deletedIds:removeIds,
						addedIds:addIds,
						fdId:'${param.fdId}',
						voters:newVoters,
						authFlag:AuthFlag
						},
					success:function(data){
						if(data){
							$(location).attr('href', '${LUI_ContextPath}/resource/jsp/success.jsp');
						} 
					}
				}); 
				
			}
			function getChangePerson(Arr1,Arr2){
				var changeArr = [];
					for(var i = 0;i<Arr1.length;i++){
						var flag = 0;
						for(var j = 0;j<Arr2.length;j++){
							
							if(Arr1[i]===Arr2[j]){
								flag=1;
								break;
							}
						}
						if(flag===0){
							changeArr.push(Arr1[i])
						};
						
					}
					return changeArr;
			}
			
			
     	</script> 
	</template:replace>
	
</template:include>