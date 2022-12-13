<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:if test="${empty  kmVoteMainForm.docSubject}">
			<bean:message bundle="km-vote" key="button.launchedVote" />
		</c:if>
		<c:out value="${kmVoteMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:cache-file name="mui-km-vote-edit.css" cacheType="md5"/>
		<script>
			Com_IncludeFile("doclist.js");
		</script>
		<script>
			DocList_Info = new Array();
			DocList_Info.push("TABLE_DocList_word","TABLE_DocList_image");
		</script>
		<style>
		#scrollView{
		background-color:white;
		}
		</style>
	</template:replace>
	<template:replace name="content">
		
		<html:form action="/km/vote/km_vote_main/kmVoteMain.do" styleClass="muiVoteForm">
			<div class="muiVoteScrollableView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
				<div class="muiFormContent">
					<html:hidden property="fdId" />
					<html:hidden property="docStatus" />
					<html:hidden property="fdOtherViewFlag"/>
					<html:hidden property="fdDisplay"/>
					<html:hidden property="fdCount"/>
					<html:hidden property="fdStyle"/>
					<html:hidden property="fdModelName"/>
					<html:hidden property="fdModelId"/>
					
					
					<table class="muiSimple" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="2">
								<xform:text property="docSubject" validators="maxLength(200)" mobile="true" required="true" htmlElementProperties="placeholder=${ lfn:message('km-vote:mui.kmVoteMainEdit.subject.tip') }" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xform:textarea validators="maxLength(1500)" property="fdDescription" mobile="true" placeholder="${ lfn:message('km-vote:mui.kmVoteMainEdit.fdDesc.tip') }"></xform:textarea>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<div id="word_vote" >
									<table id="TABLE_DocList_word" width="100%">
								<!--  		<tr KMSS_IsReferRow="1" class="vote_tr" style="display: none;">-->
											<!-- 模板行使用mui/form/Template组件 -->
											<tr data-dojo-type="mui/form/Template" KMSS_IsReferRow="1" style="display:none;" class="vote_tr">
											<td class="vote_word_td">
												<input type="hidden" name="fdVoteItems[!{index}].fdId" value="${kmVoteMainItemForm.fdId}" />
												<input type="hidden" name="fdVoteItems[!{index}].fdVoteId" value="${kmVoteMainForm.fdId}" />																		
												<i onclick="deleteVoteItem();" class="muiDelIcon mui mui-delete"></i>
												<xform:text required="true" mobile="true" htmlElementProperties="placeholder=${lfn:message('km-vote:mui.kmVoteMainEdit.item.tip')}" property="fdVoteItems[!{index}].fdName" validators="maxLength(300)" subject="${lfn:message('km-vote:kmVoteMain.fdVoteItem')}" style="width:97%" className="inputsgl"  />
											</td>	
										</tr>
										<tr type="optRow">
											<td>									
												<a href="javascript:void(0);" onclick="AddVoteItem();" title="${lfn:message('doclist.add')}" class="add_item">																							
													<bean:message bundle="km-vote" key="kmVoteMain.addItem" />
													<img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" style="vertical-align:middle;margin-bottom:3px;" />
												</a>																			
											</td>
										</tr>
									</table>
								</div>
								
								<div id="image_vote" style="display:none;">
									<table id="TABLE_DocList_image" width="100%">
					<!-- 					<tr KMSS_IsReferRow="1"  style="display: none;" class="vote_tr"> -->
										<tr data-dojo-type="mui/form/Template" KMSS_IsReferRow="1" style="display:none;" class="vote_tr">
											<td class="vote_image_td">
												<input type="hidden" name="fdVoteItems[!{index}].fdId" value="${kmVoteMainItemForm.fdId}" />
												<input type="hidden" name="fdVoteItems[!{index}].fdVoteId" value="${kmVoteMainForm.fdId}" />
												<input type="hidden" id="optionImage_!{index}_id" name="fdVoteItems[!{index}].fdAttId" value="${kmVoteMainItemForm.fdAttId}"/>	
											
												<table id='tb_image_fdVoteItems_!{index}' class="muiImageVote">
													<tr>
														<td>
															<i onclick="deleteVoteItem('!{index}');" class="muiDelIcon mui mui-delete"></i>
														</td>
														<td>
															<xform:text required="true" htmlElementProperties="placeholder=${lfn:message('km-vote:mui.kmVoteMainEdit.item.tip')}" mobile="true"  property="fdVoteItems[!{index}].fdName" value="${kmVoteMainItemForm.fdName}" validators="maxLength(300)" subject="${lfn:message('km-vote:kmVoteMain.fdVoteItem')}" className="inputsgl" />
														</td>
														<td>
															<div class="vote_image_btn_box muiUploadBtnIcon" onclick="_onSelectImgageClick('!{index}')">
