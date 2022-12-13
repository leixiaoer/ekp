<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
//@处理人按钮
$(document).ready(function () {
	var isRight = "${param.approveModel eq 'right'}";
	if(isRight == "true" && !lbpm.constant.ISINIT && lbpm.constant.METHOD != "edit"){
		//判断是否需要展示@处理人
		var dataVal = $("#handlerTypeRow").find(".lui_lbpm_handlerType").find("span.active").attr("data-value");
		if(dataVal == 'authority' || dataVal == 'historyhandler' || dataVal == 'drafter'){
			return;
		}
		//$("#handlerTypeRow").css("display") != "none" && $("#handlerTypeRow").find(".lui_lbpm_handlerType").eq(0).
		var title = Data_GetResourceString("sys-lbpmservice:lbpm.process.noticeHandler.name");
		var html = '<div class="lui-lbpm-opinion-noticeHandler lui-lbpm-opinion-btn" title="'+title+'" onclick="lbpm.globals.selectHistoryHandlers(this,\'fdUsageContent\');">';
		//$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").before(html);
		var btnLen= $('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').length;
		//如果超过3个按钮，则按三个按钮计算，并把当前按钮放置到更多中
		if(btnLen-1 >= 3){
			//转移最后一个到更多中
			$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").find(".lui-lbpm-opinion-moreList").eq(0).find("ul").append("<li>"+$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').eq(btnLen-2).prop("outerHTML")  + "</li>");
			$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').eq(btnLen-2).remove();
			
			html += title;
			html += '<input type="hidden" name="noticeHandlerIds" id="noticeHandlerIds">';
			html += '</div>';
			html = "<li>" + html + "</li>";
			$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").find(".lui-lbpm-opinion-moreList").eq(0).find("ul").append(html);
			$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').css({
		        'width':100/3+'%'
		    });
			$('.lui-lbpm-opinion-moreList .lui-lbpm-opinion-btn').css({
		        'width':'100%'
		    });
			$('.lui-lbpm-opinion-more').css({
				'display':'inline-block'
			})
		}else{
			html += '@';
			html += '<input type="hidden" name="noticeHandlerIds" id="noticeHandlerIds">';
			html += '</div>';
			//$(".lui-lbpm-opinion-otherFnc").append(html);
			$(".lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-more").before(html)
			$('.lui-lbpm-opinion-otherFnc .lui-lbpm-opinion-btn').css({
		        'width':100/btnLen+'%'
		    });
		}
	}
});
</script>