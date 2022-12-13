package com.landray.kmss.geesun.org;

import java.text.SimpleDateFormat;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.util.EntityUtils;

import com.landray.kmss.geesun.org.util.MySSLSocketFactory;


public class Test {

	public static void main(String[] args) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		String tt = "2020-04-20T02:10:00";
		System.out.println(tt.substring(0, tt.indexOf("T")));
		System.out.println(sdf.parse(tt));
		String result = sendPost();
		System.out.println(result);
	}
	
	/**
	 * 发送post请求获取单点登录token
	 * @param config
	 * @param logList
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public static String sendPost() throws Exception {
		 HttpClient client = MySSLSocketFactory.getNewHttpClient();  
	    String url = "http://172.16.220.201:8080/YSCommonWebInterface/GetJsonDataWebHandler.ashx?serectKey=YS.WebInter&SPName=emp";
	    HttpPost post = new HttpPost(url);
        post.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)"); 
	    String responseContent = null; // 响应内容
	    HttpResponse response = null;
	    try {
	        response = client.execute(post);
	        if (response.getStatusLine().getStatusCode() == 200) {
	            HttpEntity entity = response.getEntity();
	            responseContent = EntityUtils.toString(entity);//返回json格式       
	        }
	    } catch(Exception e) {
	    	throw new RuntimeException(e);
	    } finally {
	    }
	    return responseContent;
	}

}
