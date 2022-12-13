Com_RegisterFile("sysUnitDialog.js");
Com_IncludeFile("dialog.js");


/***********************************************
功能：左边树右边列表的对话框的简单调用
参数：
	mulSelect：
		必选，true多选，false单选，默认值为单选
	idField：
		可选，绑定关键字的域名字或对象或对象列表
	nameField：
		可选，绑定显示名的域名字或对象或对象列表
	splitStr：
		可选，字符串，值分隔符，若需要将多个值放置在一个域中，该项不能为null
	treeBean：
		必选，字符串，目录树获取数据的bean名字
		treeBean中可以采用参数替换的方式指定，参数格式为：!{节点属性名}，如：
		节点node.value=123
		原给定的treeBean：beanName&para=!{value}
		实际使用的treeBean：beanName&para=123
	treeTitle：
		必选，字符串，目录树的跟节点显示内容
	dataBean：
		必选，字符串，备选列表获取数据的bean名字
	action：
		可选，函数对象，当对话框关闭后需要执行的操作，样例：
			function MyAction(rtnVal){
				//在此写入您的代码，采用rtnVal可用获取返回值，该值为KMSSData对象，采用this可用访问到对话框对象
			}
			将MyAction传递给action参数
	searchBean：
		可选，字符串，用于搜索获取数据的bean名字，采用!{keyword}替换关键字输入的文本，样例：
			organizationDialogList&keyword=!{keyword}
	exceptValue：
		可选，目录树中不期望出现的关键字，为字符串或字符串数组
	isMulField：
		可选，布尔型，当idField/nameField以字符串形式传递时有效，标记是否获取所有同名的域的值，默认值为false
	notNull：
		可选，true（默认）表示可以为空
***********************************************/

function Dialog_UnitTreeList(mulSelect, idField, nameField, splitStr, treeBean, treeTitle, dataBean, action, searchBean, exceptValue, isMulField, notNull, winTitle){
	
	var dialog = new KMSSDialog(mulSelect, true);
	var node = dialog.CreateTree(treeTitle);
	dialog.winTitle = winTitle==null?treeTitle:winTitle;
	
	if(window.console) {
		console.log("treeBean =>", treeBean);
		console.log("dataBean =>", dataBean);
		console.log("exceptValue =>", exceptValue);
	}
	node.AppendBeanData(treeBean, dataBean, null, null, exceptValue);
	
	node.parameter = dataBean;
	dialog.BindingField(idField, nameField, splitStr, isMulField);
	dialog.SetAfterShow(action);
	dialog.URL = Com_Parameter.ContextPath + "sys/unit/km_imissive_unit/dialog.jsp?";
	if(searchBean!=null)
		dialog.SetSearchBeanData(searchBean);
	if(notNull!=null)
		dialog.notNull = notNull;
	dialog.Show();
	
}

/*** 重置新地址本 ***/
function resetNewDialog(propertyId,propertyName,splitStr,dataBean,isMulti,idValues,nameValues,callback,fieldIndex)  {
	if(window.$ === undefined || window.$.fn.manifest === undefined) {
		return false;
	}
	if(fieldIndex == null) {
		fieldIndex = 0;
	}
	var $input;
	if(typeof(propertyName)=="string") {
		var _field = $("[xform-name='mf_"+propertyName+"']")[fieldIndex];
		$input = $(_field);
	}else {
		$input = $(propertyName);
	}
	try {
		$input.manifest('remove','li');
		$input.manifest('destroy');
		initNewDialog(propertyId,propertyName,splitStr,dataBean,isMulti,idValues,nameValues,callback,fieldIndex);
	}catch(err) {
		initNewDialog(propertyId,propertyName,splitStr,dataBean,isMulti,idValues,nameValues,callback,fieldIndex);
	}
}



