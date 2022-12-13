<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmProjectMain" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<list:data-column  property="fdName" title="${ lfn:message('km-keydata-project:kmProjectMain.fdName') }" style="text-align:center;min-width:160px">
		</list:data-column>
		<list:data-column headerClass="width140" property="fdCode" title="${ lfn:message('km-keydata-project:kmProjectMain.fdCode') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdExecutiveDept.fdName" title="${ lfn:message('km-keydata-project:kmProjectMain.fdExecutiveDept') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="fdStatus" title="${ lfn:message('km-keydata-project:kmProjectMain.fdStatus') }">
		</list:data-column>
		<list:data-column headerClass="width100" property="docCreator.fdName" title="${ lfn:message('km-keydata-project:kmProjectMain.docCreator') }">
		</list:data-column>
		<list:data-column headerClass="width100" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">		
					<kmss:auth requestURL="/km/keydata/project/km_project_main/kmProjectMain.do?method=edit&fdId=${kmProjectMain.fdId}">
						<a class="btn_txt" href="javascript:edit('${kmProjectMain.fdId}')">${lfn:message('button.edit')}</a>
				    </kmss:auth>    
				    <c:if test="${kmProjectMain.fdIsAvailable==true}">
						<kmss:auth requestURL="/km/keydata/project/km_project_main/kmProjectMain.do?method=updateAvailable&fdId=${kmProjectMain.fdId}">
							<a class="btn_txt" href="javascript:disableAll('${kmProjectMain.fdId}')">${lfn:message('km-keydata-base:keydata.setInvalidated')}</a>
						</kmss:auth>
					</c:if>
					<c:if test="${kmProjectMain.fdIsAvailable==false}">
						<kmss:auth requestURL="/km/keydata/project/km_project_main/kmProjectMain.do?method=updateAvailable&fdId=${kmProjectMain.fdId}">
							<a class="btn_txt" href="javascript:enableAll('${kmProjectMain.fdId}')">${lfn:message('km-keydata-base:keydata.setValidated')}</a>
						</kmss:auth>
					</c:if>			
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>