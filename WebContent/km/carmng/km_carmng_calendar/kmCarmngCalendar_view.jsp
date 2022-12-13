<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%--查看用车申请--%>
<div id="carmng_calendar_view" class="meeting_calendar_dialog"  style="position: absolute; display: none">
	<span class="fdId" style="display: none;"></span>
	<span class="type" style="display: none;"></span>
	<%--顶部--%>
	<div class="meeting_calendar_dialog_top">
		<div class="meeting_calendar_dialog_title">${lfn:message('km-carmng:kmCarmng.application.view')}</div>
		<div class="meeting_calendar_dialog_close" ></div>
	</div>
	<%--内容区--%>
	<div class="meeting_calendar_dialog_content" >
		<div>
			<%--申请单名称--%>
			<span class="title" style="display:block;float: left;">
				<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdApplicationIds" />
			</span>
			<span class="fdName" style="display:block;float: left;text-align: justify;width:230px;word-break: break-all;"></span>
			<div style="clear: both;"></div>
		</div>
		<div>
			<%--时间--%>
			<span class="title">
				<bean:message key="time.label" />
			</span>
			<span class="fdHoldDate"></span>
		</div>
		<div>
			<%--用车人--%>
			<span class="title">
				<bean:message bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" />
			</span>
			<span class="fdUserPersons"></span>
		</div>
		<div>
			<%--调度人--%>
			<span class="title">
				<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" />
			</span>
			<span class="docCreator"></span>
		</div>
	</div>
	<%--底部--%>
	<div class="meeting_calendar_dialog_buttom">
		<%-- 查看会议安排 --%>
		<div  style="text-align: center;"><ui:button id="meeting_view_btn" text="${lfn:message('button.view') }"  styleClass="lui_toolbar_btn_gray" /></div>
	</div>
</div>

<script>
	seajs.use(['lui/jquery','lui/dialog'], function($,dialog) {
		//查看会议安排
		$('#meeting_view_btn').click(function(){
			$('.meeting_calendar_dialog').hide();
			var fdId=$("#carmng_calendar_view").find(".fdId").html();
			window.open('${LUI_ContextPath}/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=view&fdId='+fdId,'_blank');
			
		});
		//关闭
		$('.meeting_calendar_dialog_close').click(function(){
			$('.meeting_calendar_dialog').fadeOut("fast");
		});
	});
</script>