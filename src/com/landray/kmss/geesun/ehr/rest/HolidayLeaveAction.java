package com.landray.kmss.geesun.ehr.rest;

import java.math.BigDecimal;
import java.net.Authenticator;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.landray.kmss.geesun.ehr.bean.BackFromLeaveBean;
import com.landray.kmss.geesun.ehr.bean.CancelTirpBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.fssc.common.interfaces.IFsscCommonBudgetOperatService;
import com.landray.kmss.geesun.ehr.bean.InsertLeaveBean;
import com.landray.kmss.geesun.ehr.bean.ResultBean;
import com.landray.kmss.geesun.ehr.config.HttpAuthenticator;
import com.landray.kmss.geesun.ehr.constants.HolidayEnum;
import com.landray.kmss.geesun.ehr.constants.HolidayTypeConstants;
import com.landray.kmss.geesun.ehr.constants.UrlConstants;
import com.landray.kmss.geesun.ehr.utils.PropertiesUtil;
import com.landray.kmss.km.review.model.KmReviewMain;
import com.landray.kmss.util.SpringBeanUtil;

/**
 * @author huangzhuanglai
 * @description 请假流程-二次开发 zgf
 * 1. 完成后发送请假相关信息至EHR系统
 */
public class HolidayLeaveAction {


    private IFsscCommonBudgetOperatService fsscBudgetOperatService;

    public IFsscCommonBudgetOperatService getFsscBudgetOperatService() {
        if (fsscBudgetOperatService == null) {
            fsscBudgetOperatService = (IFsscCommonBudgetOperatService) SpringBeanUtil.getBean("fsscBudgetOperatService");
        }
        return fsscBudgetOperatService;
    }

