<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

[ 
	{ 
		url : "/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&myNotVote=notvote&q.fdVoteStatus=0&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-vote:kmVoteMain.notJoin')}"
	},
	{
		url : "/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&q.myvote=end&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('km-vote:kmVoteMain.attend')}"
	},
	{ 
		url : "/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&q.myvote=notstart&orderby=docCreateTime&ordertype=down", 
		text : "${lfn:message('km-vote:kmVoteMain.launch')}"
	},
	{
		url : "/km/vote/km_vote_main/kmVoteMainIndex.do?method=listChildren&q.fdVoteStatus=2&orderby=docCreateTime&ordertype=down",
		text: "${lfn:message('km-vote:kmVoteMain.history')}"
	}
]