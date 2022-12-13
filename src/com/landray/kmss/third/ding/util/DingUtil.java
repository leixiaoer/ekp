package com.landray.kmss.third.ding.util;

import com.dingtalk.api.response.OapiProcessWorkrecordUpdateResponse;
import com.landray.kmss.common.dao.HQLInfo;
import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.sys.config.dict.SysDataDict;
import com.landray.kmss.sys.config.dict.SysDictModel;
import com.landray.kmss.sys.notify.model.SysNotifyTodo;
import com.landray.kmss.sys.organization.model.SysOrgPerson;
import com.landray.kmss.third.ding.model.DingConfig;
import com.landray.kmss.third.ding.model.ThirdDingDinstanceXform;
import com.landray.kmss.third.ding.model.ThirdDingDtemplateXform;
import com.landray.kmss.third.ding.oms.DingApiService;
import com.landray.kmss.third.ding.provider.DingNotifyUtil;
import com.landray.kmss.third.ding.service.IOmsRelationService;
import com.landray.kmss.third.ding.service.IThirdDingDinstanceXformService;
import com.landray.kmss.third.ding.service.IThirdDingDtemplateXformService;
import com.landray.kmss.third.ding.xform.util.ThirdDingXFormTemplateUtil;
import com.landray.kmss.util.HQLUtil;
import com.landray.kmss.util.ModelUtil;
import com.landray.kmss.util.ObjectXML;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SecureUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.TransactionUtils;
import com.opensymphony.util.BeanUtils;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import net.sf.json.JSONObject;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;

public class DingUtil
{
  private static final Log logger = LogFactory.getLog(DingUtil.class);
  private IOmsRelationService omsRelationService;
  private static IThirdDingDinstanceXformService thirdDingDinstanceXformService;

  public IOmsRelationService getOmsRelationService()
  {
    if (this.omsRelationService == null) {
      this.omsRelationService = ((IOmsRelationService)
        SpringBeanUtil.getBean("omsRelationService"));
    }
    return this.omsRelationService;
  }

  public static IThirdDingDinstanceXformService getThirdDingDinstanceXformService()
  {
    if (thirdDingDinstanceXformService == null) {
      thirdDingDinstanceXformService = (IThirdDingDinstanceXformService)
        SpringBeanUtil.getBean("thirdDingDinstanceXformService");
    }
    return thirdDingDinstanceXformService;
  }

  public void setOmsRelationService(IOmsRelationService omsRelationService) {
    this.omsRelationService = omsRelationService;
  }

  public static String getModelTemplateProperyId(IBaseModel baseModel, String property, Locale local) throws Exception
  {
    String fdTemplateId = null;
    String tempString = ModelUtil.getModelPropertyString(baseModel, property, "", local);
    if (StringUtil.isNotNull(tempString)) {
      Object fdTemplate = PropertyUtils.getProperty(baseModel, property);
      if (fdTemplate != null) {
        fdTemplateId = ((IBaseModel)fdTemplate).getFdId();
      }
    }
    return fdTemplateId;
  }

  public static Map<String, Object> getExtendDataModelInfo(IBaseModel baseModel) throws Exception {
    Map modelData = null;

    String extendDataXML = (String)BeanUtils.getValue(baseModel, 
      "extendDataXML");
    if ((StringUtil.isNotNull(extendDataXML)) && 
      (modelData == null)) {
      if (StringUtil.isNull(extendDataXML)) {
        modelData = new HashMap();
      } else {
        List datas = ObjectXML.objectXMLDecoderByString(extendDataXML);
        if ((datas != null) && (!datas.isEmpty()))
          modelData = (Map)datas.get(0);
        else {
          modelData = new HashMap();
        }
      }
    }

    return modelData;
  }

