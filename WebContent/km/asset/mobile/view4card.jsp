<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.asset.forms.KmAssetCardForm"%>
<%@page import="com.landray.kmss.km.asset.service.IKmAssetCardService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ page import="com.landray.kmss.util.UserUtil,com.landray.kmss.sys.attachment.util.SysAttPicUtils" %>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
	     <mui:min-file name="mui-asset-view-card.css"/>
		 <mui:min-file name="cardlist.css"/>
		 <mui:min-file name="list.css"/>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmAssetCardForm.fdName}"></c:out>
	</template:replace>
	<template:replace name="content">
	    <%
		IKmAssetCardService kmAssetCardService= (IKmAssetCardService)SpringBeanUtil.getBean("kmAssetCardService");
		%>
		<div id="scrollView"  data-dojo-type="mui/view/DocScrollableView">
		 <div class="muiAssetCardView gray">
		    <%
		       String firstImgId = (String)request.getAttribute("firstImgId");
		   	   String imgUrlIds = (String)request.getAttribute("imgUrlIds");
		       String firstImgUrl="";
		       String firstImgPreview="";
		       if(StringUtil.isNotNull(firstImgId)){
		    	   firstImgUrl = request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=big&fdId="+firstImgId;
		    	   firstImgPreview = SysAttPicUtils.getPreviewUrl(request,firstImgId);
		       }else{
		    	   firstImgUrl = request.getContextPath()+"/km/asset/mobile/js/list/item/defaulthead.jpg";
		    	   firstImgPreview = "/km/asset/mobile/js/list/item/defaulthead.jpg";
		       }
		       request.setAttribute("firstImgUrl",firstImgUrl);
		       request.setAttribute("firstImgPreview",firstImgPreview);
		       //生成图片预览地址
		       if(StringUtil.isNotNull(imgUrlIds)){
		    	   String imgurl = "";
		    	   String[] ids = imgUrlIds.split(";");
		    	   for(String id : ids){
		    		   imgurl = StringUtil.linkString(imgurl, ",", SysAttPicUtils.getPreviewUrl(request,id));
		    	   }
		    	   request.setAttribute("imgurl",imgurl);
		       }
		    %>
		        <header class="muiAssetCardBanner">
		            <span><img src="${firstImgUrl}" onclick="imgPreview();"/></span>
		            <div class="bg"><span><c:out value="${kmAssetCardForm.fdName}"></c:out></span></div>
		        </header>
		        <div class="muiAssestinfo">
		            <div class="item">
		                <div class="price">
		                    <span>
		                      <em>
		                        <c:if test="${kmAssetCardForm.fdFirstUnit eq 'CNY'}">
							     ¥
							    </c:if>
							     <c:if test="${kmAssetCardForm.fdFirstUnit eq 'HKD'}">
							     HK$
							    </c:if>
							    <c:if test="${kmAssetCardForm.fdFirstUnit eq 'USD'}">
							     $
							    </c:if>
							     <c:if test="${kmAssetCardForm.fdFirstUnit eq 'EUR'}">
							     €  
							    </c:if>
							     <c:if test="${kmAssetCardForm.fdFirstUnit eq 'GBP'}">
							     £
							    </c:if>
							    <c:if test="${kmAssetCardForm.fdFirstUnit eq 'JPY'}">
							     ¥
							    </c:if>
							    <c:choose>
							    <c:when test="${not empty kmAssetCardForm.fdFirstValue}"><kmss:showNumber value="${kmAssetCardForm.fdFirstValue}" pattern="###,##0.00"/></c:when>
							    <c:otherwise>0</c:otherwise>
							    </c:choose></em>/<c:out value="${kmAssetCardForm.fdMeasure}"></c:out>
		                   </span></div>
		                   <c:if test="${kmAssetCardForm.fdAssetStatus eq '1'}">
						        <div class="status unused"><span><bean:message bundle="km-asset" key="fdAssetStatus.enums.status1" /></span></div>
						    </c:if>
						     <c:if test="${kmAssetCardForm.fdAssetStatus eq '2'}">
						        <div class="status inuse"><span><bean:message bundle="km-asset" key="fdAssetStatus.enums.status2" /></span></div>
						    </c:if>
						     <c:if test="${kmAssetCardForm.fdAssetStatus eq '3'}">
						        <div class="status borrow"><span><bean:message bundle="km-asset" key="fdAssetStatus.enums.status3" /></span></div>
						    </c:if>
						     <c:if test="${kmAssetCardForm.fdAssetStatus eq '4'}">
						       <div class="status repair"><span><bean:message bundle="km-asset" key="fdAssetStatus.enums.status4" /></span></div>
						    </c:if>
						     <c:if test="${kmAssetCardForm.fdAssetStatus eq '5'}">
						        <div class="status discard"><span><bean:message bundle="km-asset" key="fdAssetStatus.enums.status5" /></span></div>
						    </c:if>
		            </div>
		            <div data-dojo-type="mui/panel/Content">
			            <div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav" id="${kmAssetCardForm.fdId}"
		 					data-dojo-props='icon:"mui mui-assetLife",rightIcon:"mui mui-forward",clickable:true,noArrow:true'
		 					data-dojo-mixins="km/asset/mobile/js/list/AssetCardLifeDetailMixin">
	 					    <bean:message bundle="km-asset" key="kmAssetCard.page.tab3"/>
	 					</div>
 					</div>
		        </div>
		        <section class="muiAssetItem">
		            <h3 class="title"><bean:message bundle="km-asset" key="kmAssetCard.page.baseInfo" /></h3>
		            <div class="content">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
								</td><td>
								   <xform:text property="fdStandard" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
								</td><td>
								    <xform:text property="docDeptName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
								</td><td>
								    <xform:text property="fdResponsiblePersonName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
								</td><td>
								    <xform:text property="fdAssetAddressName" mobile="true"/>
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
								</td><td>
								    <xform:text property="fdAssetCategoryName" mobile="true"/>
								</td>
							</tr>
						</table>
					</div>
					<div data-dojo-type="mui/panel/Content">
							<div data-dojo-type="dojox/mobile/ListItem" class="baseInfoNav" 
		 					  data-dojo-props='icon:"mui mui-bookViewDetail",rightIcon:"mui mui-forward",clickable:true,noArrow:true'
		 					  data-dojo-mixins="km/asset/mobile/js/list/AssetCardDetailMixin">
		 					  <bean:message bundle="km-asset" key="kmAssetCard.page.baseInfo.more" />
		 					</div>
 					 </div>
		        </section>
		        <c:if test="${fn:length(kmAssetCardForm.fdItems)>0}">
				 <section class="muiAssetItem">
				  <h3 class="title"><bean:message bundle="km-asset" key="kmAssetCard.page.tab2"/></h3>
				  <div class="attachContent">
				   <ul class="mblEdgeToEdgeList muiAssetCardList">
					    <c:forEach items="${kmAssetCardForm.fdItems}" var="item" varStatus="vstatus">
						      <li>
						         <a href="<%=request.getContextPath()%>/km/asset/km_asset_card/kmAssetCard.do?method=view&amp;fdId=${item.fdId}&amp;_mobile=1" target="_self">
						         <div class="assetCardIcon">
							        <span>
								        <%  Object basedocObj = pageContext.getAttribute("item");
										   if(basedocObj != null) { 
											   KmAssetCardForm kmAssetCard = (KmAssetCardForm)basedocObj;
											   String ids = kmAssetCardService.getCardPicIdsByCardId(kmAssetCard.getFdId());
											    String imgUrl="";
												if(StringUtil.isNotNull(ids)){
													imgUrl = request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=download&fdId="+ids.split(";")[0];
												}else{
													imgUrl = request.getContextPath()+"/km/asset/mobile/js/list/item/defaulthead.jpg";
												}
												out.print("<img src='"+imgUrl+"'/>");
											}
								        %>
							        </span>
							            <c:if test="${item.fdAssetStatus eq '1'}">
									      <span class="status unused"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status1" /></span>
									    </c:if>
									     <c:if test="${item.fdAssetStatus eq '2'}">
									      <span class="status inuse"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status2" /></span>
									    </c:if>
									     <c:if test="${item.fdAssetStatus eq '3'}">
									      <span class="status borrow"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status3" /></span>
									    </c:if>
									     <c:if test="${item.fdAssetStatus eq '4'}">
									      <span class="status repair"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status4" /></span>
									    </c:if>
									     <c:if test="${item.fdAssetStatus eq '5'}">
									      <span class="status discard"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status5" /></span>
									    </c:if>
						         </div>
						         <div class="assetCardInfo">
						          <h3 class="">${item.fdName}</h3>
							         <div class="assetDetail">
							         <div class="price"><span>
							          <em>
							            <c:if test="${item.fdFirstUnit eq 'CNY'}">
									      ¥
									    </c:if>
									     <c:if test="${item.fdFirstUnit eq 'HKD'}">
									     HK$
									    </c:if>
									    <c:if test="${item.fdFirstUnit eq 'USD'}">
									     $
									    </c:if>
									     <c:if test="${item.fdFirstUnit eq 'EUR'}">
									     €  
									    </c:if>
									     <c:if test="${item.fdFirstUnit eq 'GBP'}">
									     £
									    </c:if>
									    <c:if test="${item.fdFirstUnit eq 'JPY'}">
									     ¥
									    </c:if>
									    <c:choose>
									    <c:when test="${not empty item.fdFirstValue}"><kmss:showNumber value="${item.fdFirstValue}" pattern="###,##0.00"/></c:when>
									    <c:otherwise>0</c:otherwise>
									    </c:choose>
							          </em>/${item.fdMeasure}</span></div>
							         <div class="num"><span><i class="mui mui-assetCode"></i>${item.fdCode}</span></div>
							         </div>
							     </div>
						         </a>
						       </li>
						</c:forEach>
					 </ul>
					 </div>
					</section>
			   </c:if>
		    </div>
			<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
			  
			  <c:if test="${'true'==isShow}">
	  			<li data-dojo-type="mui/tabbar/CreateButton" 
		  		data-dojo-mixins="mui/syscategory/SysCategoryMixin,km/asset/mobile/resource/js/KmAssetCategoryMixin"
		  		data-dojo-props="icon1:'',colSize:4,createUrl:'/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=add&fdCardId=${kmAssetCardForm.fdId}&fdTemplateId=!{curIds}&&fdTaskId=${fdTaskId }&&fdDetailId=${fdDetailId }',mainModelName:'com.landray.kmss.km.asset.model.KmAssetApplyInventory',
		  		modelName:'com.landray.kmss.km.asset.model.KmAssetApplyTemplate',
		  		fdTmepKey:'KmAssetApplyInventoryDoc',
		  		tempKey:'KmAssetApplyInventoryDoc'"><bean:message  bundle="km-asset"  key="kmAssetApplyTask.inventory.create" /></li>
	  		  </c:if>
			    
			</ul>
		</div>
		<div id='basicInfoView' data-dojo-type="dojox/mobile/View">
			<div class="basicInfoHeader" data-dojo-type="mui/header/Header">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message key="button.back" /></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message bundle="km-asset" key="kmAssetCard.page.tab3"/></div>
				<div></div>
			</div>
			<div data-dojo-type="mui/list/StoreScrollableView">
			    <div data-dojo-type="mui/list/JsonStoreList"  style="min-height:700px" id="cardLife"
			    	data-dojo-mixins="km/asset/mobile/js/list/AssetCardLifeItemListMixin"
			    	data-dojo-props="url:''">
				</div>
			</div>
		</div>
		<div id='cardDetailInfoView' data-dojo-type="mui/view/DocScrollableView">
		    <div class="basicInfoHeader" data-dojo-type="mui/header/Header">
				<div class="basicInfoHeaderBack" onclick="backToDocView(this)">
					<i class="mui mui-back"></i>
					<span class="personHeaderReturnTxt"><bean:message key="button.back" /></span>
				</div>
				<div class="basicInfoHeaderTitle"><bean:message bundle="km-asset" key="kmAssetCard.page.baseInfo" /></div>
				<div></div>
			</div>
			<section class="muiAssetItem">
				<div class="content">
					<table class="muiSimple" cellpadding="0" cellspacing="0">
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdCode" />
							</td><td>
							    <xform:text property="fdCode" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdNo" />
							</td><td>
							    <xform:text property="fdNo" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdCanUseYears" />
							</td><td>
							    <xform:text property="fdCanUseYears" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.page.docDeptCode" />
							</td><td>
							    <xform:text property="docDeptCode" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdBuyer" />
							</td><td>
							    <xform:text property="fdBuyerName" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdBuyDate" />
							</td><td style="padding-top:10px;vertical-align: middle;">
								<xform:datetime property="fdBuyDate"  dateTimeType="date"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdInDeptNo" />
							</td><td style="padding-top:10px;vertical-align: middle;">
							    <xform:text property="fdInDeptNo" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdInDeptDate" />
							</td><td>
								<xform:datetime property="fdInDeptDate"  dateTimeType="date"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdFirstUsedDate" />
							</td><td>
								<xform:datetime property="fdFirstUsedDate"  dateTimeType="date"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdProvider" />
							</td><td>
							   <xform:text property="fdProviderName" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdWarranty" />
							</td><td>
							    <xform:text property="fdWarranty" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdParent" />
							</td><td>
							    <xform:text property="fdParentName" mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle"  >
								<bean:message bundle="km-asset" key="kmAssetCard.fdExplanation" />
							</td>
							<td>
								<xform:textarea property="fdExplanation"  mobile="true"/>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-asset" key="kmAssetCard.fdContent" />
							</td><td>
								<xform:textarea property="fdContent" mobile="true"/>
							</td>
						</tr>
						<c:if test="${kmAssetCardForm.fdUseForm == 'true'}">
							<tr>
								<td colspan="2">
								  <div data-dojo-type="mui/table/ScrollableHContainer">
											<div data-dojo-type="mui/table/ScrollableHView" class="muiFormContent">
												<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
													charEncoding="UTF-8">
													<c:param name="formName" value="kmAssetCardForm" />
													<c:param name="fdKey" value="assetMainDoc" />
													<c:param name="useTab" value="false" />
												</c:import>
											</div>
									</div>
								</td>
							</tr>
						</c:if>
					</table>
				</div>
			</section>
			</div>
	</template:replace>
