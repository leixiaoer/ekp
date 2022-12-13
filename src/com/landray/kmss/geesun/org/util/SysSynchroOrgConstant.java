package com.landray.kmss.geesun.org.util;

public interface SysSynchroOrgConstant {

	public final static int OPT_ORG_STATUS_NOOPT = 0;

	public final static int OPT_ORG_STATUS_FAIL = 1;

	public final static int OPT_ORG_STATUS_SUCCESS = 2;

	public final static String MID_PREFIX = "_";

	public final static String ID = "id";

	public final static String NAME = "name";
	
	public final static String NICK_NAME = "nickName";

	public final static String TYPE = "type";

	public final static String NO = "no";

	public final static String LUNID = "lunid";

	public final static String ORDER = "order";

	public final static String KEYWORD = "keyword";

	public final static String IS_AVAILABLE = "isAvailable";

	public final static String IS_DEFAULT = "isDefault";

	public final static String ALTERTIME = "alterTime";

	public final static String MEMO = "memo";
	
	public final static String POSTS = "posts";

	public final static String THIS_LEADER = "thisLeader";

	public final static String SUPER_LEADER = "superLeader";

	public final static String PARENT = "parent";

	public final static String MEMBERS = "members";

	public final static String MOBILE_NO = "mobileNo";

	public final static String HIERARCHY = "hierarchyId";

	public final static String EMAIL = "email";

	public final static String LOGIN_NAME = "loginName";

	public final static String PASSWORD = "password";

	public final static String ATTENDANCE_CARD_NUMBER = "attendanceCardNumber";

	public final static String WORK_PHONE = "workPhone";

	public final static String RTX_NO = "rtx";

	public final static String WECHAT_NO = "wechat";

	public final static String SHORT_NO = "shortNo";

	public final static String SEX = "sex";

	public final static String LEVEL = "level";

	public final static String DESCRIPTION = "Description";

	public final static String PERSONS = "persons";

	public final static String ORG_WEB_TYPE_PERSON = "person";

	public final static String ORG_WEB_TYPE_POST = "post";

	public final static String ORG_WEB_TYPE_GROUP = "group";

	public final static String ORG_WEB_TYPE_ORG = "org";

	public final static String ORG_WEB_TYPE_DEPT = "dept";

	public final static String ORG_WEB_SET_CONFIG_DEFAULT = "{\"org\":[\"no\",\"order\",\"keyword\",\"memo\",\"parent\",\"thisLeader\",\"superLeader\"],"
			+ "\"dept\":[\"no\",\"order\",\"keyword\",\"memo\",\"parent\",\"thisLeader\",\"superLeader\"],"
			+ "\"group\":[\"no\",\"order\",\"keyword\",\"memo\",\"members\"],"
			+ "\"post\":[\"no\",\"order\",\"keyword\",\"memo\",\"parent\",\"thisLeader\",\"superLeader\"],"
			+ "\"person\":[\"no\",\"order\",\"keyword\",\"memo\",\"loginName\",\"email\",\"mobileNo\",\"attendanceCardNumber\","
			+ "\"workPhone\",\"rtx\",\"posts\",\"wechat\",\"parent\", \"sex\", \"nickName\", \"password\"]}";

}
