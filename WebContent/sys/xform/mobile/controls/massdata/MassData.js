// 大数据呈现
define([ "dojo/_base/declare", "dijit/_WidgetBase", "dojo/dom-construct" ,'dojo/_base/lang',
		"mui/util","sys/xform/mobile/controls/massdata/_ViewTempMixin",
		"sys/xform/mobile/controls/massdata/_RequestDataMixin","mui/base64", "dojo/topic"], 
		function(declare, WidgetBase , domConstruct,lang , util, _ViewTempMixin , _RequestDataMixin, base64, topic) {
	var claz = declare("sys.xform.mobile.controls.massdata.MassData", [WidgetBase,_ViewTempMixin, _RequestDataMixin], {

		pageno : "1",
		
		pageSize : "10",
		
		totalSize : "0",
		
		inputParams : null,
		
		outputParams : null,
		
		excelcolumns : null,
		
		columns : {},
		
		datas : [],
		
		contentWgt:null,	// _ViewTempMixin定义
		
		pagingWgt:null,	// _ViewTempMixin定义
		
		allColInvalid: true,	// 所有列失效标识
		
		buildRendering : function(){
			this.inherited(arguments);
			this.mainModelName = _xformMainModelClass;
			this.mainFormId = _xformMainModelId;
			this.initColumns();
		},
		
		postCreate : function() {
			this.inherited(arguments);
		},
		
		startup : function(){
			this.inherited(arguments);
			
			// 翻页功能 evt : {pageno:xx}
			this.subscribe("/sys/xform/massdata/page",lang.hitch(this,function(evt){
				this.pageno = evt.pageno;
				this.reRender();
			}));
		},
		
		// 参考pc端
		initColumns : function(){
			var source = this._source;
			if(source == "EXCEL"){
				// 初始化列参数
				this.excelcolumns = this.excelcolumns || "{}";
				this.excelcolumns = $.parseJSON(this.excelcolumns.replace(/quot;/g,"\""));
				// 格式化列定义，返回以字段名为key的json：{docSubject:{fieldTitle:xxx}}，方便数据通过key定位
				this.columns = $.extend(this.columns,this.excelcolumns);;
			}else{
				// 初始化传入参数
				this.inputParams = this.inputParams || "{}";
				this.inputParams = $.parseJSON(this.inputParams.replace(/quot;/g,"\""));
				// 初始化传出参数
				this.outputParams = this.outputParams || "{}";
				this.outputParams = $.parseJSON(this.outputParams.replace(/quot;/g,"\""));
				// 格式化列定义，返回以字段名为key的json：{docSubject:{title:xxx}}，方便数据通过key定位
				for(var key in this.outputParams){
					var param = this.outputParams[key];
					this.columns[base64.decode(param["fieldId"])] = {title:param["fieldTitle"]};
				}
			}
		},
		
		onDataLoad : function(rs){
			this.setDatas(rs);
			this.allColInvalid = true;
			this.reRender();
		},
		
		reRender : function(){
			// 内容区渲染
			var evt = {};
			evt.pageno = this.pageno;
			evt.pageSize = this.pageSize;
			evt.totalSize = this.totalSize;
			evt.columns = this.columns;
			var datas = this.divideDatasByPage();
			// 跟pc端逻辑不一样，此处先查询有效数据
			datas = this.getValidDatas(datas,this.columns);
			evt.datas = datas;
			this.contentWgt.render(evt);
			if(datas.length > 0){
				this.pagingWgt.render(evt);				
			}
			this.contentWgt.resize();
			topic.publish("/mui/list/resize");
		},
		
		setDatas : function(rs){
			rs = rs || {};
			if(rs.hasOwnProperty("records")){
				this.datas = rs["records"];
				this.totalSize = this.datas.length;
			}else{
				this.datas = [];
				this.totalSize = "0";
			}
		},
		
		// 分页，分割数据
		divideDatasByPage : function(){
			var rs = [];
			var datas = this.datas;
			var startIndex = parseInt((this.pageno - 1)*this.pageSize);
			var endIndex = parseInt(this.pageno*this.pageSize);
			if(datas.length >= startIndex && datas.length < endIndex){
				rs = datas.slice(startIndex);
			}else if(datas.length < startIndex){
				
			}else if(datas.length >= endIndex){
				rs = datas.slice(startIndex,endIndex);
			}
			return rs;
		},
		
		// [{xx:{value:xx}}{}]
		getValidDatas : function(datas,columns){
			var rsDatas = [];
			for(var i = 0;i < datas.length;i++){
				var data = datas[i];
				var rsData = {};
				// 根据列定义来判断当前返回数据哪些是有效数据
				for(var key in columns){
					if(data.hasOwnProperty(key)){
						rsData[key] = data[key];
					}
				}
				if(JSON.stringify(rsData) != "{}"){
					rsDatas.push(rsData);
				}
			}
			return rsDatas;
		}
	});
	return claz;
});