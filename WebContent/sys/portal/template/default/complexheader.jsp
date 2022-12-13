<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/portal/template/default/reimbursement.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/portal/portal.tld" prefix="portal"%>
<%@ include file="/sys/portal/sys_portal_notice/import/sysPortalNotice_view.jsp"%>
<%@ include file="/sys/portal/pop/import/view.jsp"%>
<%@ include file="/sys/portal/header/config.jsp"%>
<div class="lui_portal_header_complex_frame${ param['scene'] eq 'portal' ? '' : ' ' }">
	<div style="width: ${ empty param['width'] ? '980px' : param['width'] };min-width:980px;max-width:${fdHeaderMaxWidth}" class="lui_portal_header_complex_content clearfloat">
		<div class="lui_portal_header_complex_logo">
			<portal:logo />
		</div>
		<div class="lui_portal_header_complex_portal">
			<c:if test="${ param['showPortal']==null || param['showPortal']=='true' || param['showPortal']=='1' || param['showPortal']=='2'}">
			 <div class="lui_portal_header_complex_portal_switch"><%-- 切换门户 --%>
				<div class="lui_portal_header_text" data-lui-switch-class="lui_portal_header_text_over">
					${lfn:message('sys-portal:header.msg.switchportal')}
					<div class="lui_icon_s lui_portal_header_icon_arrow"></div>
					<ui:popup align="down-left" borderWidth="2">
						<c:if test="${param['showPortal']=='2' }">	
							<div class="lui_portal_complex_popup_container" style="width:600px;padding: 8px; background:white;max-height:500px;overflow-y: auto;overflow-x: hidden;">
								<ui:dataview format="sys.ui.treeMenu2">
									<ui:source type="AjaxJson">
										{"url":"/sys/portal/sys_portal_portlet/sysPortalPortlet.do?method=portalNavTree"}
									</ui:source>
									<ui:render ref="sys.ui.treeMenu2.portal2" cfg-for="switchPortal"></ui:render>
								</ui:dataview>
							</div>
						</c:if>
						<c:if test="${param['showPortal']!='2' }">
							<div class="lui_portal_complex_popup_container" style="width:160px;max-height:500px;background:white;overflow-y: auto;overflow-x: hidden;">
								<ui:dataview>
									<ui:source type="AjaxJson">
										{"url":"/sys/portal/sys_portal_main/sysPortalMain.do?method=portal"}
									</ui:source>
									<ui:render ref="sys.ui.treeMenu.flat" />
								</ui:dataview>
							</div>
						</c:if>
					</ui:popup>
				</div>
			</div><%-- 切换门户 --%>
			</c:if>
		</div>
		<c:if test="${ param['showSearch']==null || param['showSearch']=='true' }">
			<div class="lui_portal_header_complex_search">
				<portal:widget file="/sys/ftsearch/portal/search.jsp"></portal:widget>
			</div>
		</c:if>
		<div class="lui_portal_header_complex_person">
			<%-- <kmss:ifModuleExist path="/third/ywork/">
              <script type="text/javascript">
                  Com_IncludeFile("jquery.js", null, "js");
              </script>
              <script>
                  $(function(){
                      var url = '<c:url value="/third/ywork/ywork_doc/yworkDoc.do?method=isOpen" />';
                      $.post(url,function(data){
                          if(data.status=="0"){
                              $("#wxshareportal").hide();
                          }
                      },"json");
                  });
              </script>
              <c:if test="${ param['showYworkCode']==null  || param['showYworkCode']=='true' }">
                  <div class="lui_portal_header_favorite" id="wxshareportal">
                      <portal:widget file="/third/ywork/ywork_share/yworkDoc_indexcode.jsp"></portal:widget>
                  </div>
              </c:if>
            </kmss:ifModuleExist> --%>
			
		    <c:if test="${ param['showWarningreport']==null  || param['showWarningreport']=='true' }">
			  <div class="lui_portal_header_hitch">
                 <span> <a class="lui_portal_header_text" id ="_qywechat">
	                     <div class="lui_icon_s lui_icon_hitch"> </div>
	                     ${lfn:message('sys-portal:portlet.header.var.warningreport')}
                       </a>
                </span>
                <div id="_qywechatimg"></div>
             </div>
			</c:if>
			
			<c:if test="${ param['showNotify']==null  || param['showNotify']=='true' }">
				<div class="lui_portal_header_notify">
					<portal:widget file="/sys/notify/portal/count.jsp">
						<portal:param name="refreshTime" value="${empty param['refreshTime'] ? '' : param['refreshTime'] }" />
					</portal:widget>
				</div>
			</c:if>
			<c:if test="${ param['showFavorite']==null  || param['showFavorite']=='true' }">
				<div class="lui_portal_header_favorite">
					<portal:widget file="/sys/bookmark/portal/favorite.jsp"></portal:widget>
				</div>
			</c:if>
			<c:if test="${ param['showPerson']==null  || param['showPerson']=='true' }">
				<div class="lui_portal_header_userinfo">
					<portal:widget file="/sys/person/portal/userinfo.jsp"></portal:widget>
				</div>
			</c:if>
		</div>
	</div>
	<div style="width: ${ empty param['width'] ? '980px' : param['width'] };min-width:980px;max-width:${fdHeaderMaxWidth}" class="lui_portal_header_complex_menu clearfloat">
		<portal:widget file="/sys/portal/header/menu.jsp"></portal:widget>
	</div>
</div>

<script type="text/javascript">
var messagetips='<bean:message key="portlet.header.var.warninginfor" bundle="sys-portal"/>';
Com_IncludeFile("ticketcode.js",'${LUI_ContextPath}/sys/portal/designer/js/',"js",true);
</script>