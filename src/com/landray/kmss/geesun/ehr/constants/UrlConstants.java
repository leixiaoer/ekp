package com.landray.kmss.geesun.ehr.constants;

/**
 * @author zgf
 * 请求地址参数列表
 */
public class UrlConstants {

    //新增请假单据
    public static String INSERT_LEAVE = "/thirdPlatformForeign/call/holiday_leave";
    //销假单接口
    public static String BACKFROMLEAVE = "/thirdPlatformForeign/call/v2/backFromLeave";
    //出差单作废
    public static String CANCELTIRP = "/thirdPlatformForeign/call/v2/cancelTirp";
    //请假单作废接口
    public static String CANCELODERLEAVE = "/thirdPlatformForeign/call/v2/cancelOderLeave";
    //新增加班单
    public static String ADDWORKOVER = "/thirdPlatformForeign/call/addworkover";
    //新增出差单
    public static String ADDANDMODIFYBUSINESS = "/thirdPlatformForeign/call/v2/AddAndModifyBusiness";
    //新增调班单
    public static String ADDCHANGEWORKDAY = "/thirdPlatformForeign/call/v2/addChangeWorkDay";
    //新增签卡单
    public static String INSERTSIGNCARD = "/thirdPlatformForeign/call/v2/insertSignCard";
    //新增刷卡数据
    public static String ADDATTENDANCE = "/thirdPlatformForeign/call/v2/addAttendance";
    //组织信息导入接口
    public static String INSERTPERORGSSTANDARD = "/thirdPlatformForeign/call/v2/insertPerOrgsStandard";
    //岗位信息导入接口
    public static String INSERTPERPOSTSTANDARD = "/thirdPlatformForeign/call/v2/insertPerPostStandard";
    //员工信息导入接口
    public static String INSERTEMPINFOSTANDARD = "/thirdPlatformForeign/call/v2/insertEmpInfoStandard";
    //新增转正单
    public static String INSERTPROBATIONREGULARAPPLY = "/thirdPlatformForeign/call/v2/insertProbationRegularApply";
    //新增内部流动单
    public static String INSERTPERFLOWAPPLY = "/thirdPlatformForeign/call/v2/insertPerFlowApply";
    //新增离职单
    public static String INSERTDIMISSIONORDER = "/thirdPlatformForeign/call/v2/insertDimissionOrder";
    //查询组织接口
    public static String QUERYALLPERORGS = "/thirdPlatformForeign/call/v2/queryAllPerOrgs";
    //查询岗位接口
    public static String QUERYALLEMPIPER_POST = "/thirdPlatformForeign/call/v2/queryAllEmpIper_post";
    //查询人员接口
    public static String QUERYALLEMPINFOS = "/thirdPlatformForeign/call/v2/queryAllEmpInfos";


}
