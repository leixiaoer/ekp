<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<tr>
	<td style="padding-left: 15px;font-size:13px;" id="voteItemRate" class="com_subject" colspan="3">
	    <div class="barline" >
		<div style="width:210px;height:15px;float:left;background: none no-repeat scroll left 50% #efefef;"><span class="charts color${kmVoteMainItemForm.fdColor}" style="width: <c:out value="${kmVoteMainItemForm.fdVoteItemRate}" />;"></span></div>
		<span class="num">
	 		<script type="text/javascript">
			document.write('<c:out value="${kmVoteMainItemForm.fdVoteItemNum}" />');
			</script>
	    	(<c:out value="${kmVoteMainItemForm.fdVoteItemRate}" />)
		</span>
		</div>
	</td>
</tr>			                
