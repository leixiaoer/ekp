<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>

var showMore = data.showMore;
var instructions = data.instructions;
if(instructions.length > 0){
{$
<ul class="lui_supervise_idea_list">
$}
	for(var i = 0; i< instructions.length;i++){
		var canDel = instructions[i].canDel;
		{$
		<li>
        	<div class="lui_supervise_idea_list_item">
           		<div class="lui_sili_tit">
             		<div class="lui_sili_tit_left">
               			<div class="lui_sili_tit_img">
                 			<img src="<person:headimageUrl personId='{%instructions[i].docCreatorId%}' contextPath='true'/>" alt="头像"/>
               			</div>
               			<p class="lui_sili_tit_name">{%instructions[i].docCreatorName%}</p>
             		</div>
				
				
        	
		$}
		if(canDel == true){
			{$
				<div class="lui_sili_tit_right" onclick="delInstruction('{%instructions[i].fdId%}');">
               		<p class="lui_sili_tit_delete"></p>
             	</div>
			$}
		}
			{$		
				</div>
			<div class="lui_sili_tit_content">
             	<p class="lui_sili_tit_content_words">
              		{% instructions[i].docContent%}
             	</p>
             		<div class="lui_sili_tit_content_time">
               			<p class="lui_sili_tit_content_time_date">{% instructions[i].docCreateTime%}</p>
             		</div>
           		</div>
        	</div>
       	</li>
		$}
	}
{$
</ul>
$}
}
if(showMore == true){
var count = instructions.length + 3;
{$
	<div class="lui_stage_more lui_text_primary" onclick="showMore({%count%});">查看更多</div>
$}
}