    /**
     * 发送请假信息至EHR系统 已完成
     *
     * @param baseModel
     */
    public void sendLeaveMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        InsertLeaveBean insertLeaveBean = new InsertLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertLeaveBean.setEmpNo(epmNo);//工号
            insertLeaveBean.setCode(code);//单号
            Double type = (Double) modelData.get("fd_395a0c2b56a790");
            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertLeaveBean.setLeaveCategoryName(HolidayEnum.getHolidayValue((new BigDecimal(type)).intValue()).toString());//请假类型
            insertLeaveBean.setLeaveWay(HolidayTypeConstants.LEAVE_CATEGORY_NUM_SJ);//请假方式
            insertLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由
            insertLeaveBean.setEmpName((String) modelData.get("fd_39897a8b17befc"));//员工姓名

            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERT_LEAVE;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


    }

    /**
     * 发送新增销假单至EHR系统    已完成 暂定
     *
     * @param baseModel
     */
    public void sendBackFromLeaveMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            //区分假类型分组
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.BACKFROMLEAVE;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送出差单作废至EHR系统
     *
     * @param baseModel
     */
    public void sendCancelTirpeMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;

        //出菜单作废实体
        CancelTirpBean cancelTirpBean = new CancelTirpBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            //单号
            cancelTirpBean.setCode(code);
            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.CANCELTIRP;
            Map paramMap = new HashMap();
            paramMap.put("paramStr", cancelTirpBean);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 发送请假单作废至EHR系统
     *
     * @param baseModel
     */
    public void sendCancelOderLeaveMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.CANCELODERLEAVE;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 发送新增加班单至EHR系统
     *
     * @param baseModel
     */
    public void sendAddworkoverMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.ADDWORKOVER;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增出差单至EHR系统
     *
     * @param baseModel
     */
    public void sendAddAndModifyBusinessMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.ADDANDMODIFYBUSINESS;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增调班单至EHR系统
     *
     * @param baseModel
     */
    public void sendAddChangeWorkDayMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.ADDCHANGEWORKDAY;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增签卡单至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertSignCardMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTSIGNCARD;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增刷卡数据至EHR系统
     *
     * @param baseModel
     */
    public void sendAddAttendanceMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.ADDATTENDANCE;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送组织信息导入至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertPerOrgsStandardMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTPERORGSSTANDARD;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 发送岗位信息导入至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertPerPostStandardMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTPERPOSTSTANDARD;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送员工信息导入至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertEmpInfoStandardMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTEMPINFOSTANDARD;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增转正单至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertProbationRegularApplyMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTPROBATIONREGULARAPPLY;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增内部流动单至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertPerFlowApplyMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTPERFLOWAPPLY;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送新增离职单至EHR系统
     *
     * @param baseModel
     */
    public void sendInsertDimissionOrderMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERTDIMISSIONORDER;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送查询组织接口至EHR系统
     *
     * @param baseModel
     */
    public void sendQueryAllPerOrgsMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.QUERYALLPERORGS;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();

                //dataList 返回的数据进行返回

                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 发送查询岗位接口至EHR系统
     *
     * @param baseModel
     */
    public void sendQueryAllEmpIperPostMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.QUERYALLEMPIPER_POST;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    /**
     * 发送查询人员接口至EHR系统
     *
     * @param baseModel
     */
    public void sendQueryAllEmpInfosMessageToEHR(IBaseModel baseModel) {
        if (baseModel == null) {
            return;
        }
        StringBuffer messageSB = new StringBuffer(400);
        KmReviewMain kmReviewMain = (KmReviewMain) baseModel;
        BackFromLeaveBean insertBackFromLeaveBean = new BackFromLeaveBean();
        try {
            Map<String, Object> modelData = kmReviewMain.getExtendDataModelInfo().getModelData();
            String code = (String) modelData.get("fd_39a72a56bd8cba");
            String epmNo = (String) modelData.get("fd_395a0b6068acaa");
            insertBackFromLeaveBean.setEmpNo(epmNo);//工号
            insertBackFromLeaveBean.setCode(code);//单号

            Double type = (Double) modelData.get("fd_395a0c2b56a790");

            String startDateTimeID = "";
            String endDateTimeID = "";
            if (type == 12 || type == 14 || type == 15 || type == 16 || type == 9 || type == 3) {
                startDateTimeID = "fd_3968fd2698034e";
                endDateTimeID = "fd_3968fd27cef0fc";
            } else {
                startDateTimeID = "fd_39443cd6b60ebe";
                endDateTimeID = "fd_39443cdd503ed6";
            }
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");
            String beginDateTimeValue = sdf.format((Date) modelData.get(startDateTimeID));
            String endDateTimeValue = sdf.format((Date) modelData.get(endDateTimeID));
            insertBackFromLeaveBean.setBeginDate(beginDateTimeValue.substring(0, beginDateTimeValue.indexOf(' ')));//开始日期
            insertBackFromLeaveBean.setBeginTime(beginDateTimeValue.substring(beginDateTimeValue.indexOf(' ') + 1));//开始时间

            insertBackFromLeaveBean.setEndDate(endDateTimeValue.substring(0, endDateTimeValue.indexOf(' ')));//结束日期
            insertBackFromLeaveBean.setEndTime(endDateTimeValue.substring(endDateTimeValue.indexOf(' ') + 1));//结束时间
            insertBackFromLeaveBean.setReason((String) modelData.get("fd_39443befb81d3e"));//请假缘由

            /**
             * 需要修改的点，需要修改成对于的参数字符串 代码code      exam：fd_39897a8b17befc
             */
            insertBackFromLeaveBean.setLeaveOrderCode((String) modelData.get("fd_39897a8b17befc"));//请假单单号
            insertBackFromLeaveBean.setTotalDay((String) modelData.get("fd_39897a8b17befc"));//总天数
            insertBackFromLeaveBean.setTotalHour((String) modelData.get("fd_39897a8b17befc"));//总时数


            //开始推送信息至EHR
            RestTemplate restTemplate = new RestTemplate();
            HttpAuthenticator authenticator = new HttpAuthenticator();
            Authenticator.setDefault(authenticator);

            String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.QUERYALLEMPINFOS;
            Map paramMap = new HashMap();
            List valueList = new ArrayList();
            valueList.add(insertBackFromLeaveBean);
            paramMap.put("paramStr", valueList);

            ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, paramMap, ResultBean.class);

            if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
                List dataList = (List) entity.getBody().getData();
                if (entity.getBody().getCode() == ResultBean.CODE_SUCCESS) {//集成成功
                    messageSB.append("成功");
                } else {
                    messageSB.append("失败：" + entity.getBody().getMsg());
                }
            } else {
                //访问失败
                messageSB.append("访问EHR：" + url).append("失败:" + entity.getBody().getMsg());
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            messageSB.append("异常：" + e.getMessage());
        }

        JSONArray params = new JSONArray();
        JSONObject row = new JSONObject();
        row.put("fd_3b55e5ae5550a6", messageSB.toString());
        params.add(row);

        try {
            getFsscBudgetOperatService().updateFsscBudgetExecute(params);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}

