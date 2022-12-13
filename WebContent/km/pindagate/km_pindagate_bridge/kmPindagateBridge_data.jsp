<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateBridge" list="${queryPage.list }">
	
		<list:data-column title="调查名称" property="fdPindageteMain.docSubject"></list:data-column>
		
		<list:data-column title="调查id"  property="fdPindageteMain.fdId"></list:data-column>
		
		
		<list:data-column col="fdTModelDisplayName" title="调查对象">
			<c:out value="${nameObj[kmPindagateBridge.fdId] }"/>
		</list:data-column>
		
		<list:data-column property="fdTModelName">
		</list:data-column>
		
		<list:data-column property="fdTModelId">
		</list:data-column>
		
		<list:data-column property="fdSModelName">
		</list:data-column>
		
		<list:data-column property="fdSModelId">
		</list:data-column>
		
		<list:data-column headerStyle="width:100px" col="docStatus"
			title="评估状态">
			<sunbor:enumsShow value="${kmPindagateBridge.fdPindageteMain.docStatus}"
				enumsType="kmPindagate_status" />
		</list:data-column>
		
		<list:data-column property="fdPindageteMain.fdLastStatNum" title="已调查人数">
		</list:data-column>
		
		<list:data-column property="fdPindageteMain.fdParticipantNum" title="调查人数">
		</list:data-column>
		
		<list:data-column 
			headerClass="width200" 
			col="operations" 
			title="操作"
			escape="false">
			
			<c:if test="${kmPindagateBridge.fdPindageteMain.docStatus=='30'}">
				<kmss:auth
					requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=startIndagate&fdId=${kmPindagateBridge.fdPindageteMain.fdId}"
					requestMethod="GET">
					<a href="javascript" onclick="stopIndagate()">
						${lfn:message('km-pindagate:button.startIndagate')}
					</a>
				</kmss:auth>
			</c:if>
			<%--结束调查--%>
			<c:if test="${kmPindagateBridge.fdPindageteMain.docStatus=='31'}">
				<kmss:auth
					requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=stopIndagate&fdId=${kmPindagateBridge.fdPindageteMain.fdId}"
					requestMethod="GET">
					<a href="javascript" onclick="stopIndagate()">
						${lfn:message('km-pindagate:button.stopIndagate')}
					</a>
				</kmss:auth>
			</c:if>
			
			<%--查看结果 --%>
			<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateBridge.fdPindageteMain.fdId}">
				<a  href="${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateBridge.fdPindageteMain.fdId}"> 
					查看结果
				</a>
			</kmss:auth>
				
		</list:data-column>
		<list:data-column col="qrcode" title="二维码" escape="false">
			<kmss:auth
				requestURL="/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId=${kmPindagateBridge.fdPindageteMain.fdId}"
				requestMethod="GET">
				<a class="btn_txt" style="color:#4285f4;"
							href="javascript:window.qrcodeShow('${kmPindagateBridge.fdPindageteMain}');">
							${lfn:message('km-pindagate:kmPindagateResponse.view')}
				</a>
			</kmss:auth>
		</list:data-column>
	</list:data-columns>
	<list:data-paging page="${queryPage }">
	</list:data-paging>
</list:data>