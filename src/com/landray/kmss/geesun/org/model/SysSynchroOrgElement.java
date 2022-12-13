package com.landray.kmss.geesun.org.model;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.landray.kmss.geesun.org.util.SysSynchroOrgConstant;

public class SysSynchroOrgElement implements SysSynchroOrgConstant {

	private JSONObject data;

	public SysSynchroOrgElement(JSONObject orgData) {
		this.data = orgData;
	}

	public String getId() {
		return (String) this.data.get(ID);
	}

	public String getLunid() {
		return (String) this.data.get(LUNID);
	}

	public String getName() {
		return (String) this.data.get(NAME);
	}
	
	public String getNickName() {
		return (String) this.data.get(NICK_NAME);
	}

	public String getOrder() {
		Object order = this.data.get(ORDER);
		if (order != null)
			return "" + order;
		return null;
	}

	public String getNo() {
		Object no = this.data.get(NO);
		if (no != null)
			return "" + no;
		return null;
	}

	public String getKeyword() {
		return (String) this.data.get(KEYWORD);
	}

	public Boolean getIsAvailable() {
		return (Boolean) this.data.get(IS_AVAILABLE);
	}

	public String getMemo() {
		return (String) this.data.get(MEMO);
	}

	public String getAlterTime() {
		return (String) this.data.get(ALTERTIME);
	}

	public String getParent() {
		return (String) this.data.get(PARENT);
	}

	public String getThisLeader() {
		return (String) this.data.get(THIS_LEADER);
	}

	public String getSuperLeader() {
		return (String) this.data.get(SUPER_LEADER);
	}

	public String getLoginName() {
		return (String) this.data.get(LOGIN_NAME);
	}

	public String getPassword() {
		return (String) this.data.get(PASSWORD);
	}

	public String getEmail() {
		return (String) this.data.get(EMAIL);
	}

	public String getMobileNo() {
		return (String) this.data.get(MOBILE_NO);
	}

	public String getAttendanceCardNumber() {
		return (String) this.data.get(ATTENDANCE_CARD_NUMBER);
	}

	public String getWorkPhone() {
		return (String) this.data.get(WORK_PHONE);
	}
	
	public String getRtx() {
		return (String) this.data.get(RTX_NO);
	}

	public String getWechat() {
		return (String) this.data.get(WECHAT_NO);
	}

	public List getPosts() {
		return (JSONArray) this.data.get(POSTS);
	}

	public List getMembers() {
		return (JSONArray) this.data.get(MEMBERS);
	}

	public List getPersons() {
		return (JSONArray) this.data.get(PERSONS);
	}

	public String getSex() {
		return (String) this.data.get(SEX);
	}
	
	public JSONObject getCustomProps() {
		return (JSONObject) this.data.get("customProps");
	}
	
	public boolean contains(String key) {
		return this.data.containsKey(key);
	}

	public String getShortNo() {
		return (String) this.data.get(SHORT_NO);
	}
}
