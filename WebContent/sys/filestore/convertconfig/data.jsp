<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="sysFileConvertConfig" list="${queryPage.list }"
		varIndex="status">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="index">
		      ${status+1}
		</list:data-column>
		<list:data-column property="fdFileExtName"
			title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdFileExtName') }"
			escape="false" style="text-align:center">
		</list:data-column>
		<list:data-column property="fdModelName"
			title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdModelName') }"
			escape="false" style="text-align:center">
		</list:data-column>
		<list:data-column col="fdConverterKey"
			title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterKey.Type') }"
			escape="false" style="text-align:center">
			<c:choose>
				<c:when
					test="${ sysFileConvertConfig.fdConverterKey == 'image2thumbnail' }">
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterKey.image2thumbnail') }"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'toJPG' }">
						<c:out
							value="JPG"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'toHTML' }">
						<c:out
							value="HTML"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'toOFD' }">
						<c:out
							value="OFD"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'toPDF' }">
						<c:out
							value="PDF"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'videoToMp4' }">
						<c:out
							value="MP4"></c:out>
				</c:when>
			</c:choose>
			<%-- <c:choose>
				<c:when
					test="${ sysFileConvertConfig.fdConverterKey == 'image2thumbnail' }">
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterKey.image2thumbnail') }"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'toHTML' }">
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterKey.toHTML') }"></c:out>
				</c:when>
				<c:when test="${ sysFileConvertConfig.fdConverterKey == 'toWpsCloud' }">
					<c:out
						value="上传到WPS云文档"></c:out>
				</c:when>
				<c:when
					test="${ sysFileConvertConfig.fdConverterKey == 'videoToFlv' }">
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterKey.videoToFlv') }"></c:out>
				</c:when>
			</c:choose> --%>
		</list:data-column>
		<list:data-column col="fdStatus"
			title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdStatus') }"
			escape="false" style="text-align:center">
			<c:choose>
				<c:when test="${ sysFileConvertConfig.fdStatus == '1' }">
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdStatus.1') }"></c:out>
				</c:when>
				<c:otherwise>
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdStatus.0') }"></c:out>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<list:data-column col="fdConverterType"
			title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType') }"
			escape="false" style="text-align:center">
			<c:if
				test="${ sysFileConvertConfig.fdConverterKey != 'image2thumbnail' }">
					<c:choose>
						<c:when test="${ sysFileConvertConfig.fdConverterType == 'yzdcs' }">
							<c:out
								value="永中DCS"></c:out>
						</c:when>
						<c:when test="${ sysFileConvertConfig.fdConverterType == 'wps' }">
							<c:out
								value="WPS在线预览"></c:out>
						</c:when>
						<c:when test="${ sysFileConvertConfig.fdConverterType == 'skofd' }">
							<c:out
								value="数科OFD转换"></c:out>
						</c:when>
						<c:when test="${ sysFileConvertConfig.fdConverterType == 'dianju' }">
							<c:out
									value="点聚OFD转换"></c:out>
						</c:when>
						<c:otherwise>
							<c:out
								value="ASPOSE"></c:out>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if
				test="${ sysFileConvertConfig.fdConverterKey == 'image2thumbnail' }">
				<c:out
					value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType.notneed') }"></c:out>
			</c:if>
		</list:data-column>
		<%-- <list:data-column col="fdConverterType"
			title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType') }"
			escape="false" style="text-align:center">
			<c:if
				test="${ sysFileConvertConfig.fdConverterKey != 'image2thumbnail' }">
				<c:choose>
					<c:when test="${ sysFileConvertConfig.fdConverterType == 'yozo' }">
						<c:out
							value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType.yozo') }"></c:out>
					</c:when>
					<c:when test="${ sysFileConvertConfig.fdConverterType == 'wps' }">
						<c:out
							value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType.wpsCloud') }"></c:out>
					</c:when>
					<c:otherwise>
						<c:out
							value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType.aspose') }"></c:out>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if
				test="${ sysFileConvertConfig.fdConverterKey == 'image2thumbnail' }">
				<c:out
					value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdConverterType.notneed') }"></c:out>
			</c:if>
		</list:data-column> --%>
	<%-- 	<c:choose>
			<c:when
				test="${ sysFileConvertConfig.fdFileExtName == 'rtf' || sysFileConvertConfig.fdFileExtName == 'doc' || sysFileConvertConfig.fdFileExtName == 'docx' || sysFileConvertConfig.fdFileExtName == 'ppt'|| sysFileConvertConfig.fdFileExtName == 'pptx'|| sysFileConvertConfig.fdFileExtName == 'pdf'|| sysFileConvertConfig.fdFileExtName == 'wps' }">
				<c:choose>
					<c:when test="${ sysFileConvertConfig.fdHighFidelity == '1' }">
						<list:data-column col="fdHighFidelity"
							title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdHighFidelity') }"
							escape="false" style="text-align:center;color:red;font-weight:bold;">
							<c:out
								value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdHighFidelity.1') }"></c:out>
						</list:data-column>
					</c:when>
					<c:otherwise>
						
						<list:data-column col="fdHighFidelity"
							title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdHighFidelity') }"
							escape="false" style="text-align:center;color:red;">
							<c:out
								value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdHighFidelity.0') }"></c:out>
						</list:data-column>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<list:data-column col="fdHighFidelity"
					title="${ lfn:message('sys-filestore:sysFileConvertConfig.fdHighFidelity') }"
					escape="false" style="text-align:center;">
					<c:out
						value="${ lfn:message('sys-filestore:sysFileConvertConfig.fdHighFidelity.notsupported') }"></c:out>
				</list:data-column>
			</c:otherwise>
		</c:choose> --%>
		<list:data-column headerClass="width200" col="operations"
			title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
				<c:if test="${ sysFileConvertConfig.fdConverterType != 'wps' && sysFileConvertConfig.fdConverterType != 'skofd' && sysFileConvertConfig.fdConverterType != 'dianju'}">
					<kmss:auth
						requestURL="/sys/filestore/sys_filestore/sysFileConvertConfig.do?method=edit&fdId=${sysFileConvertConfig.fdId}"
						requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt"
							href="javascript:editConvertConfig('${sysFileConvertConfig.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
				 </c:if>
					<c:if test="${ sysFileConvertConfig.fdConverterType != 'wps' && sysFileConvertConfig.fdConverterType != 'skofd' && sysFileConvertConfig.fdConverterType != 'dianju'}">
						<kmss:auth
							requestURL="/sys/filestore/sys_filestore/sysFileConvertConfig.do?method=delete&fdId=${sysFileConvertConfig.fdId}"
							requestMethod="POST">
							<!-- 删除 -->
							<a class="btn_txt"
								href="javascript:delConfigs('${sysFileConvertConfig.fdId}')">${lfn:message('button.delete')}</a>
						</kmss:auth>
					 </c:if>
					<kmss:authShow roles="SYSROLE_ADMIN">
						<c:choose>
							<c:when test="${ sysFileConvertConfig.fdStatus == '1' }">
								<a class="btn_txt"
									href="javascript:changeConvertConfigStatus('disablechoose', '${sysFileConvertConfig.fdId}');">${lfn:message('sys-filestore:filestore.convertconfig.disablechoose')}</a>
							</c:when>
							<c:when test="${ sysFileConvertConfig.fdStatus == '0' }">
								<a class="btn_txt"
									href="javascript:changeConvertConfigStatus('enablechoose', '${sysFileConvertConfig.fdId}');">${lfn:message('sys-filestore:filestore.convertconfig.enablechoose')}</a>
							</c:when>
						</c:choose>
					</kmss:authShow>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>