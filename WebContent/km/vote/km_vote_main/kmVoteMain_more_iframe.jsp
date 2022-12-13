<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="list_top.jsp"%> 
<td id="votingContent" >
	<iframe id="moreVoting" src="" width="100%" height="100%" frameborder=0 scrolling=no  onload="Javascript:SetWinHeight(this)">
	</iframe>
</td>	
<script>
function SetWinHeight(obj)
{   
    var win=obj;
    if (document.getElementById)
    {
        if (win && !window.opera)
        { 
            if (win.contentDocument && win.contentDocument.body.offsetHeight) 

                win.height = win.contentDocument.body.offsetHeight ; 
            else if(win.Document && win.Document.body.scrollHeight)
                win.height = win.Document.body.scrollHeight ;
        }
    } 
}
function edition_LoadIframe(){
	var iframe = document.getElementById("moreVoting");
	if(iframe.getAttribute("src")==""){
		iframe.src="<c:url value='/km/vote/km_vote_main/kmVoteMain.do?method=moreVoting&voteStatus=0&fdCurVoteId='/>"+'${JsParam.fdId}';
	}
	
}
edition_LoadIframe();
</script>
<%@ include file="/resource/jsp/list_down.jsp"%>