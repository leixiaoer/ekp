package com.landray.kmss.geesun.ehr.config;

import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.Properties;

import org.springframework.stereotype.Component;

import com.landray.kmss.geesun.ehr.utils.PropertiesUtil;
import com.landray.kmss.sys.config.loader.ConfigLocationsUtil;

@Component
public class HttpAuthenticator extends Authenticator {
    public static final String PATH_MODULE_CLASSES = ConfigLocationsUtil
            .getWebContentPath()
            + "/WEB-INF/classes/com/landray/kmss/geesun/ekp/config";
//	public static final String PATH_MODULE_CLASSES = "D:/";

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        Properties prop = null;
        try {
            prop = PropertiesUtil.readProperties("ekp.properties", PATH_MODULE_CLASSES);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return new PasswordAuthentication(prop.getProperty("username"), prop.getProperty("password").toCharArray());
    }

}