/*** 初始化新对话框 ***/
function initNewDialog(propertyId,propertyName,splitStr,dataBean,isMulti,idValues,nameValues,callback,fieldIndex) {
	if(window.$ === undefined || window.$.fn.manifest === undefined) {
		return false;
	}
	//元素下标
	if(fieldIndex == null) {
		fieldIndex = 0;
	}
	//初始值
	var values = [];
	if(idValues && nameValues){
		var idArr = idValues.split(";");
		var nameArr = nameValues.split(";");
		for(var i = 0;i<idArr.length;i++){
			if(idArr[i] && nameArr[i]){
				var valObj = {};
				valObj["id"] = idArr[i];
				valObj["name"] = nameArr[i];
				values.push(valObj);
			}
		}
	}
		
	//jq输入框
	var $inputField,
		inputField, //dom输入框
		nameField,  //名称隐藏框
		idField = document.getElementsByName(propertyId)[fieldIndex];  // ID隐藏框
	if(typeof(propertyName)=="string") {
		nameField = document.getElementsByName(propertyName)[fieldIndex];
		inputField = $("[xform-name='mf_"+propertyName+"']")[fieldIndex];
		$inputField = $(inputField);
	}else {
		inputField = propertyName;
		$inputField = $(propertyName);
		propertyName = $inputField.data("propertyname");
		nameField = document.getElementsByName(propertyName)[fieldIndex];
	}
	
	var HAVE_NO_RESULT = Data_GetResourceString('return.noRecord'),_validate,_oElement;
	
	//校验器
	if(window.$KMSSValidation) {
		var _form = $inputField.parents('form')[0];
		_validate = $.isFunction(window.$KMSSValidation)?$KMSSValidation(_form):window.$KMSSValidation,
		_oElement = new Elements();
	}
	$inputField.manifest({
		separator: splitStr,
		values:values,
		formatDisplay: function (data, $item, $mpItem) {
			if(data["name"] && data["name"].indexOf("<") > -1) {
				return Com_HtmlEscape(data["name"]);
			} else {
				return data["name"];
			}
		},
		formatValue: function (data, $value, $item, $mpItem) {
			return data["id"];
		},
		onAdd: function(data,$item) {
			var fields = [{key:'id',domEle:idField},{key:'name',domEle:nameField}];  
			var rtn = [],objs = [];
			for (var i = 0; i < fields.length; i++) {
				var field = fields[i].domEle;
				objs[i] = field;
				var temVal = data[fields[i].key];
				// 去重
				if(temVal && field.value.indexOf(temVal) === -1){
					rtn[i] = field.value = field.value ? field.value+splitStr+data[fields[i].key]:data[fields[i].key]; 
				}
			}
			if(callback) {
				callback(rtn, objs);
			}
			//校验
			if(_validate && _oElement.valiateElement(inputField)) {
				_validate.validateElement(inputField);
			}
		},
		onRemove: function(data,$item) {
			var fields = [{key:'id',domEle:idField},{key:'name',domEle:nameField}];  
			var rtn = [],objs = [];
			for (var i = 0; i < fields.length; i++) {
				var field = fields[i].domEle;
				var arr = field.value.split(splitStr);
				for(var j=0; j<arr.length; j++) {      
					if(arr[j] == data[fields[i].key]) {        
						arr.splice(j, 1);        
						break;      
					}
				}
				field.value = arr.join(splitStr);
				objs[i] = field;
				rtn[i] = field.value
			}
			if(callback) {
				callback(rtn, objs);
			}
			//校验
			if(_validate && _oElement.valiateElement(inputField)) {
				_validate.validateElement(inputField);
			}
		},
		marcoPolo: {
			url:Com_Parameter.ContextPath+'sys/common/dataxml.jsp?s_bean='+dataBean,
			formatData: function (data) {
				var datas = new Array();
				var oriValues = $inputField.manifest('values');
				$.each($(data).find('data'),function(index,item) { 
					var attrs = item.attributes;    
					var obj = new Object();   
					$.each(attrs,function(index,item) {     
						obj[item.nodeName] = item.nodeValue;    
					});
					//去重
					if($.inArray(obj["id"],oriValues) === -1)
						datas.push(obj);
				});
				return datas;
			},
			formatItem: function (data, $item) {
				var parentName="";
				if(data["parentName"] != null && data["parentName"] !== 'null' && data["parentName"] !== '') {
					parentName = ' <span>&lt;'+Com_HtmlEscape(data["parentName"])+'&gt;</span>';
				}
				return data["name"]+ ' '+ parentName;
			},
			onSelect: function(data, $item) {
				var fields = [{key:'id',domEle:idField},
				                  {key:'name',domEle:nameField}];  
				var rtn = [],objs = [];
				for (var i = 0; i < fields.length; i++) {
					var field = fields[i].domEle;
					objs[i] = field;
					rtn[i] = field.value = field.value ? field.value+splitStr+data[fields[i].key]:data[fields[i].key];  
				}
				if(callback) {
					callback(rtn, objs);
				}
				//校验
				if(_validate && _oElement.valiateElement(inputField)) {
					_validate.validateElement(inputField);
				}
			},
			
			formatNoResults: function (q) {
				var text = Data_GetResourceString('sys-unit:kmImissiveUnit.btn.addToUnit');
				var addHtml = "";
				if(getAddUnitAuth()){
					addHtml = '<a href="javascript:void(0)" style="color:#4285f4" onclick="addUnit(\''+Com_HtmlEscape(q)+'\',\''+propertyName+'\',\''+fieldIndex+'\');"><small>'+text+'</small></a>';
				}
		        return '<small>'+HAVE_NO_RESULT+'</small>'+ addHtml;
		    },
		    
			formatMinChars:false,
			formatError: false,
			minChars: 1,
			dataType: 'xml',
			param: 'fdKeyWord'
		},
		required: true,
		multi:isMulti
	});
	$inputField.unbind('blur.marcoPolo').bind('blur.marcoPolo',function(){
		//return;
	});
}


