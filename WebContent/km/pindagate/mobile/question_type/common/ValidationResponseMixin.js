define(["dojo/_base/declare","dojo/topic","mui/i18n/i18n!km-pindagate:mobile","dojo/dom","dojo/query","dojo/dom-class",],
		function(declare,topic,msg,dom,query,domClass){
	
	return declare("km.pindagate.common.ValidationResponseMixin",null,{
		
		validateEvent:'km/pindagate/validated',
		
		validateResult:null,
		
		validate:function(value){
			var message='';
			if (this.questionDef.fillType=="fillquestions") {
				message=this.isFillQuestions();
			}else{
				var checkValue;
				if (this.isEmpty(this.draftValue)) {
					this.checkValue=this.value;
				}else{
					this.checkValue=this.draftValue;
				}
			}
			
			
			
			
			var navVal=dom.byId("navSgin").value;
				navIndex=this.index;
			value= value || this.value;
			var willAnswer=this.questionDef.willAnswer;
			this.validateResult=this.validateResult || {
				canSave:true,
				message:''
			};
			if(willAnswer && this.isEmpty(this.checkValue)){
				this.validateResult.canSave=false;
				this.validateResult.message= msg['mobile.kmPindagateMain.notnullAll'];
			}else{
				if (message) {
					this.validateResult.canSave=false;
					this.validateResult.message=message;
				}else{
					this.validateResult.message='';
					this.validateResult.canSave=true;
				}
			}
			if (navVal) {
				navVal=JSON.parse(navVal);
				if (navVal.indexOf(navIndex+1)>-1) {
					this.validateResult.canSave=true;
					this.validateResult.message='';
				}
			}
				
		},
		
		isFillQuestions:function(){
			if (this.questionDef.questionsSel=="1") {//整数
				intVal=query("#integerDef"+this.index).val();
				if (intVal==undefined) {
					intVal=this.draftValue
				}
				if (intVal) {
					this.value=intVal;
					this.checkValue=intVal;
				}else{
					this.value="";
					this.checkValue="";
				}
				var rex=/^-?\d+$/;
				if (this.questionDef.range==true) {
					max=this.questionDef.max;
					min=this.questionDef.min;
					if (parseInt(intVal)>parseInt(max)||parseInt(intVal)<parseInt(min)) {
						msgWrun=msg['mobile.kmPindagate.fillquestions.defNoMaxisMin1'].replace('%number1%',intVal).replace('%number2%',max).replace('%number3%',min);
						this.checkValue=intVal;
						return msgWrun;
					}
				}
				if(!rex.test(intVal)){
					msgWrun=msg['mobile.kmPindagate.fillquestions.intPush1'];
					this.checkValue=intVal;
					return msgWrun;
				}
				this.checkValue=intVal;
			}else if(this.questionDef.questionsSel=="2"){//小数
				intVal=query("#integerDef"+this.index).val();
				if (intVal==undefined) {
					intVal=this.draftValue
				}
				if (intVal) {
					this.value=intVal;
					this.checkValue=intVal;
				}else{
					this.value="";
					this.checkValue="";
				}
				var rex=/^(([^0][0-9]{0,9999}|0)\.([0-9]{1,2}))$/;
				if (this.questionDef.range==true) {
					max=this.questionDef.max;
					min=this.questionDef.min;
					if (Number(intVal)>Number(max)||Number(intVal)<Number(min)) {
						msgWrun=msg['mobile.kmPindagate.fillquestions.defNoMaxisMin1'].replace('%number1%',intVal).replace('%number2%',max).replace('%number3%',min);
						this.checkValue=intVal;
						return msgWrun;
					}
				}
				if(!rex.test(intVal)){
					msgWrun=msg['mobile.kmPindagate.fillquestions.doubleTwoPlace1'];
					this.checkValue=intVal;
					return msgWrun;
				}
				this.checkValue=intVal;
			}else if(this.questionDef.questionsSel=="4"){
				iphoneVal=query("#iphoen"+this.index).val();
				if (iphoneVal==undefined) {
					iphoneVal=this.draftValue
				}
				if (iphoneVal) {
					this.value=iphoneVal;
					this.checkValue=iphoneVal;
				}else{
					this.value="";
					this.checkValue="";
				}
				var rex= /^[1][3,4,5,7,8,9][0-9]{9}$/;
				if(!rex.test(iphoneVal)){
					 warn=msg['mobile.kmPindagate.fillquestions.iphoneCheck'];
					 this.checkValue=iphoneVal;
					 return warn;
				 }else{
					 this.checkValue=iphoneVal;
				}
			}else if(this.questionDef.questionsSel=="5"){
				emailVal=query("#email"+this.index).val();
				if (emailVal==undefined) {
					emailVal=this.draftValue
				}
				if (emailVal) {
					this.value=emailVal;
					this.checkValue=emailVal;
				}else{
					this.value="";
					this.checkValue="";
				}
				var rex= /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
				if(!rex.test(emailVal)){
					warn=msg['mobile.kmPindagate.fillquestions.emailCheck'];
					this.checkValue=emailVal;
					return warn;
				}else{
					this.checkValue=emailVal;
				}
			}else if(this.questionDef.questionsSel=="6"){
				anVal= query("input[name='fdItems["+this.index+"].fdAnswer']").val();
				anValTxt= query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val();
				if (anVal==undefined) {
					anVal=this.draftValue
					anValTxt=this.draftValueTxt
				}
				if (anVal) {
					query("input[name='fdItems["+this.index+"].fdAnswer']").val(anVal);
					query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val(anValTxt);
					this.value=anVal;
					this.checkValue=anVal;
				}else{
					query("input[name='fdItems["+this.index+"].fdAnswer']").val("");
					query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val("");
					this.value="";
					this.checkValue="";
					
				}	
			}else if(this.questionDef.questionsSel=="7"){
				idval=query("#id"+this.index).val();
				if (idval==undefined) {
					idval=this.draftValue
				}
				if (idval) {
					this.value=idval;
					this.checkValue=idval;
				}else{
					this.value="";
					this.checkValue="";
				}
				msgWrun=this.testid(idval);
				if (msgWrun) {
					this.checkValue=idval;
					return msgWrun;
				}else{
					this.checkValue=idval;
				}
			}else if(this.questionDef.questionsSel=="8"){
				var rex=/^[\u4e00-\u9fa5]+$/gi;
				chinesVal=query("#chinesWord"+this.index).val();
				if (chinesVal==undefined) {
					chinesVal=this.draftValue
				}
				if (chinesVal) {
					this.value=chinesVal;
					this.checkValue=chinesVal;
				}else{
					this.value="";
					this.checkValue="";
				}
				if(!rex.test(chinesVal)){
					warn=msg['mobile.kmPindagate.fillquestions.chinesePush1'];
					this.checkValue=chinesVal;
					return warn;
				}else{
					this.checkValue=chinesVal;
				}
			}else if(this.questionDef.questionsSel=="9"){
				var rex=/^[a-zA-Z\s]+$/;
				englishVal=query("#english"+this.index).val();
				if (englishVal==undefined) {
					englishVal=this.draftValue
				}
				if (englishVal) {
					this.value=englishVal;
					this.checkValue=englishVal;
				}else{
					this.value="";
					this.checkValue="";
				}
				if(!rex.test(englishVal)){
					warn=msg['mobile.kmPindagate.fillquestions.englishPush1'];
					this.checkValue=englishVal;
					return warn;
				}else{
					this.checkValue=englishVal;
				}
			}else if(this.questionDef.questionsSel=="3"){
				anVal=query("input[name='dateTime"+this.index+"']").val();
				if (anVal==undefined) {
					anVal=this.draftValue
				}
				if (anVal) {
					query("input[name='fdItems["+this.index+"].fdAnswer']").val(anVal);
					query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val(anVal);
					this.value=anVal;
					this.checkValue=anVal;
				}else{
					query("input[name='fdItems["+this.index+"].fdAnswer']").val("");
					query("input[name='fdItems["+this.index+"].fdAnswerTxt']").val("");
					this.value="";
					this.checkValue="";
					
				}	
			}else if(this.questionDef.questionsSel==null){
				defVal=query("#def"+this.index).val();
				if (defVal==undefined) {
					defVal=this.draftValue
				}
				if (defVal) {
					this.value=defVal;
					this.checkValue=defVal;
				}else{
					this.value="";
					this.checkValue="";
				}
			}else{
				var checkValue;
				if (this.isEmpty(this.draftValue)) {
					this.checkValue=this.value;
				}else{
					this.checkValue=this.draftValue;
				}
			}
			
		},
		isEmpty:function(value){
			if(value){
				//无属性的空object返回true,即{}
				var hasProp=false;
				if(typeof value =='object'){
					for(var prop in value){
						if(value[prop]){
							hasProp = true;  
					        break; 
						}
					}
					if(!hasProp)
						return true;
				}
				return false;
			}
			return true;
		},
		testid:function (id) {
			   // 1 "验证通过!", 0 //校验不通过 // id为身份证号码
			    var format = /^(([1][1-5])|([2][1-3])|([3][1-7])|([4][1-6])|([5][0-4])|([6][1-5])|([7][1])|([8][1-2]))\d{4}(([1][9]\d{2})|([2]\d{3}))(([0][1-9])|([1][0-2]))(([0][1-9])|([1-2][0-9])|([3][0-1]))\d{3}[0-9xX]$/;
			    //号码规则校验
			    if(!format.test(id)){
			      return msg['mobile.kmPindagate.fillquestions.idCheck1'];
			    }
			    //区位码校验
			    //出生年月日校验  前正则限制起始年份为1900;
			    var year = id.substr(6,4),//身份证年
			      month = id.substr(10,2),//身份证月
			      date = id.substr(12,2),//身份证日
			      time = Date.parse(month+'-'+date+'-'+year),//身份证日期时间戳date
			      now_time = Date.parse(new Date()),//当前时间戳
			      dates = (new Date(year,month,0)).getDate();//身份证当月天数
			    if(time>now_time||date>dates){
			      return msg['mobile.kmPindagate.fillquestions.idCheck2'];
			    }
			    //校验码判断
			    var c = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2);  //系数
			    var b = new Array('1','0','X','9','8','7','6','5','4','3','2'); //校验码对照表
			    var id_array = id.split("");
			    var sum = 0;
			    for(var k=0;k<17;k++){
			      sum+=parseInt(id_array[k])*parseInt(c[k]);
			    }
			    if(id_array[17].toUpperCase() != b[sum%11].toUpperCase()){
			      return msg['mobile.kmPindagate.fillquestions.idCheck3'];;
			    }
			    //return '校验通过';
			}
		
		
	});
	
});