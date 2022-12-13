<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript">
var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.geesun.annual.model.GeesunAnnualMain";
seajs.use(['lui/jquery', 'lui/dialog','lui/topic','lui/toolbar'],function($, dialog, topic, toolbar) {
	window.addDoc = function(){
		Com_OpenWindow("${LUI_ContextPath}/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=add");
	}
	//删除
	window.delDoc = function(){
		var values = [];
		$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
		if(values.length==0){
			dialog.alert('<bean:message key="page.noSelect"/>');
			return;
		}
		var url  = '<c:url value="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=deleteall"/>';
		dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(value){
			if(value==true){
				window.del_load = dialog.loading();
				$.ajax({
					url: url,
					type: 'POST',
					data:$.param({"List_Selected":values},true),
					dataType: 'json',
					error: function(data){
						if(window.del_load!=null){
							window.del_load.hide(); 
						}
						dialog.result(data.responseJSON);
					},
					success: delCallback
			   });
			}
		});
	};
	window.delCallback = function(data){
		if(window.del_load!=null){
			window.del_load.hide(); 
			topic.publish("list.refresh");
		}
		dialog.result(data);
	};
	//根据地址获取key去匹配替换参数
	window.replaceByHash = function(key, url){
	    if(url.indexOf(key)<0){
	        return url;
	    }
		var reg = new RegExp("(^|;)"+ key +":", "gm");
	    return url.replace(reg, "&q."+key+"=");
	};
	
});
	//下载员工假期信息初始化模板
	function downloadUpdateTemplate(){
		seajs.use(['lui/jquery', 'lui/dialog' ,'lui/topic'],function($,dialog, topic) {
			javascript:location.href='<c:url value="/geesun/annual/geesun_annual_main/geesunAnnualMain.do" />?method=downloadTableImport';
		});
	}
	
	//根据地址获取key去匹配替换参数
    window.replaceByHash = function(key, url){
        if(url.indexOf(key)<0){
            return url;
         }
		    var reg = new RegExp("(^|;)"+ key +":", "gm");
	    return url.replace(reg, "&q."+key+"=");
    };

	//导出员工假期信息
		window.exportAnnuals = function(){
			seajs.use(['lui/jquery', 'lui/dialog' ,'lui/topic'],function($,dialog, topic) {
 			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
			var urlPost  = '<c:url value="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=exportAnnuals"/>';
			if(values.length==0) {
				var hash = window.location.hash;
				if("" != hash && hash.indexOf("cri.q=")>0){
					var url = hash.split("cri.q=")[1];
	            	url = replaceByHash("fdOwnerNo", url);
	            	url = replaceByHash("fdOwner", url);
	            	url = replaceByHash("docDept", url);
	            	url = replaceByHash("fdTotal", url);
	            	urlPost = urlPost + url;
                }
			}
			var args = [["selectIds",values]];
			openPostWindow(urlPost, args);
			});
	};
	
	window.openPostWindow = function(url, args, name){
		var tempForm = document.createElement("form");
		tempForm.id="tempForm";
		tempForm.method="post";
		tempForm.action=url;
		tempForm.target=name;
		tempForm.style.display="none";
		
	    //可传入多个参数
		for(var i=0; i<args.length; i++){
		   var hideinput=document.createElement("input");
		   hideinput.type="hidden";  
		   hideinput.name=args[i][0]; 
		   hideinput.value=args[i][1];
		   tempForm.appendChild(hideinput); 
		}
	    document.body.appendChild(tempForm);
	    //tempForm.fireEvent("onsubmit");
	    tempForm.submit();
	    document.body.removeChild(tempForm); 
	};
	
	//初始化年假信息批量导入页面
	function initAnnualInfo(){
		seajs.use(['lui/jquery', 'lui/dialog' ,'lui/topic'],function($,dialog, topic) {
			Com_OpenWindow('<c:url value="/geesun/annual/geesun_annual_main/geesunAnnualMain_initAnnualInfos.jsp"/>');
		});
	}
	
</script>
		<!-- 查询条件  -->
        <list:criteria id="criteria1">
            <list:cri-ref key="fdOwnerNo" ref="criterion.sys.docSubject" title="${lfn:message('geesun-annual:geesunAnnualMain.fdOwnerNo')}" />
            <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualMain" property="fdOwner" />
            <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualMain" property="docDept" />
            <list:cri-auto modelName="com.landray.kmss.geesun.annual.model.GeesunAnnualMain" property="fdTotal" />

        </list:criteria>
		 
		<!-- 列表工具栏 -->
		<div class="lui_list_operation">
			<table width="100%">
				<tr>
					<div style='color: #979797;float: left;padding-top:1px;'>
						${ lfn:message('list.orderType') }：
					</div>
					<div style="float:left">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left" >
								<list:sort property="docCreateTime" text="${lfn:message('geesun-annual:geesunAnnualMain.docCreateTime') }" group="sort.list" value="up"></list:sort>
							</ui:toolbar>
						</div>
					</div>
					<div style="float:left;">	
						<list:paging layout="sys.ui.paging.top" > 		
						</list:paging>
					</div>
					<div style="float:right">
						<div style="display: inline-block;vertical-align: middle;">
							<ui:toolbar id="Btntoolbar">
								<kmss:authShow roles="ROLE_GEESUNANNUAL_ADMIN">
									<ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="1"></ui:button>
									<ui:button text="${lfn:message('geesun-annual:geesunAnnualMain.export.downloadTemplate')}"  onclick="downloadUpdateTemplate();" order="2"/> 
									<ui:button text="${lfn:message('geesun-annual:geesunAnnualMain.initAnnualInfo')}"  onclick="initAnnualInfo();" order="3"/>
									<ui:button text="${lfn:message('geesun-annual:geesunAnnualMain.export.annualInfo')}"  onclick="exportAnnuals();" order="4"/>
									<ui:button id="del" text="${lfn:message('button.delete')}" order="5" onclick="delDoc()"></ui:button>
								</kmss:authShow>
							</ui:toolbar>
						</div>
					</div>
				</tr>
			</table>
		</div>
		
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		 
	 	<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=data'}
			</ui:source>
			<!-- 列表视图 -->	
			<list:colTable isDefault="true" name="columntable" layout="sys.ui.listview.columntable" rowHref="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=view&fdId=!{fdId}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdOwner.name;fdOwnerNo;docDept.name;fdTotal;docCreateTime"></list:col-auto>
			</list:colTable>
		</list:listview> 
		 
	 	<list:paging></list:paging>	 