var getAddUnitAuth = function(){
	 var canAdd = false;
	 
	 var checkAddUntiUrl = "/sys/unit/km_imissive_unit/kmImissiveUnit.do?method=addUnit";
     var data = new Array();
     data.push(["addUnitBtn",checkAddUntiUrl]);
     $.ajax({
		  url: Com_Parameter.ContextPath+"sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
		  dataType:"json",
		  type:"post",
		  data:{"data":LUI.stringify(data)},
		  async:false,
		  success: function(rtn){
			  for(var i=0;i<rtn.length;i++){
           		if(rtn[i]['addUnitBtn'] == 'true'){
           			canAdd = true;
           		}
           	  }
		  }
	});
	
     return canAdd;
}

var addUnit = function(value,propertyName,fieldIndex){
	//元素下标
	if(fieldIndex == null) {
		fieldIndex = 0;
	}
	var $input;
	if(typeof(propertyName)=="string") {
		var _field = $("[xform-name='mf_"+propertyName+"']")[fieldIndex];
		$input = $(_field);
	}else {
		$input = $(propertyName);
	}
	try {
		$.ajax({
			url:  Com_Parameter.ContextPath+"sys/unit/km_imissive_unit/kmImissiveUnit.do?method=addUnit",
			type: 'POST',
			data:{fdUnitName:value},
			dataType: 'json',
			success: function(data){
				if(data['fdId']!=null && data['fdName']!=null){
					$input.manifest('add',{'id':data['fdId'],'name':data['fdName']},null,true,true);
					seajs.use(['sys/ui/js/dialog'],function(dialog) {
						dialog.success('添加单位成功！');
				 	});
			    }
			},
			error: function(result) {
				seajs.use(['lui/dialog'],function(dialog) {
					dialog.result(result);
			 	});
			}
	   });
		
	}catch(err) {
		
	}
};



