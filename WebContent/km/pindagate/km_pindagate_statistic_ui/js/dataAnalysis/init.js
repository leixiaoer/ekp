//依赖组件
Com_IncludeFile("jquery.js|json2.js|data.js");
Com_IncludeFile("progress.js",Com_Parameter.ContextPath+"km/pindagate/resource/",null,true);

var questionArray;
//加载调查统计相关JS
function kmPindagateStatictisInit(str){
	questionArray=str;
	for(var i=0;i<questionArray.length;i++){
		if(questionArray[i].fdSplit!="true"){
			var jsFile=questionArray[i].fdType+".js";
			Com_IncludeFile(jsFile,Com_Parameter.ContextPath+"km/pindagate/km_pindagate_statistic_ui/js/dataAnalysis/",null,true);
		}
	}
}

//common function
window.viewSelectReasonAnswer=function(questionId){
	var url=Com_Parameter.ContextPath+"km/pindagate/km_pindagate_question_res/kmPindagateQuestionRes.do?method=list&questionId="+questionId+"&type=selectReason";
	Com_OpenWindow(url);
};
