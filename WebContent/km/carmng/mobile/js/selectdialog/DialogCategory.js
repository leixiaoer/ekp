define( [ "dojo/_base/declare", "dojo/_base/array", "dojo/topic", "dojo/on", "dojo/touch",
          "dojo/dom-construct", "dojo/dom-class", "dojo/query","mui/form/_FormBase","km/carmng/mobile/js/selectdialog/_DialogCategoryBase", "dojo/_base/lang","dojo/dom-style"],
		function(declare, array, topic, on, touch, domConstruct, domClass,
				query, FormBase, CategoryBase, lang,domStyle) {
			var _field = declare("mui.selectdialog.DialogCategory", [FormBase, CategoryBase ], {
				
				//id字段名
				idField : null,
				
				//姓名字段名
				nameField : null,
				
				
				placeholder : null,
				
				//自建字段
				isCreateField:true,
				
				//对外事件
				EVENT_VALUE_CHANGE : '/mui/Category/valueChange',
				
				 postMixInProperties:function(){
					this.inherited(arguments);
					if(this.nameField){
						var tmpFileds = query("[name='"+this.nameField+"']");
						if(tmpFileds.length>0) {
							this.isCreateField = false;
							this.opt = false;
						}
					}else if(!this.idDom){
						this.isCreateField = false;
						this.opt = false;
					}
				},
				
				buildRendering : function() {					
					this.inherited(arguments);
					this._buildValue();
					if(this.edit){
						if(!this.isCreateField) this.nameDom.readOnly = true;
						this.connect(this.isCreateField?this.domNode:this.nameDom,'click', function(){
							this.defer(function(){
								this._selectCate();
							},350);
						});
					}
				},
				
				postCreate : function() {
					this.inherited(arguments);
					this.eventBind();
					if(!this.isCreateField){
						domStyle.set(this.domNode,"display","none");
					}
				},
				
				//加载
				startup : function() {
					this.inherited(arguments);
					this.key = this.idField;
					this.set("value",this.curIds);
				},
				
				_buildValue:function(){
					if(this.edit){
						if(this.idField && !this.idDom){
							var tmpFileds = query("[name='"+this.idField+"']");
							if(tmpFileds.length>0){
								this.idDom = tmpFileds[0];
							}else{
								this.idDom = domConstruct.create("input" ,{type:'hidden',name:this.idField},this.valueNode);
							}
						}
						if(this.nameField && !this.nameDom){
							var tmpFileds = query("[name='"+this.nameField+"']");
							if(tmpFileds.length>0){
								this.nameDom = tmpFileds[0];
							}else{
								this.nameDom = domConstruct.create("input" ,{type:'hidden',name:this.nameField},this.valueNode);
							}
						}
						if(!this.idField&&!this.idDom&&!this.nameField&&!this.nameDom){
							var ele = this.domNode;
							while(ele!=null&&ele.tagName!="TD"){
								ele = ele.parentNode;
							}
							if(ele!=null){
								var inputField = ele.getElementsByTagName("INPUT");
								for(var i=0;i<inputField.length;i++){
									if(inputField[i].type=="hidden"){
										this.idDom = inputField[i];
									}else if(this.nameDom==null) this.nameDom = inputField[i];
								}
								if(this.idDom==null) this.idDom = inputField[1];
							}
							
						}
						if(this.idDom){
							if(!this.idField) this.idField = this.idDom.name;
							this.idDom.value = this.curIds==null?'':this.curIds;
						}
						if(this.nameDom){
							if(!this.nameField) this.nameField = this.nameDom.name;
							this.nameDom.value = this.curNames==null?'':this.curNames;
						}
					}
					if(!this.cateFieldShow){
						this.cateFieldShow = domConstruct.create("div" ,{className:'muiCateFiledShow'},this.isCreateField?this.valueNode:this.nameDom.parentNode);
					} else if (lang.isString(this.cateFieldShow)) {
						this.cateFieldShow = query(this.cateFieldShow)[0];
					}
					
					if (this.cateFieldShow && this.edit && !this.cateFieldShow.getAttribute('data-del-listener-' + this.id)) {
						// 用touch.press
						this.connect(this.cateFieldShow, on.selector(".muiAddressOrg", "click"), function(evt) {
							if (evt.stopPropagation)
								evt.stopPropagation();
							if (evt.cancelBubble)
								evt.cancelBubble = true;
							if (evt.preventDefault)
								evt.preventDefault();
							if (evt.returnValue)
								evt.returnValue = false;
							var nodes = query(evt.target).closest(".muiAddressOrg");
							nodes.forEach(function(orgDom) {
								var id = orgDom.getAttribute("data-id");
								this.defer(function() { // 同时关注时，必须要异步处理
									this._delOneOrg(orgDom, id);
								}, 420);
							}, this);
						});
						this.cateFieldShow.setAttribute('data-has-del-listener-' + this.id, 'true');
					}
					domConstruct.empty(this.cateFieldShow);
					this.buildValue(this.cateFieldShow);
				},
				
				buildValue:function(domContainer){
					if(this.curIds!=null && this.curIds!=''){
						var ids = this.curIds.split(this.splitStr);
						var names = this.curNames.split(this.splitStr);
						for ( var i = 0; i < ids.length; i++) {
							this._buildOneOrg(domContainer,ids[i],names[i]);
							if(i < ids.length-1 && !this.edit){
								domConstruct.create("span",{innerHTML:this.splitStr},domContainer);
							}
						}
					}else{
						if(this.edit && this.placeholder!=null && this.placeholder!='')
							domConstruct.create("div",{className:'muiCatePlaceHold', innerHTML:this.placeholder},domContainer);
					}
				},
				
				_buildOneOrg:function(domContainer, id, name){
					var tmpOrgDom = domConstruct.create("div",{className:"muiAddressOrg", "data-id":id},domContainer);
					domConstruct.create("span",{innerHTML:name},tmpOrgDom);
					if(this.edit){
						domClass.add(tmpOrgDom,"muiAddressOrgEdit");
						domConstruct.create("i" ,{className:'mui mui-close'},tmpOrgDom);
					}
				},
				
				_delOneOrg : function(orgDom, id){
					var ids = this.curIds.split(this.splitStr);
					var names = this.curNames.split(this.splitStr);
					var idx = array.indexOf(ids,id);
					if(idx > -1){
						ids.splice(idx,1);
						names.splice(idx,1);
						this.curIds = ids.join(this.splitStr); 
						this.curNames = names.join(this.splitStr);
						if(this.idDom){
							this.idDom.value = this.curIds==null?'':this.curIds;
							this.set("value",this.curIds==null?'':this.curIds);
						}
						if(this.nameDom){
							this.nameDom.value = this.curNames==null?'':this.curNames;
						}
						if(this.curIds==null || this.curIds=='')
							this.buildValue(this.cateFieldShow);
						topic.publish(this.EVENT_VALUE_CHANGE,this,{curIds:this.curIds,curNames:this.curNames});
					}
					domConstruct.destroy(orgDom);
				},
				
				buildOptIcon:function(optContainer){
					domConstruct.create("i" ,{className:'mui mui-org'},optContainer);
				},
				
				returnDialog:function(srcObj , evt){
					this.inherited(arguments);
					if(srcObj.key == this.idField){
						this.set("value",this.curIds);
						this._buildValue();
						topic.publish(this.EVENT_VALUE_CHANGE,this,{curIds:this.curIds,curNames:this.curNames});
					}
				},
				
				clearDialog:function(srcObj , evt){
					this.inherited(arguments);
					if(srcObj.key == this.idField){
						this.set("value",this.curIds);
						this._buildValue();
						topic.publish(this.EVENT_VALUE_CHANGE,this,{curIds:this.curIds,curNames:this.curNames});
					}
				},
				_getNameAttr:function(){
					return this.idField;
				},
				
				_setValueAttr : function(val) {
					this.inherited(arguments);
					this.curIds = val;
					if(this.idDom){
						this.idDom.value = val;
					}
				},
				
				_setCurIdsAttr : function(val) {
					this.curIds = val;
					this.set("value",val);
				},
				
				_setCurNamesAttr : function(val) {
					this.curNames = val;
					if(this.nameDom){
						this.nameDom.value = val;
					}
					this.buildValue(this.cateFieldShow);
				}
				
			});
			return _field;
		});