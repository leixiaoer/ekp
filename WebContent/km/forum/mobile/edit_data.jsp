<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<ui:ajaxtext>
	<div data-dojo-block="title">
		<c:out value="${kmForumPostForm.fdForumName}"></c:out>
	</div>
	<div data-dojo-block="content">
		<html:form action="/km/forum/km_forum/kmForumPost.do">
			<html:hidden property="fdId" />
			<html:hidden property="fdForumId" />
      		<html:hidden property="fdTopicId" />
			
			<div data-dojo-type="mui/view/DocScrollableView" id="scrollView" data-dojo-mixins="mui/form/_ValidateMixin,mui/form/_AlignMixin" >
				<div data-dojo-type="mui/panel/Content">
					<table class="muiSimple" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="2">
								<xform:config orient="vertical"> 
									<xform:text property="docSubject" mobile="true" required="true"></xform:text>
								</xform:config>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xform:rtf property="docContent" mobile="true">
								</xform:rtf>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								${lfn:message('sys-attachment:mui.sysAttMain.button.upload') }
							</td>
							<td>
								<c:import
									url="/sys/attachment/mobile/import/edit.jsp"
									charEncoding="UTF-8">
									<c:param name="formName" value="kmForumPostForm" />
									<c:param name="fdKey" value="attachment" />
									<c:param name="align" value="right" />
								</c:import>
							</td>
						</tr>
						
						<c:if test="${globalIsAnonymous && fdForumAnonymous}">
							<tr>
								<td class="muiTitle">
									${lfn:message('km-forum:kmForumConfig.anonymous.yes')}	
								</td>
								<td>
									<div data-dojo-type="mui/form/switch/NewSwitch"
										 data-dojo-mixins="km/forum/mobile/resource/js/view/SwitchMixin"
										 data-dojo-props="value:'${kmForumPostForm.fdIsAnonymous}',property:'fdIsAnonymous'">
									</div>
								</td>
							</tr>
						</c:if>
						<tr id="fdIsNotifyTr">
							<td class="muiTitle">
								${lfn:message('km-forum:KmForumPost.notify.title.message')}	
							</td>
							<td>
								<div data-dojo-type="mui/form/switch/NewSwitch"
									 data-dojo-mixins="km/forum/mobile/resource/js/view/SwitchMixin"
									 data-dojo-props="realValue:'1',property:'fdIsNotify'">
								</div>
							</td>
						</tr>
						<tr id="fdNotifyTypeTR">
							<td colspan="2">
                            	<kmss:editNotifyType mobile="true" property="fdNotifyType" value="${kmForumPostForm.fdNotifyType}"/>
							</td>
						</tr>
						
						<tr id="fdIsOnlyViewTR">
							<td class="muiTitle">
								${lfn:message('km-forum:KmForumPost.notify.title.showOnly')}	
							</td>
							<td>
								<div data-dojo-type="mui/form/switch/NewSwitch"
									 data-dojo-mixins="km/forum/mobile/resource/js/view/SwitchMixin"
									 data-dojo-props="value:'${kmForumPostForm.fdIsOnlyView}',property:'fdIsOnlyView'"
									 id="fdIsOnlyView">
								</div>
							</td>
						</tr>
					</table>
				</div>
			
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
				  	<c:if test="${ kmForumPostForm.method_GET == 'add' }">
					  	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit " 
					  		data-dojo-props='colSize:2,href:"javascript:commitMethod(\"save\",\"false\");",transition:"slide"'>
					  		${lfn:message('button.submit')}	
					  	</li>
				  	</c:if>
				</ul>
			</div>
		</html:form>
		
		<script type="text/javascript">
			require(["mui/form/ajax-form!kmForumPostForm"]);
			require(["km/forum/mobile/resource/js/view/edit"]);
		</script>
	</div>
</ui:ajaxtext>
