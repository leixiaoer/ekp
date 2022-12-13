define( [ "dojo/_base/declare","dojo/_base/lang", "dojo/query", "dojo/dom-construct", "km/carmng/mobile/js/selectdialog/_DialogCategoryBase"],
		function(declare, lang, query, domConstruct, _CategoryBase) {
				window.SYS_CATEGORY_TYPE_CATEGORY = 0; //"CATEGORY" 类别
				
				window.SYS_CATEGORY_TYPE_TEMPLATE = 1; //"TEMPLATE" 模板
	
				window.SYS_CATEGORY_TYPE_DOCUMENT = 2;//"DOC" 文档
	
				var addressMixin = declare("mui.selectdialog.DialogMixin", null, {
				//列表数据获取URL
				listDataUrl: null,
				//详细数据获取url
				detailUrl:null,
				//搜索获取URL
				searchDataUrl :null,
				//字段参数
				fieldParam:null,

				isMul : false,

				templURL : "km/carmng/mobile/js/selectdialog/dialog_sgl.jsp" ,
				
				title:"",

				buildRendering : function() {
					this.inherited(arguments);
				},

				buildOptIcon : function(optContainer) {
					domConstruct.create("i", {
						className : 'mui mui-address'
					}, optContainer);
				},
				
				_setIsMulAttr:function(mul){
					this._set('isMul' , mul);
					if(this.isMul){
						this.templURL =  "km/carmng/mobile/js/selectdialog/dialog_mul.jsp";
					}else{
						this.templURL =  "km/carmng/mobile/js/selectdialog/dialog_sgl.jsp";
					}
				}
			});
			var exports = {
					address : function(mulSelect, idField, nameField, selectType,
							action) {
						var addressObj = new _CategoryBase();
						addressObj.isMul = mulSelect == true ? true : false;
						addressObj.templURL = (mulSelect == true ? "km/carmng/mobile/js/selectdialog/dialog_mul.jsp"
								: "km/carmng/mobile/js/selectdialog/dialog_sgl.jsp");
						addressObj.key = idField;
						addressObj.type = window.SYS_CATEGORY_TYPE_DOCUMENT;
						addressObj.listDataUrl = this.listDataUrl;
						addressObj.searchDataUrl = this.searchDataUrl;
						addressObj.detailUrl = this.detailUrl;
						addressObj.title = this.title;
						addressObj.fieldParam = this.fieldParam;
						var idObj = query("[name='" + idField + "']")[0];
						var nameObj = query("[name='" + nameField + "']")[0];
						addressObj.curIds = idObj.value;
						addressObj.curNames = nameObj.value;
						addressObj.afterSelect = function(obj) {
							idObj.value = obj.curIds;
							nameObj.value = obj.curNames;
							if (action) {
								action(obj);
							}
						};
						addressObj.eventBind();
						addressObj._selectCate();
					}
				};
		return lang.mixin(addressMixin, exports);
	});