</template:include>
<script>
	require(['dojo/topic',
	         'dojo/ready',
	         'dijit/registry',
	         'dojox/mobile/TransitionEvent',
	         "mui/util", 
	         'mui/device/adapter'
	         ],function(topic,ready,registry,TransitionEvent,util,adapter){
		
			//返回主视图
			window.backToDocView=function(obj){
				var opts = {
					transition : 'slide',
					transitionDir:-1,
					moveTo:'scrollView'
				};
				new TransitionEvent(obj, opts).dispatch();
				
			};
			window.openDeatailCardView = function(obj){
				var opts = {
						transition : 'slide',
						transitionDir:1,
						moveTo:'cardDetailInfoView'
					};
					new TransitionEvent(obj, opts).dispatch();
			};
			window.imgPreview=function(){
				var imgurl = "${imgurl}";
				var imgArray = imgurl.split(",");
				var srcList = [];
				var  options = {};
				if(imgArray.length>1){
					for(var i=0;i<imgArray.length;i++){
						srcList.push(util.formatUrl(imgArray[i], true));
					}
					options.curSrc=srcList[0];
					options.srcList=srcList;
					
				}else{
					var firstImgPreview = "${firstImgPreview}";
					srcList.push(util.formatUrl(firstImgPreview, true));
					options.curSrc=util.formatUrl(firstImgPreview, true);
					options.srcList=srcList;
			    }
				adapter.imagePreview(options);
			}
			window.openIntroduceWindows=function(url){
				window.location.href="<%=request.getContextPath()%>"+url;
			}
		});
</script>