<%--																<input name="optionImageFiles[!{index}]" onclick="_onSelectImgageClick()" type="file" class="file" onchange="uploadOptionImage('!{index}')"/>--%>
															</div>
														</td>
													</tr>
												</table>
												
											  	<div class="muiUploadImagePreview" id="image_upload_preview_box_!{index}">
												</div>
												
												<div class="muiValidate" id="option_!{index}_tip" style="display: none;">
													<div class="muiValidateContent"><div class="muiValidateShape"></div>
													<div class="muiValidateInfo"><span class="muiValidateIcon"></span>
													<span class="muiValidateMsg">
													<span class="muiValidateTitle"><bean:message bundle="km-vote" key="kmVoteMain.pic" /></span> <bean:message bundle="km-vote" key="kmVoteMain.notNullDes" /></span>
													</div></div>
												</div>
																
											</td>
										</tr>
										
										<tr type="optRow">
											<td>
												<a href="javascript:void(0);" onclick="AddVoteItem();" title="${lfn:message('doclist.add')}" class="add_item">
													<bean:message bundle="km-vote" key="kmVoteMain.addItem" />
													<img src="${KMSS_Parameter_StylePath}/icons/icon_add.png" style="vertical-align:middle;margin-bottom:3px;" />												
												</a>																				
											</td>
										</tr>
									</table>				
								</div>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.fdStyle" />
							</td><td>
								<div class="lui_vote_tabpanel_switch">
									<div id="word_vote_tabpanel" class="lui_vote_tabpanel ${(kmVoteMainForm.fdStyle eq '1')?'lui_vote_tabpanel_on':''} " onclick="changeStyle('1');">
										<bean:message bundle="km-vote" key="kmVoteMain.wordVote" />
									</div>
									<div id="image_vote_tabpanel" class="lui_vote_tabpanel ${(kmVoteMainForm.fdStyle eq '2')?'lui_vote_tabpanel_on':''}" onclick="changeStyle('2');">
										<bean:message bundle="km-vote" key="kmVoteMain.imgVote" />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.isMul" />
							</td><td>
								<div class="muiVoteSwitch" data-dojo-type="mui/form/switch/NewSwitch"
									  data-dojo-mixins="km/vote/mobile/js/SwitchMixin" 
									  data-dojo-props="leftLabel:'',rightLabel:'',value:'off',property:'fdIsRadio'">
								</div>
							</td>
						</tr>
						<tr id="tr_isMul" <c:if test="${kmVoteMainForm.fdIsRadio!='false'}">style="display: none"</c:if>>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.select.optional" />
							</td><td>
							<div style="display: none">
								<xform:select value="0" property="fdMaxSelectNum" htmlElementProperties="id=_fdMaxSelectNum" showStatus="edit" mobile="true">
									<xform:simpleDataSource value="0"><bean:message bundle="km-vote" key="kmVoteMain.unlimited" /></xform:simpleDataSource>
									<xform:simpleDataSource value="${kmVoteMainForm.fdMaxSelectNum}">
										<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />${kmVoteMainForm.fdMaxSelectNum}<bean:message bundle="km-vote" key="kmVoteMain.item" />
									</xform:simpleDataSource>
								</xform:select>
								</div>								
								<xform:text isLoadDataDict="false" property="fdMinOption" validators="minInteger maxLength(3) compareRows" showStatus="edit" mobile="true" htmlElementProperties="placeholder=${ lfn:message('km-vote:mui.kmVoteMain.min.optional') }" />
								<xform:text isLoadDataDict="false" property="fdMaxOption" validators="maxInteger maxLength(3) compareSize" showStatus="edit" mobile="true" htmlElementProperties="placeholder=${ lfn:message('km-vote:mui.kmVoteMain.max.optional') }" />
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.fdCategoryId" />
							</td><td>
								<div class="muiVoteCate" data-dojo-type="km/vote/mobile/js/ChangeCategory"
								   		data-dojo-mixins="mui/simplecategory/SimpleCategoryMixin"
								   		data-dojo-props="modelName:'com.landray.kmss.km.vote.model.KmVoteCategory'">
								   	<html:hidden styleId="_fdCategoryId" property="fdCategoryId" /> 
									<span id="_fdCategoryName"><bean:write	name="kmVoteMainForm" property="fdCategoryName" /></span>
									<i class="mui-forward mui"></i>
							    </div>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.fdIsAllowSay" />
							</td><td>
								<div class="muiVoteSwitch" data-dojo-type="mui/form/switch/NewSwitch"
									  data-dojo-mixins="km/vote/mobile/js/VoteSwitchMixin" 
									  data-dojo-props="leftLabel:'',rightLabel:'',value:'on',property:'fdIsAllowSay'">
								</div>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.fdExpireTime" />
							</td><td>
								<xform:datetime placeholder="${lfn:message('km-vote:mui.kmVoteMainEdit.fdExpireTime.tip') }" property="fdExpireTime" dateTimeType="datetime" showStatus="edit" validators="after compareTime" mobile="true" />
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.fdVoters" />
							</td><td class="muivotePersons">
								<xform:address mobile="true" required="false" mulSelect="true" textarea="true" subject="${lfn:message('km-vote:kmVoteMain.fdVoters')}" 
									onValueChange="showOtherInfo" propertyId="fdVoterIds" propertyName="fdVoterNames">
								</xform:address>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.fdVoterViewFlag" />
							</td><td>
								<xform:radio mobile="true" property="fdVoterViewFlag" style="">
									<xform:simpleDataSource value="true" bundle="km-vote" textKey="kmVoteMain.fdVotersView" />
									<xform:simpleDataSource value="false" bundle="km-vote" textKey="kmVoteMain.fdCreatorView" />
								</xform:radio>
								
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.fdViewerIds" />
							</td><td class="muivoteExcPersons">
								<xform:address isLoadDataDict="false" mobile="true" textarea="true" mulSelect="true" subject="${lfn:message('km-vote:kmVoteMian.otherViews')}" 
								 propertyId="fdViewerIds" propertyName="fdViewerNames" orgType='ORG_TYPE_POSTORPERSON|ORG_TYPE_DEPT'>
							</xform:address>
								
							</td>
						</tr>
						<tr id="tr_notify" <c:if test="${empty kmVoteMainForm.fdVoterIds}">style="display: none"</c:if>>
							<td class="muiTitle">
								<bean:message bundle="km-vote" key="kmVoteMain.fdNotifyType" />
							</td>
							<td id="notifyType">
								<c:choose>
									<c:when test="${empty kmVoteMainForm.fdNotifyType}">
										<kmss:editNotifyType mobile="true" property="fdNotifyType" />
									</c:when>
									<c:otherwise>
										<kmss:editNotifyType mobile="true" property="fdNotifyType" value="${kmVoteMainForm.fdNotifyType}" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr><td></td><td></td></tr>
					</table>
					
				</div>
					
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" 
				  		data-dojo-props='colSize:2' onclick="submitKmVotePostForm()"><bean:message  key="button.submit" /></li>
				</ul>
			</div>

			
			<script>
			require(["mui/form/ajax-form!kmVoteMainForm"]);
			</script>
			<%@ include file="/km/vote/mobile/edit_script.jsp"%>
		</html:form>
	</template:replace>
</template:include>
