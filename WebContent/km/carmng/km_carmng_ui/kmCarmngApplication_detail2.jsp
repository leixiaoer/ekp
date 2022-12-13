<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
    <ui:dataview id="appDetail">
		<ui:source type="AjaxJson">
		    {"url":"/km/carmng/km_carmng_application/kmCarmngApplication.do?method=listApplicationByIds&fdApplicationIds=${JsParam.fdApplicationIds}"}
		</ui:source>
		<ui:render type="Template">
			if(data.length < 1) {
			{$
				<div>
					${ lfn:message('message.noRecord') }
				</div>
			$}
			}
			if(data.length > 0) {
				//HTML转义
				function HTMLEncode(html) {
					var temp = document.createElement("div");
					(temp.textContent != null) ? (temp.textContent = html) : (temp.innerText = html);
					var output = temp.innerHTML;
					temp = null;
					return output;
				} 
				for(var i=0; i < data.length; i++){
					{$
					<div class="lui_carmng_app_wrap">
						<a href="${LUI_ContextPath}/km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId={%data[i].fdId%}" target="_blank">
						<h2 class="carmng_app_title">{% HTMLEncode(data[i].docSubject) %}</h2></a>
						
		 
				<table class="tb_normal" width="100%"> 
					<tbody> 
						<tr>
							<td class="td_normal_title" width="15%">${lfn:message("km-carmng:kmCarmngApplication.fdApplicationReason")}</td>
							<td>  {% HTMLEncode(data[i].fdApplicationReason) %}</td> 
						</tr>
					</tbody>
				</table>
				
						<div class="carmng_app_sheet">
							<div class="carmng_app_detail">
								<div class="carmng_app_detail_header">
									<div class="carmng_app_item">
										<p class="carmng_app_item_title">${lfn:message("km-carmng:kmCarmngApplication.fdApplicationPersonAndPhone")}</p>
										<p>	{% data[i].fdApplicationPersonName %}  {% data[i].fdApplicationPersonPhone %}</p>
									</div>
									<div class="carmng_app_item">
										<p class="carmng_app_item_title">${lfn:message("km-carmng:kmCarmngApplication.fdUserNumber")}</p>
										<p>{% data[i].fdUnerNumber %}<bean:message bundle="km-carmng" key="kmCarmngDispatchersInfo.fdUserNumber"/></p>
									</div>
								</div>
								<div class="carmng_app_passenger">
								$}
									if(data[i].fdUserPersons){
										{$
											<div class="passenger_in"><em>${lfn:message("km-carmng:kmCarmngApplication.fdUserPersons.inner")}:</em><span><c:out value="{% data[i].fdUserPersons %}"></c:out></span></div>
										$}
									}
									if(data[i].fdOtherUsers){
										{$
											<div class="passenger_out"><em>${lfn:message("km-carmng:kmCarmngApplication.fdUserPersons.outer")}:</em><span><c:out value="{% data[i].fdOtherUsers %}"></c:out> </span></div>
										$}
									}
								{$	
								</div>
							</div>
							<div class="carmng_app_route">
								<h3 class="carmng_route_title">${lfn:message("km-carmng:kmCarmngApplication.fdApplicationPath")}</h3>
								<div class="lui_carnming_rotue_tb">
								$}
								if(data[i].fdDeparture && data[i].fdDestination){
									{$
									<table>
										<tr>
											<td class="td_title">${lfn:message("km-carmng:kmCarmngApplication.fdDeparture")}</td>
											<td>
												<div class="inputselectsgl">
													<div class="input">
														<span>{% data[i].fdDeparture %}</span>
													</div>
													<div data-location-icon="lui_map_icon" class="lui_map_icon"></div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="td_title">${lfn:message("km-carmng:kmCarmngApplication.fdDestination")}</td>
											<td>
												<div class="inputselectsgl">
													<div class="input">
														<span>{% data[i].fdDestination %}</span>
													</div>
													<div data-location-icon="lui_map_icon" class="lui_map_icon"></div>
												</div>
											</td>
										</tr>
										$}
											var path = data[i].fdApplicationPath;
											for(var j = 0; j < path.length; j++ ){
												{$
													<tr>
														<td class="td_title"></td>
														<td>
															<div class="inputselectsgl">
																<div class="input">
																	<span> {% path[j].fdDestination%}</span>
																</div>
																<div data-location-icon="lui_map_icon" class="lui_map_icon"></div>
															</div>
														</td>
													</tr>
												$}
											}
										{$
									</table>
									$}
								}else{
									{$
										<table>
										<tr>
											<td class="td_title">${lfn:message("km-carmng:kmCarmngApplication.fdApplicationPath")}:</td>
											<td>
												<div class="inputselectsgl">
													<div class="input">
														<span>{% data[i].fdPath %}</span>
													</div>
													<div data-location-icon="lui_map_icon" class="lui_map_icon"></div>
												</div>
											</td>
										</tr>
										</table>
									$}
								}
								{$
								</div>
							</div>
						</div>
					</div>
					$}
				}
			}
		</ui:render>
	</ui:dataview>
