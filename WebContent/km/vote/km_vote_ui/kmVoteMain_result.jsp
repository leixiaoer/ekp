<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table>
      <c:forEach items="${kmVoteMainForm.fdVoteItems}" var="kmVoteMainItemForm" varStatus="vstatus">
          <tr>                    
              <td style="width:15px;padding-bottom: 10px;padding-top: 3px;">
              </td>
         		<td style="display:none;">		                      			
         		</td>
            <td style="padding-bottom: 10px;font-size:13px;" class="com_subject" colspan="2">
            <label for="_fdVoteItemIds${vstatus.index+1}_">
             <script type="text/javascript">     
               	document.write('<c:out value="${kmVoteMainItemForm.fdName}"  />');																			
			</script>								
			<br/>
  			<div class="barline" >
			<div style="width:260px;height:15px;float:left;background: none no-repeat scroll left 50% #efefef;"><span class="charts color${kmVoteMainItemForm.fdColor}" style="width: <c:out value="${kmVoteMainItemForm.fdVoteItemRate}" />;"></span></div>
         	<span class="num">
           		<script type="text/javascript">
					document.write('<c:out value="${kmVoteMainItemForm.fdVoteItemNum}" />');
				</script>
          			(<c:out value="${kmVoteMainItemForm.fdVoteItemRate}" />)
          	</span>
          	</div>
           </label>
          </td>
       </tr>
    </c:forEach>
</table>