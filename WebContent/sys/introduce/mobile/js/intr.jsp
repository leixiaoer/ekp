<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ul>
    <li>
	    <div class="muiIntrAddHead">
	         <div class="muiIntrHideMask"><div class="mui-down-n mui"></div></div>
	         <div class="tip">${lfn:message('sys-introduce:sysIntroduceMain.button.introduce')}</div>
			 <div class="muiIntrSubmit"><bean:message bundle="sys-introduce" key="sysIntroduceMain.mobile.introduce.submit"/></div>
	    </div>
    </li>
    <li class="muiIntrGradeBar" >
		<div class="muiIntrGradeLeft">
			<span class="title"><bean:message bundle="sys-introduce" key="sysIntroduceMain.mobile.introduceGrade"/></span>
			<span id="intr_praise_opt"
				data-dojo-type="!{starklass}" 
				data-dojo-props="value:3,editable:true,numStars:3,icon:'mui mui-2 sysintroducefont icon_intr_praise_yellow'">
			</span>
			<span id="contentLength" style="color: red;"></span>
		</div>
	</li>
	<li style="display: none;">
		<input type="hidden" name="fdIntroduceGoalNames" value=""/>
		<input type="hidden" name="fdIntroduceGoalIds" value=""/>
		<input type="hidden" name="fdIntroduceGrade" value="0">
		<input type="hidden" name="fdIntroduceToPerson" value="0"/>
	</li>
	
	<li class="muiIntrReason">
		<textarea name="fdIntroduceReason" placeholder='<bean:message bundle="sys-introduce" key="sysIntroduceMain.mobile.reply"/>' class="muiIntrMaskText"></textarea>
	</li>
	<li class="introduceToEssenceLi">
	    <span class="title"><bean:message bundle="sys-introduce" key="sysIntroduceMain.mobile.fdIntroduceToEssence"/></span>
		<div data-dojo-type="mui/form/Switch" 
		data-dojo-mixins="${LUI_ContextPath}/sys/introduce/mobile/js/IntrSwitchMixin.js"
		data-dojo-props="realValue:'true',showStatus:'edit',orient:'horizontal',align:'right',property:'fdIntroduceToEssence',leftLabel:'',rightLabel:''"></div>
	</li>
	<li class="introduceToPerson">
	    <div class="title" style="margin-bottom: 1rem;">${lfn:message('sys-introduce:sysIntroduceMain.introduce.addPerson.lable')}</div>
		<div data-dojo-type="mui/form/Address" 
				id="_intr_address"
				data-dojo-props="isMul:true,type: ORG_TYPE_ALL,idField:'fdIntroduceGoalIds',
								 subject:'<bean:message bundle="sys-introduce" key="sysIntroduceMain.mobile.selectIntroduce"/>',
								 nameField:'fdIntroduceGoalNames'">
		</div>
	</li>
</ul>