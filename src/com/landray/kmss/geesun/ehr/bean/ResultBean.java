package com.landray.kmss.geesun.ehr.bean;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *webapi请求返回的结果
 * @author huangzhuanglai
 */
public class ResultBean extends LinkedHashMap<String, Object> implements Serializable {

    private static final long serialVersionUID = 1L;    // 序列化版本号

    public static final int CODE_SUCCESS = 200;
    public static final int CODE_ERROR = 400;


    /**
     * 构建
     */
    public ResultBean() {
    }

    /**
     * 构建
     *
     * @param code 状态码
     * @param msg  信息
     * @param data 数据
     */
    public ResultBean(int code, String msg, Object data) {
        this.setCode(code);
        this.setMsg(msg);
        this.setData(data);
    }

    /**
     * 根据 Map 快速构建
     *
     * @param map /
     */
    public ResultBean(Map<String, Object> map) {
        for (String key : map.keySet()) {
            this.set(key, map.get(key));
        }
    }

    /**
     * 获取code
     *
     * @return code
     */
    public Integer getCode() {
        return (Integer) this.get("code");
    }

    /**
     * 获取msg
     *
     * @return msg
     */
    public String getMsg() {
        return (String) this.get("message");
    }

    /**
     * 获取data
     *
     * @return data
     */
    public Object getData() {
        return (Object) this.get("data");
    }

    /**
     * 给code赋值，连缀风格
     *
     * @param code code
     * @return 对象自身
     */
    public ResultBean setCode(int code) {
        this.put("code", code);
        return this;
    }

    /**
     * 给msg赋值，连缀风格
     *
     * @param msg msg
     */
    public void setMsg(String msg) {
        this.put("message", msg);
    }

    /**
     * 给data赋值，连缀风格
     *
     * @param data data
     * @return 对象自身
     */
    public ResultBean setData(Object data) {
        this.put("data", data);
        return this;
    }

    /**
     * 写入一个值 自定义key, 连缀风格
     *
     * @param key  key
     * @param data data
     * @return 对象自身
     */
    public ResultBean set(String key, Object data) {
        this.put(key, data);
        return this;
    }

    /**
     * 写入一个Map, 连缀风格
     *
     * @param map map
     * @return 对象自身
     */
    public ResultBean setMap(Map<String, ?> map) {
        for (String key : map.keySet()) {
            this.put(key, map.get(key));
        }
        return this;
    }


    // ============================  构建  ==================================

    // 构建成功
    public static ResultBean ok() {
        return new ResultBean(CODE_SUCCESS, "ok", null);
    }

    public static ResultBean ok(String msg) {
        return new ResultBean(CODE_SUCCESS, msg, null);
    }

    public static ResultBean code(int code) {
        return new ResultBean(code, null, null);
    }

    public static ResultBean data(Object data) {
        return new ResultBean(CODE_SUCCESS, "ok", data);
    }

    // 构建失败
    public static ResultBean error() {
        return new ResultBean(CODE_ERROR, "error", null);
    }

    public static ResultBean error(String msg) {
        return new ResultBean(CODE_ERROR, msg, null);
    }

    // 构建指定状态码
    public static ResultBean get(int code, String msg, Object data) {
        return new ResultBean(code, msg, data);
    }


    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "{"
                + "\"code\": " + this.getCode()
                + ", \"message\": " + transValue(this.getMsg())
                + ", \"data\": " + transValue(this.getData())
                + "}";
    }

    private String transValue(Object value) {
        if (value instanceof String) {
            return "\"" + value + "\"";
        }
        return String.valueOf(value);
    }

    
    
}