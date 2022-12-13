define([ 'dojo/_base/declare', 'dojo/_base/array', 'dojo/_base/lang' , 'dojo/topic', 'dojo/on',
         'dojo/dom', 'dojo/dom-construct', 'dojo/dom-style', 'dojo/dom-class', 'dojo/dom-attr',
         'dojo/request', 'mhui/form/Input',"dojo/dom-attr"],
	function(declare, array, lang, topic, on, dom, domCtr, domStyle, domClass, domAttr,
			request, FormInput,attr) {
		return declare('sys.task.maxhub.LabelMixin',[FormInput],{
			
			labelText:'',
			filedname:'',
			nameGrop:[],
			validate:false,
			isDisable:false,
			require:false,//是否必填
			inputNode:null,
			extendText:null,
			initialize:function(){					
				var ctx = this;
				if(ctx.editable) {
						inputNode = ctx.inputNode = domCtr.create('input', {
						className: 'mhuiFormInput',
						value: ctx.value,
						type: ctx.type,
						placeholder: ctx.placeholder
					}, ctx.domNode);
					
					if(ctx.disabled){
						inputNode.disabled="disabled";
						//domStyle.set(inputNode,"background-color","#e3e3e3");
					}	
				 }else {
						domCtr.create('span', {
							className: 'mhuiFormLabel',
							innerHTML: ctx.value
						}, ctx.domNode);
				 }
	
					
				
				if(ctx.nameGrop){
					array.forEach(ctx.nameGrop,function(item){
						domCtr.create("input",{type:"hidden",name:item.name,value:item.value},ctx.domNode);
					});
				}
				if(ctx.filedname){
					inputNode.name=ctx.filedname;
				}
				var labelNode = domCtr.create('span',{className:'mhuiTaskLabel',innerHTML:this.labelText});
				domCtr.place(labelNode,this.domNode,'first');
				
				if(ctx.require){
					ctx.dfn = domCtr.create("dfn",{className:"SelectorValidate",innerHTML:"*"},this.domNode);
					ctx.validateComment = domCtr.create("p",{className:"SelectorComment"},this.domNode);
					on(ctx.inputNode,"change",function(){
						ctx.validateRequire(ctx.inputNode);
					});
				}
			
				if(ctx.taskName){	
					ctx.inputNode.value= ctx.taskName;
				}else{
					if(ctx.fdModelId){
						ctx.setValue().then(function(){
							ctx.validateRequire(ctx.inputNode);
						});
						
					}
				}
				
				
				
				
			},
			validateRequire:function(nodObj){
				var ctx  = this;
				if(nodObj.value==""){
					ctx.validateComment.innerHTML="不能为空";
					ctx.validate = false;
				}else{
					ctx.validateComment.innerHTML="";
					ctx.validate = true;
				}
			},
			setValue:function(){
				var ctx = this;
				var taskJsonURL=location.origin + dojoConfig.baseUrl+"sys/task/sys_task_main/sysTaskIndex.do?method=list&fdModelId="+ctx.fdModelId+"&fdModelName=com.landray.kmss.km.imeeting.model.KmImeetingMain";
				return request.post(taskJsonURL).then(function(data){
					var taskOrderId = JSON.parse(data).page.totalSize;
					if(taskOrderId.length<2){
						ctx.inputNode.value=ctx.extendText+"-任务0"+(Number(taskOrderId)+1);
					}else{
						ctx.inputNode.value=ctx.extendText+'-任务'+(Number(taskOrderId)+1);
					}
					
					
				
				});
			}
			
			
			
		});
	}
);