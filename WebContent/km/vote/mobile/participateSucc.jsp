<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONObject" %>
<%   
	String hasVote = session!=null ? ((String)session.getAttribute("_hasVoted_")):null;
	if(request.getHeader("accept")!=null){
		if(request.getHeader("accept").indexOf("application/json") >=0){
			JSONObject json = new JSONObject();
			json.put("status", true);
			json.put("hasVote", hasVote);
			out.write(json.toString());
			return;
		}
	}
%>
