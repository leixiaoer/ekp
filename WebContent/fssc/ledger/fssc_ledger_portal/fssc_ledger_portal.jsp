<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/fssc/base/resource/jsp/jshead.jsp" %>
<script type="text/javascript" src="${LUI_ContextPath}/resource/js/common.js"></script>
<link rel="stylesheet" type="text/css" href="${KMSS_Parameter_ContextPath}fssc/ledger/resource/css/common.css" /> 
<link rel="stylesheet" type="text/css" href="${KMSS_Parameter_ContextPath}fssc/ledger/resource/css/main.css" /> 
<script>
Com_IncludeFile("jquery.js");
</script>
<script type="text/javascript">
	$(document).ready(function (){
	});
</script>
<html>
<body>
		<div class="leaderBorder-container">
					<div id="fsBaseSapEvidenceExpenseTd"></div>
		</div>
</body>
<script type="text/javascript" src="${KMSS_Parameter_ContextPath}fssc/ledger/resource/js/template-web.js" charset="UTF-8"></script>
<script>
window.onload=function (){
	FS_loadEvidenceExpense();
};
/*********
 * 加载凭证内容
 */
function FS_loadEvidenceExpense(){
	 $.ajax({
		  url: Com_Parameter.ContextPath+"fssc/ledger/fssc_ledger_credit/fsscLedgerCredit.do?method=getMonthScore&rowsize=10",
		  dataType:"json",
		  success: function(data){
			  console.log(data)
			  $("#fsBaseSapEvidenceExpenseTd").html(template('test',data));
		  },
		  error: function(XMLHttpRequest, textStatus, errorThrown) {
              if(XMLHttpRequest.status==403)
              {
                  alert("error");
              }
              else
              {
            	  alert('error'+XMLHttpRequest.status);
              }
          }
		});
}
</script>
<script id="test" type="text/html">

					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contract-tab-table" >
						<thead>
           					 <tr>
             					 <th><span class="table-th-span">排名<span></th>
              					<th class="table-th-name"><span>姓名<span></th>
              					<th><span>信用分值<span></th>
            				</tr>
         				</thead>
          				<tbody id="tbody" class="tbody-line">
				
							{{each personalIntegrals as value index}} 
								{{if value.fdOrder <= 3}}
									<tr>
              <td><span class="span-r{{value.fdOrder}}">1</span></td>
              <td>
                <div class="tbody-div-complex">
                  <div class="tbody-div-pic">
                    <img src="${KMSS_Parameter_ContextPath}{{value.imgUrl}}">
                  </div>
                   <p><a target="_blank" href="${KMSS_Parameter_ContextPath}sys/person/sys_person_zone/sysPersonZone.do?method=view&fdId={{value.fdId}}">{{value.fdName}}</a></p>
                </div>
              </td>
              <td><p class="bottomSpan-r{{value.fdOrder}}">{{value.score}}<p></td>
            </tr>
								{{/if}}

{{if value.fdOrder > 3}}
					<tr>
                  <td><span class="span-normal">{{value.fdOrder}}</span></td>
                  <td>
                    <div class="tbody-div-complex">
                      <div class="tbody-div-pic">
                        <img src="${KMSS_Parameter_ContextPath}{{value.imgUrl}}">
                      </div>
                       <p><a target="_blank" href="${KMSS_Parameter_ContextPath}sys/person/sys_person_zone/sysPersonZone.do?method=view&fdId={{value.fdId}}">{{value.fdName}}</a></p>
                    </div>
                  </td>
                  <td><p class="bottomSpan-normal">{{value.score}}<p></td>
                </tr>
{{/if}}

							 </tbody>
				{{/each}} 
					</table>
</script>
</html>
