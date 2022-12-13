package com.landray.kmss.geesun.org.model;

import java.io.Serializable;
import java.util.List;

public class GeesunOrgDetailElementModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String lunid;

	private String no;
	
	private String type;
	
	private String name;
	
	private String nickName;
	
	private String keyword;
	
	private String order;
	
	private String memo;
	
	private String parent;
	
	private String thisLeader;
	
	private String superLeader;
	
	private String members;
	
	private List posts;
	
	private String loginName;
	
	private String attendanceCardNumber;
	
	private String workPhone;
	
	private String sex;
	
	private String shortNo;
	
	private String rtx;
	
	private String password;
	
	private String mobileNo;
	
	private String wechat;
	
	private String email;
	
	private boolean isAvailable;
	
	private org.json.simple.JSONObject customProps;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLunid() {
		return lunid;
	}

	public void setLunid(String lunid) {
		this.lunid = lunid;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getThisLeader() {
		return thisLeader;
	}

	public void setThisLeader(String thisLeader) {
		this.thisLeader = thisLeader;
	}

	public String getSuperLeader() {
		return superLeader;
	}

	public void setSuperLeader(String superLeader) {
		this.superLeader = superLeader;
	}

	public String getMembers() {
		return members;
	}

	public void setMembers(String members) {
		this.members = members;
	}

	public List getPosts() {
		return posts;
	}

	public void setPosts(List posts) {
		this.posts = posts;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getAttendanceCardNumber() {
		return attendanceCardNumber;
	}

	public void setAttendanceCardNumber(String attendanceCardNumber) {
		this.attendanceCardNumber = attendanceCardNumber;
	}

	public String getWorkPhone() {
		return workPhone;
	}

	public void setWorkPhone(String workPhone) {
		this.workPhone = workPhone;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getShortNo() {
		return shortNo;
	}

	public void setShortNo(String shortNo) {
		this.shortNo = shortNo;
	}

	public String getRtx() {
		return rtx;
	}

	public void setRtx(String rtx) {
		this.rtx = rtx;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean getIsAvailable() {
		return isAvailable;
	}

	public void setIsAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public org.json.simple.JSONObject getCustomProps() {
		return customProps;
	}

	public void setCustomProps(org.json.simple.JSONObject customProps) {
		this.customProps = customProps;
	}

}
