<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>
	require(['dojo/topic',"dojo/_base/array","dojo/dom-construct","dojo/dom-class","dojo/dom-attr",
	         'dojo/ready',"dojo/store/Memory",'dojo/parser',"dojo/on","mui/dialog/Tip","mui/dialog/Confirm",
	         'dijit/registry',"mui/util","mui/device/adapter","dojo/dom-style","dojo/dom","dojo/query","dojo/request","dojox/mobile/sniff"
	         ],function(topic,array,domConstruct,domClass,domAttr,ready,Memory,parser,on,Tip,Confirm,registry,util,adapter,
	        		 domStyle,dom,query,request,has){
        		var validorObj = null;
        		ready(function(){
        			initRow();
        			validorObj=registry.byId('scrollView');
        			//自定义校验器:正整数校验器
    				validorObj._validation.addValidator('minInteger','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.positive.min.integer" /></span>',function(v, e, o){
    					var result = true;
    					var fdMinOption=$('[name="fdMinOption"]');
    					if(fdMinOption.val()){
    					    if (!(/(^[1-9]\d*$)/.test(fdMinOption.val())))
    					    {
    							result = false;
    					    }
    					}		
    					return result;
    				});
    				
    				//自定义校验器:正整数校验器
    				validorObj._validation.addValidator('maxInteger','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.positive.max.integer" /></span>',function(v, e, o){
    					var result = true;
    					var fdMaxOption=$('[name="fdMaxOption"]');
    					if(fdMaxOption.val()){
    						if (!(/(^[1-9]\d*$)/.test(fdMaxOption.val())))
    					    {
    							result = false;
    					    }
    					}			
    					return result;
    				});
    				
    				//自定义校验器:最小可选项数必须小于投票选项行数
    				validorObj._validation.addValidator('compareRows','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.min.optional.less.rows" /></span>',function(v, e, o){
    					var result = true;
    					var fdMinOption=$('[name="fdMinOption"]');
    					var rowCount = getInputCount($("input[name='fdStyle']").val());
    					if( fdMinOption.val()){
    						var min=parseInt(fdMinOption.val());
    						if(min >= rowCount){
    							result = false;
    						}
    					}
    					return result;
    				});
    				
    				//自定义校验器:最大可选项数必须大于或等于最小可选项数！
    				validorObj._validation.addValidator('compareSize','<span class="validation-advice-title"><bean:message bundle="km-vote" key="error.max.greater.than.min" /></span>',function(v, e, o){
    					var result = true;
    					var fdMinOption=$('[name="fdMinOption"]');
    					var fdMaxOption=$('[name="fdMaxOption"]');
    					if( fdMinOption.val() && fdMaxOption.val() ){
    						var min=parseInt(fdMinOption.val());
    						var max=parseInt(fdMaxOption.val());
    						if(max<min){
    							result = false;
    						}
    					}
    					return result;
    				});
        			topic.subscribe('/kmVote/isMul/change',_onIsMulChange);
        			domAttr.set(query('.muivotePersons .muiCateFiledShow')[0],'placeholder','<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.fdVoters.tip" />');
        			domAttr.set(query('.muivoteExcPersons .muiCateFiledShow')[0],'placeholder','<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.no" />');
        		});
         		window._onIsMulChange = function(obj,evt){
         			var v = "";
         			if(evt.value){
         				v = "none";
         			}
         			domStyle.set(dom.byId('tr_isMul'),'display',v);
         		};
         		window.showOtherInfo = function(){
         			setTimeout(function(){
         				var fdVoterIds = document.getElementsByName("fdVoterIds")[0].value;
        				if(fdVoterIds){
        					domStyle.set(dom.byId('tr_notify'),'display','');
        				}else{
        					domStyle.set(dom.byId('tr_notify'),'display','none');
        					document.getElementsByName("fdVoterIds")[0].value="";
        					document.getElementsByName("fdVoterNames")[0].value="";
        
        					document.getElementsByName("fdNotifyType")[0].value="";
        					var tbObj = dom.byId("notifyType");
        					var field = tbObj.getElementsByTagName("INPUT");
        					for(var i=1; i<field.length; i++){
        						field[i].checked =false;
        					}
        					document.getElementsByName("fdNotifyType")[0].value="";
        				}
         			},1);
         			
         		};
 
    			window.changeStyle = function (value) {	
    				$("input[name='fdStyle']").val(value);	//记录投票类型，1为文字投票，2为图片投票	
    				var index = getInputCount(value);
    				delIconOperation(index,value);	
    				if("1" == value) {
    					//选择了文字投票
    					$("#word_vote").show();
    					$("#word_vote_tabpanel").addClass("lui_vote_tabpanel_on");
    					$("#image_vote").hide();
    					$("#image_vote_tabpanel").removeClass("lui_vote_tabpanel_on");
    					//切换的时候，也更新多选项的最多可选项
    					addOption();
    					
    					query('#word_vote .muiInput').forEach(function(node){
							domAttr.remove(node,'disabled');
							var obj = registry.byNode(node.parentNode);
							obj.edit=true;
						});
    				} else if("2" == value) {
    					//选择了图片投票
    					$("#word_vote").hide();
    					$("#word_vote_tabpanel").removeClass("lui_vote_tabpanel_on");
    					$("#image_vote").show();
    					$("#image_vote_tabpanel").addClass("lui_vote_tabpanel_on");
    					//切换的时候，也更新多选项的最多可选项
    					addOption();
    					query('#image_vote .muiInput').forEach(function(node){
    						domAttr.remove(node,'disabled');
							var obj = registry.byNode(node.parentNode);
							obj.edit=true;
						});
    				}
    			};
    			
    			window.initRow = function() {
    				var method = "${kmVoteMainForm.method_GET}";
    				if(method == "add"){
    					// 初始添加3个候选项
    					setTimeout(function() {
    						for(var i=0; i<2; i++) {
    							var newRow1 = DocList_AddRow("TABLE_DocList_word");
    							var newRow2 = DocList_AddRow("TABLE_DocList_image");
    							parser.parse(newRow1);
    							parser.parse(newRow2);
    						}
    						var fdStyle = $("input[name='fdStyle']").val();
    						var index = getInputCount(fdStyle);
    						delIconOperation(index,fdStyle);
    						addOption();
    					}, 500);
    				}else{
    					
    				}
    			};
    			
    			window.getInputCount = function(style){
    				var opt = "TABLE_DocList_word";
    				if(style == '1'){
    					opt = "TABLE_DocList_word";
    				}else if(style == '2'){
    					opt = "TABLE_DocList_image";
    				}
    				
    				var tbInfo = DocList_TableInfo[opt];
    				return tbInfo.lastIndex;
    				
    			};
    			//隐藏或显示删除图标
				window.delIconOperation = function(index,fdStyle){
					if(index <= 2){
						if(fdStyle == 1){
							var doms = query("#word_vote .muiDelIcon");
							array.forEach(doms,function(item,index){
								domStyle.set(item,'display','none');
							});
						}else{
							var doms = query("#image_vote .muiDelIcon");
							array.forEach(doms,function(item,index){
								domStyle.set(item,'display','none');
							});
						}
					}else{
						if(fdStyle == 1){
							var doms = query("#word_vote .muiDelIcon");
							array.forEach(doms,function(item,index){
								domStyle.set(item,'display','');
							});
						}else{
							var doms = query("#image_vote .muiDelIcon");
							array.forEach(doms,function(item,index){
								domStyle.set(item,'display','table-cell');
							});
						}
					}
				};
				//候选记录初始化
				window.addOption = function() {
					var fdMaxSelectNum = registry.byId('_fdMaxSelectNum');
					var index = getInputCount($("input[name='fdStyle']").val());
					var datas = [{
						text:'<bean:message bundle="km-vote" key="kmVoteMain.unlimited" />',
						value:0
					}];
					for(var i=1; i<=index; i++) {
						var v = {
							text:'<bean:message bundle="km-vote" key="kmVoteMain.maxSelect" />' + i +'<bean:message bundle="km-vote" key="kmVoteMain.item" />',
							value:i
						}
						datas.push(v);
					}
					fdMaxSelectNum.setStore(new Memory({data: datas}));
				};
				window.AddVoteItem = function(){
					var newRow = DocList_AddRow();
					parser.parse(newRow);
					//当选项多于两条的时候，显示删除按钮
					var fdStyle = $("input[name='fdStyle']").val();
					var index = getInputCount(fdStyle);
					delIconOperation(index,fdStyle);
					addOption();
				};
				window.deleteVoteItem = function(index) {
					if(!index){
						DocList_DeleteRow();
					}else{
						var curTbNode = dom.byId('tb_image_fdVoteItems_'+index);
						DocList_DeleteRow(curTbNode.parentNode.parentNode);
					}				
					var fdStyle = $("input[name='fdStyle']").val();
					var index = getInputCount(fdStyle);				
					delIconOperation(index,fdStyle);
					addOption();
					
					//doclist.js的DocList_DeleteRow删除行操作只会更改name属性的序号，其他的必须自己手动更改
					if(fdStyle == 2){
						var image = $("#TABLE_DocList_image").find("tr[class='vote_tr']");
						for(var i = 0;i < image.length ;i++){
							//更改onchang里面的index
							var imageFile = $(image[i]).find("input[type='file']");
							var imageFileOnChange = imageFile.attr("onchange");
							imageFileOnChange = imageFileOnChange.replace(/([0-9]+)/,i);
							imageFile.attr("onchange",imageFileOnChange);	
							
							//行删除标识
							var delRow = $(image[i]).find("i.muiDelIcon");
							var rowDelClickEvent = delRow.attr("onclick");
							rowDelClickEvent = rowDelClickEvent.replace(/([0-9]+)/,i);
							delRow.attr("onclick",rowDelClickEvent);
							
							var widgetNode = query("[widgetid]",image[i])[0];
							var widget = registry.byNode(widgetNode);
							var name = widget.get('name');
							name = name.replace(/([0-9]+)/,i);
							widget.set('name',name);
							domAttr.set(query('input',widget.valueNode)[0],'name',name);
							
							//更改所有id有index的属性				
							var imageTr = $(image[i]).find("[id]");
							for(var j = 0;j < imageTr.length ;j++){
									var obj = $(imageTr[j]);
									var objId = obj.attr("id");
									objId = objId.replace(/([0-9]+)/,i);
									obj.attr("id",objId);
								}								
							}
						}
				};
				
				window._onSelectImgageClick = function(idx){
					if(has("android")){
						if (event.stopPropagation)
							event.stopPropagation();
						if (event.cancelBubble)
							event.cancelBubble = true;
						if (event.preventDefault)
							event.preventDefault();
						if (event.returnValue)
							event.returnValue = false;
					}

                    // 动态创建一个图片上传控件
                    var input  = document.createElement("input");
                    input.type = "file";
                    input.accept = "image/*";
                    input.name = "optionImageFiles["+idx+"]";
                    document.kmVoteMainForm.appendChild(input);
                    // 监听选中事件
                    input.onchange = function(event) {
                        if(has("android")){
                            if (event.stopPropagation)
                                event.stopPropagation();
                            if (event.cancelBubble)
                                event.cancelBubble = true;
                            if (event.preventDefault)
                                event.preventDefault();
                            if (event.returnValue)
                                event.returnValue = false;
                        }
                        uploadOptionImage(idx, function(rest) {
                            // 删除动态创建的控件
                            document.kmVoteMainForm.removeChild(input);
                        });
                    }
                    input.click();
				};
				
				var imageExt = ['jpg','jpeg','gif','png','bmp'];
				var loading = null;
				window.uploadOptionImage = function(index, cb) {
					var fileName = $("input[name='optionImageFiles["+index+"]']").val();
					var ext = fileName.substr(fileName.lastIndexOf(".") + 1).toLowerCase();
					if(imageExt.indexOf(ext) < 0) {
						Tip.fail({
							text:'<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.pic.tip" />'
						});
						if (cb) {
                            cb();
                        }
						return false;
					}
					
					query('#pageLoading div')[0].innerHTML='<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.pic.uploading" />';
					domStyle.set(query('#pageLoading')[0],{opacity:'0.5',display:'block'});
					
					//改变form的action,name.target,enctype
//					var form = $("form[name='kmVoteMainForm']");
//					form.attr("action","${LUI_ContextPath}/km/vote/km_vote_main_item/kmVoteMainItem.do?method=uploadOptionImage&index=" + index);				
//					form.attr("name","kmVoteMainItemForm_" + index );
//					form.attr("target","optionImageIframe");
//					form.attr("enctype","multipart/form-data");
//					form.submit();
					uploadImages(index, cb);
					
				},
				
				window.uploadImages=function(index, cb){
					var url ="${LUI_ContextPath}/km/vote/km_vote_main_item/kmVoteMainItem.do?method=uploadOptionImage&index=" + index;
					var form = document.kmVoteMainForm;
					var d = new FormData(form);
					request.post(url, {
						data : d,
						handleAs : 'json'
		            }).then(function(result) {
		            	uploadTip(result.type,result.text,result.index,result.url);
                        if (cb) {
                            cb(result);
                        }
		            }, function(result) {
		            	uploadTip('error');
                        if (cb) {
                            cb(result);
                        }
		            });
				},
				
				window.resetForm = function(index) {
					var form = $("form[name='kmVoteMainItemForm_"+index+"']");
					form.attr("action","${LUI_ContextPath}/km/vote/km_vote_main/kmVoteMain.do");
					form.attr("name","kmVoteMainForm");
					form.removeAttr("target");
					form.removeAttr("enctype");
				},
				/*
				*上传提示
				*/
				window.uploadTip = function(type,info,index,downloadUrl) {
					domStyle.set(query('#pageLoading')[0],{backgroundColor:'none',display:'none'});
					if(type=="success"){
						var previewDom = dom.byId('image_upload_preview_box_'+index);
						domConstruct.empty('image_upload_preview_box_'+index);
						
						var imageDom = domConstruct.create('div', {className : 'muiImageIcon'}, previewDom);
						var closeDom = domConstruct.create('div', {className : 'muiImageIconDel'}, previewDom);
						domConstruct.create('i', {className : 'mui mui-close'}, closeDom);
						
						domConstruct.create('img', {className : '',src:downloadUrl,width:40,height:40}, imageDom);
						
						var fdAttrId = downloadUrl.substr(downloadUrl.lastIndexOf("=") + 1);
						domAttr.set(dom.byId('optionImage_'+ index + "_id"),'value',fdAttrId);
						domStyle.set(dom.byId('option_'+ index +  '_tip'),'display','none')
						
						on(closeDom,'click',function(){
							Confirm('<div style="line-height:2rem;"><bean:message  bundle="km-vote" key="mui.kmVoteMainEdit.del.pic.tip"/></div>','',function(value){
								if(value==true){
									domConstruct.empty('image_upload_preview_box_'+index);
									$("input[name='optionImageFiles["+index+"]']").val("");
									domAttr.set(dom.byId('optionImage_'+index+'_id'),'value','');
								}
							});
						});
					}else{
						Tip.fail({
							text:'<bean:message bundle="km-vote" key="mui.kmVoteMainEdit.pic.error" />'
						});
					}
					//resetForm(index);
				}
				window.submitKmVotePostForm=function() {
				    var fdStyle = $("input[name='fdStyle']").val();
				    if(!validateKmVoteMainData()){
						return ;
					}
				    document.getElementsByName("docStatus")[0].value = '30';
			    	if(fdStyle == 1){
				    	$("#image_vote").remove();
				    }else{
				    	$("#word_vote").remove();
					}
					//提交表单校验
					Com_Submit(document.kmVoteMainForm, 'save','fdCategoryId');
				};
				window.validateKmVoteMainData=function(){
					var fdStyle = $("input[name='fdStyle']").val();
					if(fdStyle == "1"){
							//把图片投票选项设为不可用，以免被校验;把校验信息框隐藏，以免出现空框；
							query('#image_vote .muiInput').forEach(function(node){
								domAttr.set(node,'disabled','disabled');
								var obj = registry.byNode(node.parentNode);
								obj.edit=false;
							});
							query('#word_vote .muiInput').forEach(function(node){
								var v = node.value;
								var obj = registry.byNode(node.parentNode);
								obj.set('value',v);
							});
					}else{
							query('#word_vote .muiInput').forEach(function(node){
								domAttr.set(node,'disabled','disabled');
								var obj = registry.byNode(node.parentNode);
								obj.edit=false;
							});
							
							//validorObj.validate()校验时无法获取准确值,重新设置???
							query('#image_vote .muiInput').forEach(function(node){
								var v = node.value;
								var obj = registry.byNode(node.parentNode);
								obj.set('value',v);
							});
					}
					if(!validorObj.validate()){
						resetItemForm();
						return false;
					}
					if(fdStyle != "1"){
						if(!validateImage()){
							resetItemForm();
							return false;
						}
					}
					
					var msg = "";		
					var form = document.forms['kmVoteMainForm'];					
					if(document.getElementsByName("fdIsRadio")[0].checked) {
						form.fdMaxSelectNum.value = "0";
					}
					if(form.fdVoterIds.value == ""){
						//ID("fdNotifyType").value="";
						if(document.getElementsByName("fdNotifyType")[0]){
							document.getElementsByName("fdNotifyType")[0].value="";
						}
					}
					// 例外人员不能为空
					return true;
				};
				window.validateImage = function(){
					//校验图片是否为空
					//var fdAttIds = $("#image_vote").find("input[name*='fdAttId']");
					var fdAttIds = query("#image_vote input[name $=\'fdAttId\']");
					var len = 0;
					for(var i = 0 ; i < fdAttIds.length; i++){
						var value = fdAttIds[i].value;
						var tipNode = query('.muiValidate',fdAttIds[i].parentNode)[0];
						if(value == ""){
							domStyle.set(tipNode,'display','block')
							len++;
						}else{
							domStyle.set(tipNode,'display','none');
						}
					}
					if(len > 0){
						return false;
					}else{
						return true;
					}
				};
				
				window.resetItemForm =  function(){
					query('#image_vote .muiInput').forEach(function(node){
						domAttr.remove(node,'disabled');
						var obj = registry.byNode(node.parentNode);
						obj.edit=true;
					});
					query('#word_vote .muiInput').forEach(function(node){
						domAttr.remove(node,'disabled');
						var obj = registry.byNode(node.parentNode);
						obj.edit=true;
					});
				}
         		
         });
	
</script>