package com.landray.kmss.geesun.org.rest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.web.annotation.RestApi;

@Controller
@RequestMapping(value="/api/cxzx-log/cxzxGetLoginNameByMobile",
        method=RequestMethod.POST)
@RestApi(
		docUrl = "/sys/restservice/demoapidoc.jsp", 
	name = "cxzxGetLoginNameByMobile", 
	resourceKey = "geesun-org:geesun.testRestful.name")
public class CxzxGetLoginNameByMobile {
    
    /**
     * 根据手机号获取登录名信息
     * @param mobileNo
     * @return
     */
    @RequestMapping("/getLoginNameByMobile")
    @ResponseBody
    public String getLoginNameByMobile(@RequestParam("mobileNo") String mobileNo){
    	JSONObject json = new JSONObject();
    	json.put("success", false);
    	json.put("fdLoginName", "");
    	if (StringUtil.isNull(mobileNo)) {
    		json.put("error", "登录名信息不能为空");
    		return json.toString();
    	}
    	try {
    		String fdLoginName = getLoginNameByMobileNo(mobileNo);
    		if (StringUtil.isNotNull(fdLoginName)) {
    			json.put("success", true);
    			json.put("loginNameArray", fdLoginName);
    		} else {
    			json.put("error", "testoa");
    		}
		} catch (Exception e) {
			json.put("error", e.toString());
		}
        return json.toString();
    }
    
	/**
	 * 根据手机号取登录名信息
	 * @param fdMobileNo
	 * @throws Exception
	 */
	public String getLoginNameByMobileNo(String fdMobileNo) throws Exception {
		DataSource dataSource = (DataSource) SpringBeanUtil.getBean("dataSource");
		String fdLoginName = "";
		if (StringUtil.isNotNull(fdMobileNo)) {
			return fdLoginName;
		}
		String sql = "select person.fd_login_name from sys_org_person person left join sys_org_element element on person.fd_id = element.fd_id "
				+ " where element.fd_is_available = ? and person.fd_mobile_no = ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setBoolean(1, Boolean.TRUE);
			ps.setString(2, fdMobileNo);
			rs = ps.executeQuery();
			if (rs.next()) {
				fdLoginName = rs.getString(1);
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			JdbcUtils.closeResultSet(rs);
			JdbcUtils.closeStatement(ps);
			JdbcUtils.closeConnection(conn);
		}
		return fdLoginName;
	}
    
}