  public static String getModelDocCreatorProperyValue(IBaseModel baseModel, String property, Locale local) throws Exception
  {
    String rtnStr = "";
    String tempString = ModelUtil.getModelPropertyString(baseModel, property, "", local);
    if (StringUtil.isNotNull(tempString)) {
      SysOrgPerson sysOrgPerson = (SysOrgPerson)PropertyUtils.getProperty(baseModel, property);
      if (sysOrgPerson != null) {
        rtnStr = sysOrgPerson.getFdLoginName();
      }
    }
    return rtnStr;
  }

  public static String getModelSimpleClassName(String modelName, String fdId)
  {
    try {
      SysDictModel sysDictModel = SysDataDict.getInstance().getModel(modelName);
      IBaseService baseService = (IBaseService)SpringBeanUtil.getBean(sysDictModel.getServiceBean());

      IBaseModel baseModel = baseService.findByPrimaryKey(fdId);

      String rtnVal = baseModel.getClass().getSimpleName();
      int i = rtnVal.indexOf('$');
      if (i > -1);
      return rtnVal.substring(0, i);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  public static Set<String> getDingIdSet(List<String> ekpIds) throws Exception
  {
    IOmsRelationService omsRelationService = (IOmsRelationService)
      SpringBeanUtil.getBean("omsRelationService");
    HQLInfo hqlInfo = new HQLInfo();
    hqlInfo.setSelectBlock(
      " omsRelationModel.fdAppPkId ");
    hqlInfo.setWhereBlock(
      HQLUtil.buildLogicIN("omsRelationModel.fdEkpId", ekpIds));
    List<String> list = omsRelationService.findList(hqlInfo);

    Set dingIdSet = new HashSet();
    if (list == null) {
      return null;
    }
    for (String dingId : list) {
      if ((StringUtil.isNotNull(dingId)) && (!dingId.equals("null"))) {
        dingIdSet.add(dingId);
      }
    }
    return dingIdSet;
  }

  public static Map<String, String> getDingIdMap(List<String> ekpIds)
    throws Exception
  {
    if ((ekpIds == null) || (ekpIds.isEmpty())) {
      return new HashMap();
    }
    IOmsRelationService omsRelationService = (IOmsRelationService)
      SpringBeanUtil.getBean("omsRelationService");
    HQLInfo hqlInfo = new HQLInfo();
    hqlInfo.setSelectBlock(
      " omsRelationModel.fdAppPkId, omsRelationModel.fdEkpId ");
    hqlInfo.setWhereBlock(
      HQLUtil.buildLogicIN("omsRelationModel.fdEkpId", ekpIds));
    List<Object[]> list = omsRelationService.findList(hqlInfo);

    Map dingIdMap = new HashMap();
    if (list == null) {
      return null;
    }
    for (Object[] o : list) {
      String dingId = (String)o[0];
      String ekpId = (String)o[1];
      if ((StringUtil.isNotNull(dingId)) && (!dingId.equals("null"))) {
        dingIdMap.put(dingId, ekpId);
      }
    }
    return dingIdMap;
  }

  public static String getViewUrl(SysNotifyTodo todo) {
    String viewUrl = null;
    String domainName = DingConfig.newInstance().getDingDomain();
    if (StringUtil.isNull(domainName)) {
      domainName = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
    }
    if (StringUtil.isNotNull(todo.getFdId())) {
      viewUrl = "/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=view&fdId=" + 
        todo.getFdId() + "&oauth=ekp";
      if (StringUtils.isNotEmpty(domainName))
        viewUrl = domainName + viewUrl;
      else
        viewUrl = StringUtil.formatUrl(viewUrl);
    }
    else {
      if (StringUtil.isNull(domainName))
        domainName = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
      if (domainName.endsWith("/"))
        domainName = domainName.substring(0, domainName.length() - 1);
      viewUrl = StringUtil.formatUrl(todo.getFdLink(), domainName);
      if (viewUrl.indexOf("?") == -1)
        viewUrl = viewUrl + "?oauth=ekp";
      else {
        viewUrl = viewUrl + "&oauth=ekp";
      }
    }
    return viewUrl;
  }

  public static String getPcInnerViewUrl(SysNotifyTodo todo) {
    String viewUrl = null;
    String domainName = DingConfig.newInstance().getDingDomain();
    if (StringUtil.isNull(domainName)) {
      domainName = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
    }
    if (StringUtil.isNotNull(todo.getFdId())) {
      viewUrl = "/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=view&fdId=" + 
        todo.getFdId();
      if (StringUtils.isNotEmpty(domainName))
        viewUrl = domainName + viewUrl;
      else
        viewUrl = StringUtil.formatUrl(viewUrl);
    }
    else {
      if (StringUtil.isNull(domainName))
        domainName = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
      if (domainName.endsWith("/"))
        domainName = domainName.substring(0, domainName.length() - 1);
      viewUrl = StringUtil.formatUrl(todo.getFdLink(), domainName);
    }

    viewUrl = domainName + "/third/ding/pc/web_wnd.jsp?url=" + 
      URLEncoder.encode(viewUrl);
    viewUrl = StringUtil.setQueryParameter(viewUrl, "ddtab", "true");
    return viewUrl;
  }

  public static String getPcViewUrl(SysNotifyTodo todo) {
    String dingTodoPcOpenType = DingConfig.newInstance()
      .getDingTodoPcOpenType();
    if ("in".equals(dingTodoPcOpenType)) {
      return getPcInnerViewUrl(todo);
    }
    String domainName = DingConfig.newInstance().getDingDomain();
    if (StringUtil.isNull(domainName)) {
      domainName = ResourceUtil.getKmssConfigString("kmss.urlPrefix");
    }
    String pcViewUrl = domainName;
    if ("true".equals(DingConfig.newInstance().getDingTodoSsoEnabled())) {
      pcViewUrl = 
        StringUtil.formatUrl("/resource/jsp/sso_redirect.jsp?url=" + 
        SecureUtil.BASE64Encoder(getViewUrl(todo)));
    }
    else if (StringUtil.isNotNull(todo.getFdId())) {
      pcViewUrl = domainName + "/third/ding/pc/pcopen.jsp?fdTodoId=" + 
        todo.getFdId() + 
        "&appId=" + DingConfig.newInstance().getDingAgentid() + 
        "&oauth=ekp";
    } else {
      if (StringUtil.isNull(domainName))
        domainName = 
          ResourceUtil.getKmssConfigString("kmss.urlPrefix");
      if (domainName.endsWith("/"))
        domainName = domainName.substring(0, 
          domainName.length() - 1);
      pcViewUrl = StringUtil.formatUrl(todo.getFdLink(), domainName);
      if (pcViewUrl.indexOf("?") == -1)
        pcViewUrl = pcViewUrl + "?oauth=ekp";
      else {
        pcViewUrl = pcViewUrl + "&oauth=ekp";
      }
      pcViewUrl = domainName + "/third/ding/pc/pcopen.jsp?url=" + 
        SecureUtil.BASE64Encoder(pcViewUrl) + 
        "&oauth=ekp";
    }

    return pcViewUrl;
  }

  public static String getValueByLang(String key, String bundle, String lang)
  {
    Locale locale = null;
    if ((StringUtil.isNotNull(lang)) && 
      (lang.contains("-"))) {
      locale = new Locale(lang.split("-")[0], 
        lang.split("-")[1]);
    }
    return ResourceUtil.getStringValue(key, bundle, locale);
  }

  public static boolean checkNotifyApiType(String apiType) {
    DingConfig dingConfig = DingConfig.newInstance();
    String notifyApiType = dingConfig.getNotifyApiType();
    if (apiType.equals(notifyApiType)) {
      return true;
    }
    return false;
  }

  public static String getDingPcUrl(String url)
  {
    if (StringUtil.isNull(url)) {
      return null;
    }
    url = url.trim();
    String dingDomain = DingConfig.newInstance().getDingDomain();
    if (StringUtil.isNull(dingDomain)) {
      dingDomain = 
        ResourceUtil.getKmssConfigString("kmss.urlPrefix");
    }
    if (dingDomain.trim().endsWith("/")) {
      dingDomain = dingDomain.trim().substring(0, 
        dingDomain.length() - 1);
    }

    if (url.indexOf("http") != 0) {
      if (url.startsWith("/"))
        url = dingDomain + url.trim();
      else {
        url = dingDomain + "/" + url.trim();
      }
    }
    logger.debug("url:" + url);

    String dingTodoPcOpenType = DingConfig.newInstance()
      .getDingTodoPcOpenType();
    if ("in".equals(dingTodoPcOpenType))
    {
      url = dingDomain + "/third/ding/pc/web_wnd.jsp?url=" + 
        URLEncoder.encode(url);
      return url;
    }

    url = dingDomain + "/third/ding/pc/url_out.jsp?pg=" + 
      SecureUtil.BASE64Encoder(url);
    logger.debug("外部打开 url:" + url);

    return url;
  }

  public static boolean isXformTemplate(SysNotifyTodo todo)
  {
    try
    {
      if (todo == null)
        return false;
      String modelName = todo.getFdModelName();

      if (!"com.landray.kmss.km.review.model.KmReviewMain"
        .equals(modelName)) {
        return false;
      }
      DingConfig config = DingConfig.newInstance();
      IBaseService obj = (IBaseService)
        SpringBeanUtil.getBean("kmReviewMainService");
      IBaseModel kmReviewBaseModel = obj
        .findByPrimaryKey(todo.getFdModelId());
      String type = 
        ThirdDingXFormTemplateUtil.getXFormTemplateType(kmReviewBaseModel);
      logger.debug("type:" + type);
      if (("true".equals(config.getDingEnabled())) && (
        ("true".equals(config.getAttendanceEnabled())) || (
        ("true".equals(config.getDingSuitEnabled())) && 
        (StringUtil.isNotNull(type)))))
        return true;
    }
    catch (Exception e) {
      logger.error(e.getMessage(), e);
    }
    return false;
  }

  public static boolean hasInstanceInXform(SysNotifyTodo todo)
  {
    if (getInstanceXform(todo) == null) {
      return false;
    }
    return true;
  }

  private static ThirdDingDinstanceXform getInstanceXform(SysNotifyTodo todo)
  {
    HQLInfo hql = new HQLInfo();
    hql.setWhereBlock(
      "fdEkpInstanceId=:fdEkpInstanceId and fdStatus=:fdStatus");
    hql.setParameter("fdEkpInstanceId", todo.getFdModelId());
    hql.setParameter("fdStatus", "20");
    try {
      List list = getThirdDingDinstanceXformService()
        .findList(hql);
      if ((list != null) && (list.size() > 0)) {
        return (ThirdDingDinstanceXform)list.get(0);
      }
      logger.debug("在高级审批实例中不存在该主文档");
      return null;
    }
    catch (Exception e) {
      logger.error(e.getMessage(), e);
    }
    return null;
  }

  public void deleteReviewMain(String reviewMainId)
  {
    logger.warn("----流程主文档删除----" + reviewMainId);
  }

  public void dealWithDingTemplate(String method, String type, String templateId, String categoryId, String templateName, List allReader, String desc)
  {
    logger.info("流程模版变更  method：" + method + "   type:" + type + 
      "  templateId:" + templateId);
    try {
      DingConfig config = DingConfig.newInstance();
      if (("true".equals(config.getDingEnabled())) && 
        ("true".equals(config.getDingSuitEnabled())) && 
        (StringUtil.isNotNull(type))) {
        IThirdDingDtemplateXformService thirdDingDtemplateXformService = (IThirdDingDtemplateXformService)
          SpringBeanUtil.getBean("thirdDingDtemplateXformService");
        if ("delete".equals(method)) {
          logger.info("------删除钉钉模板-------" + templateName);
          HQLInfo hql = new HQLInfo();
          hql.setWhereBlock(
            "fdTemplateId=:fdTemplateId and fdIsAvailable=:fdIsAvailable");
          hql.setParameter("fdTemplateId", templateId);
          hql.setParameter("fdIsAvailable", Boolean.valueOf(true));
          List temp_list = thirdDingDtemplateXformService
            .findList(hql);
          if ((temp_list != null) && (temp_list.size() > 0))
            for (int j = 0; j < temp_list.size(); j++) {
              ThirdDingDtemplateXform temp = (ThirdDingDtemplateXform)temp_list.get(j);
              logger.warn("删除钉钉模板：" + temp.getFdName());
              thirdDingDtemplateXformService.deleteTemplate(temp);
            }
          else
            logger.debug(
              "【钉钉模板中找不到对应的记录,删除忽略】templateId：" + templateId);
        }
        else
        {
          if (StringUtil.isNull(type)) {
            type = "common";
          }
          JSONObject parm = new JSONObject();
          parm.put("desc", desc);
          parm.put("name", templateName);
          parm.put("fdId", templateId);
          parm.put("categoryId", categoryId);
          parm.put("type", type);
          List titleList = new ArrayList();

          if ("attendance".equals(type))
          {
            titleList.add("请假类型");
            titleList.add("开始时间");
            titleList.add("结束时间");
            titleList.add("时长");
            titleList.add("请假原因");
          } else if ("batchLeave".equals(type))
          {
            titleList.add("请假类型");
            titleList.add("总时长");
            titleList.add("请假原因");
            titleList.add("时长");
            titleList.add("开始时间");
            titleList.add("结束时间");
          } else if ("workOverTime".equals(type))
          {
            titleList.add("加班人");
            titleList.add("开始时间");
            titleList.add("结束时间");
          } else if ("goOut".equals(type))
          {
            titleList.add("开始时间");
            titleList.add("结束时间");
            titleList.add("时长");
          } else if ("businessTrip".equals(type))
          {
            titleList.add("出差事由");
            titleList.add("交通工具");
            titleList.add("单程往返");
          } else if ("changeOff".equals(type))
          {
            titleList.add("申请人");
            titleList.add("替班人");
            titleList.add("换班日期");
          } else if ("replacement".equals(type))
          {
            titleList.add("补卡时间");
            titleList.add("补卡理由");
            titleList.add("补卡班次");
          } else if ("destroyLeave".equals(type))
          {
            titleList.add("请假单");
            titleList.add("销假时长");
            titleList.add("剩余请假时长");
          }
          else if ("batchReplacement".equals(type))
          {
            titleList.add("补卡时间");
            titleList.add("补卡原因");
          } else if ("batchCancel".equals(type))
          {
            titleList.add("请假单");
            titleList.add("销假时长");
            titleList.add("剩余请假时长");
          } else if ("batchChange".equals(type))
          {
            titleList.add("申请人");
            titleList.add("替班人");
            titleList.add("换班日期");
            titleList.add("还班日期");
            titleList.add("换班说明");
            titleList.add("还班说明");
          } else if ("batchWorkOverTime".equals(type))
          {
            titleList.add("加班人");
            titleList.add("开始时间");
            titleList.add("结束时间");
            titleList.add("时长");
            titleList.add("加班类型");
            titleList.add("加班补偿");
          }

          String dirId = "other";
          HQLInfo hqlInfo = new HQLInfo();
          hqlInfo.setWhereBlock(
            "fdTemplateId=:fdTemplateId and fdIsAvailable=:fdIsAvailable and fdCorpid=:fdCorpid");
          hqlInfo.setParameter("fdTemplateId", categoryId);
          hqlInfo.setParameter("fdIsAvailable", Boolean.valueOf(true));
          hqlInfo.setParameter("fdCorpid", config.getDingCorpid());
          String icon = "common";
          if (("attendance".equals(type)) || 
            ("batchLeave".equals(type)))
            icon = "leave";
          else if ("workOverTime".equals(type))
            icon = "common";
          else if ("goOut".equals(type))
            icon = "out";
          else if ("businessTrip".equals(type))
            icon = "trip";
          else if ("changeOff".equals(type))
            icon = "common";
          else if ("replacement".equals(type))
            icon = "common";
          else if (("destroyLeave".equals(type)) || 
            ("batchCancel".equals(type)))
            icon = "leave#orange";
          else if ("batchReplacement".equals(type))
            icon = "leave#yellow";
          else if ("batchChange".equals(type))
            icon = "relieve#blue";
          else if ("batchWorkOverTime".equals(type)) {
            icon = "timefades";
          }

          String domainName = DingConfig.newInstance()
            .getDingDomain();
          if (StringUtil.isNull(domainName)) {
            domainName = 
              ResourceUtil.getKmssConfigString("kmss.urlPrefix");
          }
          String instanceUrl = domainName + 
            "/km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId=" + 
            templateId;
          String template_edit_url = domainName + 
            "/km/review/km_review_template/kmReviewTemplate.do?method=edit&fdId=" + 
            templateId + "&from=dingmng";
          JSONObject process_config = new JSONObject();
          process_config.put("disable_form_edit", Boolean.valueOf(true));
          process_config.put("fake_template_edit_url", 
            template_edit_url);
          process_config.put("template_edit_url", template_edit_url);
          process_config.put("hidden", Boolean.valueOf(false));

          JSONObject save_config = new JSONObject();
          save_config.put("process_config", process_config);
          save_config.put("create_instance_pc_url", instanceUrl);
          save_config.put("create_instance_mobile_url", instanceUrl);
          save_config.put("dir_id", dirId);

          save_config.put("icon", icon);
          parm.put("save_config", save_config);

          if ("add".equals(method)) {
            logger.debug("------新增钉钉模板-------");

            thirdDingDtemplateXformService.addCommonTemplate(null, 
              null, 
              titleList, parm, allReader);
          }
          else if ("update".equals(method)) {
            logger.debug("------更新钉钉模板-------");
            hqlInfo = new HQLInfo();
            hqlInfo.setWhereBlock(
              "fdTemplateId=:fdTemplateId and fdIsAvailable=:fdIsAvailable");
            hqlInfo.setParameter("fdTemplateId", templateId);
            hqlInfo.setParameter("fdIsAvailable", Boolean.valueOf(true));
            List temp_list = thirdDingDtemplateXformService
              .findList(hqlInfo);
            if ((temp_list != null) && (temp_list.size() > 0)) {
              ThirdDingDtemplateXform temp = (ThirdDingDtemplateXform)temp_list.get(0);
              logger.debug("更新钉钉模板：" + temp.getFdName());
              thirdDingDtemplateXformService.addCommonTemplate(
                temp, 
                null, 
                titleList, parm, allReader);
            } else {
              logger.warn("找不到对应的钉钉模板或者模板已不可用,新增模板");
              thirdDingDtemplateXformService.addCommonTemplate(
                null, 
                null, 
                titleList, parm, allReader);
            }
          }
        }

      }
      else
      {
        logger.debug("-----------钉钉高级审批功能不开启/套件--------------");
      }
    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      e.printStackTrace();
    }
  }

  public static boolean checkUrlByDomain(String url)
  {
    String dealWithAll = DingConfig.newInstance().getDealWithAllErrNotify();
    if ((StringUtil.isNotNull(dealWithAll)) && 
      ("true".equalsIgnoreCase(dealWithAll))) {
      return true;
    }
    String domainName = DingConfig.newInstance()
      .getDingDomain();
    if (StringUtil.isNull(domainName)) {
      domainName = 
        ResourceUtil.getKmssConfigString("kmss.urlPrefix");
    }
    domainName = domainName.trim();
    logger.debug("domainName:" + domainName);
    if ((StringUtil.isNotNull(url)) && 
      (!url.startsWith(domainName))) {
      return false;
    }

    return true;
  }

  public static Object getModelPropertyString(Object model, String propertyName, String splitStr, Locale locale)
    throws Exception
  {
    return BeanUtils.getValue(model, propertyName);
  }
}