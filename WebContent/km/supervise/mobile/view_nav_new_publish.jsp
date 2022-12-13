<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	<c:choose>
		<c:when test="${JsParam.tabIndex eq '2' }">
			{ 
				moveTo : "planAndBackView", 
				text : "${lfn:message('km-supervise:py.planAndBack')}",
				selected : true 
			},
			{
				moveTo:"instructionView",
				text : "${lfn:message('km-supervise:py.leaderInstruction')}"
			},
			{
			    moveTo:"instructionViewMsg",
				text : "${lfn:message('km-supervise:py.InstructionMsg')}"
			},
			{
				moveTo:"folwView",
				text : "${lfn:message('km-supervise:mobile.flow.record')}"
			},
			{
				moveTo:"otherView",
				text : "${lfn:message('km-supervise:py.otherInfo')}"
			}
		</c:when>
		<c:when test="${JsParam.tabIndex eq '7' }">
			{ 
				moveTo : "planAndBackView", 
				text : "${lfn:message('km-supervise:py.planAndBack')}"
			},
			{
				moveTo:"instructionView",
				text : "${lfn:message('km-supervise:py.leaderInstruction')}",
				selected : true 
			},
			{
			    moveTo:"instructionViewMsg",
				text : "${lfn:message('km-supervise:py.InstructionMsg')}"
			},
			{
				moveTo:"folwView",
				text : "${lfn:message('km-supervise:mobile.flow.record')}"
			},
			{
				moveTo:"otherView",
				text : "${lfn:message('km-supervise:py.otherInfo')}"
			}
		</c:when>
		<c:when test="${JsParam.tabIndex eq '1' || JsParam.tabIndex eq '4' || JsParam.tabIndex eq '5' || JsParam.tabIndex eq '6'}">
			{ 
				moveTo : "planAndBackView", 
				text : "${lfn:message('km-supervise:py.planAndBack')}"
			},
			{
				moveTo:"instructionView",
				text : "${lfn:message('km-supervise:py.leaderInstruction')}"
				
			},
			{
			    moveTo:"instructionViewMsg",
				text : "${lfn:message('km-supervise:py.InstructionMsg')}"
			},
			{
				moveTo:"folwView",
				text : "${lfn:message('km-supervise:mobile.flow.record')}"
			},
			{
				moveTo:"otherView",
				text : "${lfn:message('km-supervise:py.otherInfo')}",
				selected : true 
			}
		</c:when>
		<c:otherwise>
			{ 
				moveTo : "planAndBackView", 
				text : "${lfn:message('km-supervise:py.planAndBack')}",
				selected : true 
			},
			{
				moveTo:"instructionView",
				text : "${lfn:message('km-supervise:py.leaderInstruction')}"
			},
			{
			    moveTo:"instructionViewMsg",
				text : "${lfn:message('km-supervise:py.InstructionMsg')}"
			},
			{
				moveTo:"folwView",
				text : "${lfn:message('km-supervise:mobile.flow.record')}"
			},
			{
				moveTo:"otherView",
				text : "${lfn:message('km-supervise:py.otherInfo')}"
			}
		</c:otherwise>
	</c:choose>
]
