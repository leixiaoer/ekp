<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div style="padding-top:25px; padding-bottom: 8px;">

	<div style="text-align: center;">
		<a href="javascript:void(0);" style="text-decoration: underline;" onclick="showMyAssetCard()"><bean:message bundle="km-asset" key="kmAssetCard.my.list"/></a>
		<script>
		
			/*
			window.showMyAssetCard = function() {
				seajs.use(['lui/dialog'], function(dialog) {
					
					dialog.build({
						config : {
							width : 768,
							lock : true,
							cahce : false,
							title : "${ lfn:message('km-asset:kmAssetCard.my.list') }",
							content : {
								type : "common",
								html : $('#myAssetCard').html()
							}
						},
						callback : function() {}
					}).show();
					
				});						
			}
			*/
			window.showMyAssetCard = function() {
				seajs.use(["lui/dialog"], function(dialog) {
					dialog.iframe(
						"/km/asset/import/kmAssetCard_my.jsp?fdResponsiblePerson=${param.fdResponsiblePerson}", 
						"${ lfn:message('km-asset:kmAssetCard.my.list') }", 
						function() {
							
	    				}, 
	    				{
							"topWin": window,	    					
	    					"width" : 900,
	    					"height" : 500
	    				}
					);
				});	
			}
		</script>
	</div>
	
	<%-- 
	<div style="display: none;" id="myAssetCard">
		<table class="tb_normal" width=100%>
			<tr align="center">
			    <td  class="td_normal_title" align="center" width="40px"> 
					<bean:message key="page.serial"/>
				</td>
				<!-- 资产状态 -->
				<td  class="td_normal_title" align="center"  width="10%"> 
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
				</td>
				<!-- 资产编码 -->
				<td  class="td_normal_title" align="center"  width="10%"> 
					<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
				</td>
				<!-- 资产名称-->
				<td class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
				</td>
				
				<!-- 资产类别-->
				<td class="td_normal_title" align="center"  width="15%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
				</td>
				
				<!-- 规格型号-->
				<td class="td_normal_title" align="center"  width="15%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
				</td>
				<!-- 链接-->
				<td class="td_normal_title" align="center"  width="60px">
					 <bean:message bundle="km-asset" key="kmAssetCard.link"/>
				</td>
			</tr>
			<c:forEach items="${myCards}" var="card" varStatus="vstatus">
				<tr align="center">
					<td>
						${vstatus.index+1}
					</td>
					<td>
					 <xform:select property="fdAssetStatus" value="${card.fdAssetStatus}" showStatus="view">
						<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
					</xform:select>
					</td>
					<td>
						<c:out value="${card.fdCode}" />
					</td>
					<td>
						<c:out value="${card.fdName}" />
					</td>
					<td>
						<c:out value="${card.fdCateName}" />
					</td>
					<td>
						<c:out value="${card.fdStandard}" />
					</td>
					<td>
						<a class="com_btn_link" href="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=view&fdId=${card.fdId}" target="_blank"><bean:message bundle="km-asset" key="kmAssetCard.detail"/></a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	--%>
	
</div>