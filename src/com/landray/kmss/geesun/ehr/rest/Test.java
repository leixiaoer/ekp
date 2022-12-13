package com.landray.kmss.geesun.ehr.rest;

import com.landray.kmss.geesun.ehr.bean.InsertLeaveBean;
import com.landray.kmss.geesun.ehr.bean.ResultBean;
import com.landray.kmss.geesun.ehr.config.HttpAuthenticator;
import com.landray.kmss.geesun.ehr.constants.UrlConstants;
import com.landray.kmss.geesun.ehr.utils.PropertiesUtil;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.net.Authenticator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Test {

    public void test() throws IOException {
        RestTemplate restTemplate = new RestTemplate();
        HttpAuthenticator authenticator = new HttpAuthenticator();
        Authenticator.setDefault(authenticator);
        String url = PropertiesUtil.readProperties("ehr_url", "ehr.properties", HttpAuthenticator.PATH_MODULE_CLASSES) + UrlConstants.INSERT_LEAVE;
        System.out.println(url);
        Map param = new HashMap();
        List paramStr = new ArrayList();
        InsertLeaveBean insertLeaveBean = new InsertLeaveBean();
        insertLeaveBean.setCode("L20220518005");
        insertLeaveBean.setEmpNo("GY12919");
        insertLeaveBean.setLeaveCategoryName("事假");
        insertLeaveBean.setLeaveWay("4");//请假方式
        insertLeaveBean.setBeginDate("2022-05-18");
        insertLeaveBean.setBeginTime("08:30");
        insertLeaveBean.setEndDate("2022-05-18");
        insertLeaveBean.setEndTime("17:50");
        insertLeaveBean.setReason("就想请假");
        paramStr.add(insertLeaveBean);
        paramStr.add(insertLeaveBean);
        param.put("paramStr", paramStr);

        ResponseEntity<ResultBean> entity = restTemplate.postForEntity(url, param, ResultBean.class);
        if (entity.getStatusCode().value() == HttpStatus.OK.value()) {
            String a = entity.getBody().getMsg();
            System.out.println(a);
        }
    }

    public static void main(String[] args) throws IOException {
        Test test = new Test();
        test.test();
    }
}
