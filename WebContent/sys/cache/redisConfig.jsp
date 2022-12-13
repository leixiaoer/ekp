<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<table class="tb_normal" width=100%>
	<tr>
		<td class="td_normal_title" colspan=2>
			<b>
				<xform:checkbox property="value(cache.redis.enabled)" onValueChange="config_redis_chgEnabled" showStatus="edit">
					<xform:simpleDataSource value="true">启用Redis缓存</xform:simpleDataSource>
				</xform:checkbox>
			</b>
		</td>
	</tr>
	<tbody id="tbody_cache_redis" style="display:none;">
	<tr>
		<td class="td_normal_title" width="15%">Redis服务器地址</td>
		<td width="85%">
			<xform:text property="value(cache.redis.host)" subject="Redis服务器地址" required="true" style="width:90%" showStatus="edit" /><br>
			<span class="message">必填，格式："IP1:PORT1"，如："127.0.0.1:6379"（注：database默认为0）
				<br>集群配置："IP1:PORT1;IP2:PORT2;IP3:PORT3;..."，如："127.0.0.1:7000;127.0.0.1:7001;127.0.0.1:7002;127.0.0.1:7003;127.0.0.1:7004;127.0.0.1:7005"）</span>
				<br>
			<span style="color:red;">注意：必须先启动Redis，再启动EKP。Redis的宕机会引发EKP的宕机。</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">Redis服务器密码</td>
		<td width="85%">
			<xform:text property="value(cache.redis.password)" subject="Redis服务器密码" style="width:150px;" showStatus="edit" htmlElementProperties="type='password'"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">二级缓存</td>
		<td width="85%">
			<xform:checkbox property="value(cache.redis.hibernate.enabled)" showStatus="edit">
				<xform:simpleDataSource value="true">使用Redis作为Hibernate的二级缓存</xform:simpleDataSource>
			</xform:checkbox>
		</td>
	</tr>
	</tbody>
</table>
<script>
function config_redis_chgEnabled(){
	var tb = document.getElementById("tbody_cache_redis");
	var checked = document.getElementsByName("_value(cache.redis.enabled)")[0].checked;
	tb.style.display = checked?"":"none";
	var fields = tb.getElementsByTagName("INPUT");
	for(var i=0; i<fields.length; i++){
		fields[i].disabled = !checked;
	}
}
config_redis_chgEnabled();
</script>
