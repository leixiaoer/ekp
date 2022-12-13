<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script>
JDBC_MAP_URL = new Array();
JDBC_MAP_DIALECT = new Array();
//SQL Server配置
JDBC_MAP_URL["net.sourceforge.jtds.jdbc.Driver"] = "jdbc:jtds:sqlserver://db.landray.com.cn:1433/ekp";
JDBC_MAP_DIALECT["net.sourceforge.jtds.jdbc.Driver"] = "org.hibernate.dialect.SQLServerDialect";
//Oracle配置
JDBC_MAP_URL["oracle.jdbc.driver.OracleDriver"] = "jdbc:oracle:thin:@db.landray.com.cn:1521:ekp";
JDBC_MAP_DIALECT["oracle.jdbc.driver.OracleDriver"] = "org.hibernate.dialect.Oracle9Dialect";
//DB2配置
JDBC_MAP_URL["com.ibm.db2.jcc.DB2Driver"] = "jdbc:db2://db.landray.com.cn:50000/ekp:driverType=4;fullyMaterializeLobData=true;fullyMaterializeInputStreams=true;progressiveStreaming=2;progresssiveLocators=2;";
JDBC_MAP_DIALECT["com.ibm.db2.jcc.DB2Driver"] = "org.hibernate.dialect.DB2Dialect";
//My Sql配置
JDBC_MAP_URL["com.mysql.jdbc.Driver"] = "jdbc:mysql://db.landray.com.cn:3306/ekp?useUnicode=true&characterEncoding=UTF-8";
JDBC_MAP_DIALECT["com.mysql.jdbc.Driver"] = "org.hibernate.dialect.MySQL5Dialect";
//My Sql 8.0配置
JDBC_MAP_URL["com.mysql.cj.jdbc.Driver"] = "jdbc:mysql://db.landray.com.cn:3306/ekp?userSSL=true&autoReconnect=true&useUnicode=true&characterEncoding=UTF8&serverTimezone=Asia/Shanghai";
JDBC_MAP_DIALECT["com.mysql.cj.jdbc.Driver"] = "org.hibernate.dialect.MySQL5Dialect";
//神通数据库配置
JDBC_MAP_URL["com.oscar.Driver"] = "jdbc:oscar://db.landray.com.cn:2003/ekp?useUnicode=true&characterEncoding=UTF-8";
JDBC_MAP_DIALECT["com.oscar.Driver"] = "org.hibernate.dialect.OscarDialect";
//人大金仓数据库v7配置
JDBC_MAP_URL["com.kingbase.Driver"] = "jdbc:kingbase://db.landray.com.cn:54321/ekp";
JDBC_MAP_DIALECT["com.kingbase.Driver"] = "com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssKingbaseDialect";
//人大金仓数据库v8配置
JDBC_MAP_URL["com.kingbase8.Driver"] = "jdbc:kingbase8://db.landray.com.cn:54321/ekp?autosave=always";
JDBC_MAP_DIALECT["com.kingbase8.Driver"] = "com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssKingbase8Dialect";
//达梦数据库配置
JDBC_MAP_URL["dm.jdbc.driver.DmDriver"] = "jdbc:dm://db.landray.com.cn:5236/ekp";
JDBC_MAP_DIALECT["dm.jdbc.driver.DmDriver"] = "com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssDmDialect";
//南大通用数据库配置8T
JDBC_MAP_URL["com.informix.jdbc.IfxDriver"] = "jdbc:informix-sqli://db.landray.com.cn:21499/ekp:informixserver=ol_informix1210";
JDBC_MAP_DIALECT["com.informix.jdbc.IfxDriver"] = "com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssGBase8TDialect";
//南大通用数据库配置8S(informix内核)
JDBC_MAP_URL["com.gbasedbt.jdbc.IfxDriver"] = "jdbc:gbasedbt-sqli://db.landray.com.cn:9088/ekp:INFORMIXSERVER=ol_gbasedbt1210_1;DB_LOCALE=zh_CN.utf8;CLIENT_LOCALE=zh_CN.utf8";
JDBC_MAP_DIALECT["com.gbasedbt.jdbc.IfxDriver"] = "com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssGBase8SDialect";
//华为高斯 GaussDB 100
JDBC_MAP_URL["com.huawei.gauss.jdbc.ZenithDriver"] = "jdbc:zenith:@194.0.45.80:1888";
JDBC_MAP_DIALECT["com.huawei.gauss.jdbc.ZenithDriver"] = "org.hibernate.dialect.OracleDialect";

//阿里PolarDB for Oracle版本
JDBC_MAP_URL["com.aliyun.polardb.Driver"] = "jdbc:polardb://landray.polardb.rds.aliyuncs.com:1521/ekp";
JDBC_MAP_DIALECT["com.aliyun.polardb.Driver"] = "com.landray.kmss.sys.hibernate.dialect.PolarDB4OracleDialect";

//华为Opengauss1.0.1
JDBC_MAP_URL["org.postgresql.Driver"] = "jdbc:postgresql://192.168.1.133:26000/ekpdb";
JDBC_MAP_DIALECT["org.postgresql.Driver"] = "com.landray.kmss.sys.hibernate.dialect.Opengauss101Dialect";

function config_db_selectJdbcType(value){
	var url = document.getElementsByName("value(hibernate.connection.url)")[0];
	if(JDBC_MAP_URL[value]) {
		url.value = JDBC_MAP_URL[value];
	}
	var dialect = document.getElementsByName("value(hibernate.dialect)")[0];
	if(JDBC_MAP_DIALECT[value]) {
		dialect.value = JDBC_MAP_DIALECT[value];
	}
	config_db_JdbcChange(dialect.value);
}
function config_db_JdbcChange(dialect) {
	var oracle = document.getElementById("oracle");
	var sqlserver = document.getElementById("sqlserver");
	var db2 = document.getElementById("db2");
	var mysql = document.getElementById("mysql");
	var mysql8 = document.getElementById("mysql8");
	var shentong = document.getElementById("shentong");
	var kingbase = document.getElementById("kingbase");
	var gbase = document.getElementById("gbase8t");
	var gbase8s = document.getElementById("gbase8s");
	var gaussDBT = document.getElementById("gaussDBT");
	var polardb4oracle = document.getElementById("polardb4oracle");
	var openGauss = document.getElementById("openGauss");
	
	var driverClass = document.getElementsByName("value(hibernate.connection.driverClass)")[0];
	
	if(dialect == 'org.hibernate.dialect.Oracle9Dialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'block';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'org.hibernate.dialect.SQLServerDialect'){
		sqlserver.style.display = 'block';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'org.hibernate.dialect.MySQL5Dialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'block';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'org.hibernate.dialect.DB2Dialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'block';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'org.hibernate.dialect.OscarDialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'block';
		kingbase.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssKingbaseDialect'||dialect == 'com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssKingbase8Dialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'block';
		dm.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssDmDialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		dm.style.display = 'block';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssGBase8TDialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		dm.style.display = 'none';
		gbase8s.style.display = 'none';
		gbase.style.display = 'block';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'com.landray.kmss.framework.hibernate.hqlfunction.dialect.KmssGBase8SDialect'){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		dm.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'block';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'org.hibernate.dialect.OracleDialect' && 'com.huawei.gauss.jdbc.ZenithDriver' == driverClass){
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		dm.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		gaussDBT.style.display = 'block';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}else if(dialect == 'com.landray.kmss.sys.hibernate.dialect.PolarDB4OracleDialect' && 'com.aliyun.polardb.Driver' == driverClass){
        sqlserver.style.display = 'none';
        oracle.style.display = 'none';
        db2.style.display = 'none';
        mysql.style.display = 'none';
        shentong.style.display = 'none';
        kingbase.style.display = 'none';
        dm.style.display = 'none';
        gbase.style.display = 'none';
        gbase8s.style.display = 'none';
        gaussDBT.style.display = 'none';
        polardb4oracle.style.display = 'block';
        openGauss.style.display = 'none';
    } else if(dialect == 'com.landray.kmss.sys.hibernate.dialect.Opengauss101Dialect' && 'org.postgresql.Driver' == driverClass){
        sqlserver.style.display = 'none';
        oracle.style.display = 'none';
        db2.style.display = 'none';
        mysql.style.display = 'none';
        shentong.style.display = 'none';
        kingbase.style.display = 'none';
        dm.style.display = 'none';
        gbase.style.display = 'none';
        gbase8s.style.display = 'none';
        gaussDBT.style.display = 'none';
        openGauss.style.display = 'block';
    } else {
		sqlserver.style.display = 'none';
		oracle.style.display = 'none';
		db2.style.display = 'none';
		mysql.style.display = 'none';
		shentong.style.display = 'none';
		kingbase.style.display = 'none';
		gbase.style.display = 'none';
		gbase8s.style.display = 'none';
		dm.style.display = 'none';
		gaussDBT.style.display = 'none';
		polardb4oracle.style.display = 'none';
		openGauss.style.display = 'none';
	}
}
function config_db_selectConnType(value) {
	var tr_url = document.getElementById("tr_url");
	var tr_userName = document.getElementById("tr_userName");
	var tr_password = document.getElementById("tr_password");
	var tr_jdbcstat = document.getElementById("tr_jdbcstat");
	var tr_datasource = document.getElementById("tr_datasource");

	var url = document.getElementsByName("value(hibernate.connection.url)")[0];
	var userName = document.getElementsByName("value(hibernate.connection.userName)")[0];
	var password = document.getElementsByName("value(hibernate.connection.password)")[0];
	var datasource = document.getElementsByName("value(hibernate.connection.datasource)")[0];
	if("jndi" == value) {
		//tr_url.style.display = 'none';
		//tr_userName.style.display = 'none';
		tr_jdbcstat.style.display = 'none';
		tr_password.style.display = 'none';
		
		tr_datasource.style.display = '';

		//url.disabled = true;
		//userName.disabled = true;
		password.disabled = true;
		datasource.disabled = false;
	} else {
		tr_url.style.display = '';
		tr_userName.style.display = '';
		tr_password.style.display = '';
		tr_jdbcstat.style.display = '';
		tr_datasource.style.display = 'none';

		url.disabled = false;
		userName.disabled = false;
		password.disabled = false;
		datasource.disabled = true;
	}
}
function config_db_onloadFunc(){
	var dialect = document.getElementsByName("value(hibernate.dialect)")[0].value;
	config_db_JdbcChange(dialect);
	var _type = document.getElementsByName("value(kmss.connection.type)"), type = null;
	for(var i = 0; i < _type.length; i++) {
		if(_type[i].checked) {
			type = _type[i].value;
			break;
		}
	}
	if(type == null) {
		_type[0].checked = true;
		type = "jdbc";
	}
	config_db_selectConnType(type);
}
config_addOnloadFuncList(config_db_onloadFunc);
function dbProcessRequest(request){
	if(warnOracle()){
		alert("当前配置Oracle的连接帐号(sys、system)为系统帐号,请勿使用！");
		return;
	}
	var flag = Com_GetUrlParameter(request.responseText, "flag");
	if(flag){
		alert("数据库连接成功！");
	}else{
		alert("数据库连接失败，请重新配置");
    }
}
function testDbConn(){
	var data = new KMSSData();
	var _type = document.getElementsByName("value(kmss.connection.type)");
	var type = "jdbc";
	for(var i = 0; i < _type.length; i++) {
		if(_type[i].checked) {
			type = _type[i].value;
			break;
		}
	}
	if("jndi"==type) {
		data.AddFromField("datasource", 
			"value(hibernate.connection.datasource)");
	} else {
		data.AddFromField("driver:connurl:username:password", 
			"value(hibernate.connection.driverClass):"+
			"value(hibernate.connection.url):"+
			"value(hibernate.connection.userName):"+
			"value(hibernate.connection.password)");
	}
	data.SendToUrl("admin.do?method=testDbConn", dbProcessRequest);
}
function warnOracle() {
	var dialect = document.getElementsByName("value(hibernate.dialect)")[0];
	var value = document.getElementsByName("value(hibernate.connection.userName)")[0].value;
	var value = value.toLowerCase();
	if('org.hibernate.dialect.Oracle9Dialect' == dialect.value){
		if("sys" == value || "system" == value){
			document.getElementById("oracle_warn").style.display="" ;
			return true;
		}else{
			document.getElementById("oracle_warn").style.display="none" ;
			return false;
		}
	}else{
		document.getElementById("oracle_warn").style.display="none" ;
		return false;
	}
	
}
</script>

<table class="tb_normal" width=100%>
	<tr>
		<td class="td_normal_title" colspan=2><b>数据库配置</b></td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">连接类型</td>
		<td>
			<xform:radio property="value(kmss.connection.type)" showStatus="edit" onValueChange="config_db_selectConnType(this.value);" subject="连接类型" required="true">
				<xform:simpleDataSource value="jdbc">JDBC</xform:simpleDataSource>
				<xform:simpleDataSource value="jndi">JNDI</xform:simpleDataSource>
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">数据库类型</td>
		<td>
			<xform:select property="value(hibernate.connection.driverClass)" showStatus="edit" onValueChange="config_db_selectJdbcType(this.value);warnOracle();" subject="数据库类型" required="true" showPleaseSelect="true">
				<xform:simpleDataSource value="oracle.jdbc.driver.OracleDriver">Oracle</xform:simpleDataSource>
				<xform:simpleDataSource value="net.sourceforge.jtds.jdbc.Driver">SQL Server</xform:simpleDataSource>
				<xform:simpleDataSource value="com.mysql.jdbc.Driver">My SQL</xform:simpleDataSource>
				<xform:simpleDataSource value="com.mysql.cj.jdbc.Driver">My SQL 8.0</xform:simpleDataSource>
				<xform:simpleDataSource value="com.ibm.db2.jcc.DB2Driver">DB2</xform:simpleDataSource>
				<xform:simpleDataSource value="com.oscar.Driver">ShenTong</xform:simpleDataSource>
				<xform:simpleDataSource value="com.kingbase.Driver">Kingbase7</xform:simpleDataSource>
				<xform:simpleDataSource value="com.kingbase8.Driver">Kingbase8</xform:simpleDataSource>
				<xform:simpleDataSource value="dm.jdbc.driver.DmDriver">DaMeng</xform:simpleDataSource>
				<xform:simpleDataSource value="com.informix.jdbc.IfxDriver">GBase8T</xform:simpleDataSource>
				<xform:simpleDataSource value="com.gbasedbt.jdbc.IfxDriver">GBase8S</xform:simpleDataSource>
				<xform:simpleDataSource value="com.huawei.gauss.jdbc.ZenithDriver">GaussDB T</xform:simpleDataSource>
				<xform:simpleDataSource value="com.aliyun.polardb.Driver">PolarDB for Oracle</xform:simpleDataSource>
				<xform:simpleDataSource value="org.postgresql.Driver">OpenGauss</xform:simpleDataSource>
			</xform:select>
			<html:hidden property="value(hibernate.dialect)"/>
		</td>
	</tr>
	<tr id="tr_url">
		<td class="td_normal_title" width="15%">数据库连接URL</td>
		<td>
			<xform:text property="value(hibernate.connection.url)" subject="数据库连接URL" required="true" style="width:85%" showStatus="edit"/><br>
			<div id='oracle' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：1521，实例名：ekp <div style="color: red;">(如果Oracle是11g或更低版本请使用ojdbc5.jar，需要在代码目录\WEB-INF\patch\oracle\ojdbc\下运行toOjdbc5.cmd再部署启动)</div>
				</span>
			</div>
			<div id='sqlserver' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：1433，数据库名：ekp
				</span>
			</div>
			<div id='mysql' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：3306，数据库名：ekp
				</span>
			</div>
			<div id='db2' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：50000，数据库名：ekp
				</span>
			</div>
			<div id='shentong' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：2003，数据库名：ekp
				</span>
			</div>
			<div id='kingbase' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：54321，数据库名：ekp
				</span>
			</div>
			<div id='dm' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：5236，数据库名：ekp
				</span>
			</div>
			<div id='gbase8t' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：21499，数据库名：ekp，服务器名：INFORMIXSERVER
				</span>
			</div>			
			<div id='gbase8s' style="display:none">
				<span class="message">
					服务器地址：db.landray.com.cn，默认连接端口：9088，数据库名：ekp，服务器名：INFORMIXSERVER
				</span>
			</div>
			<div id='gaussDBT' style="display:none">
				<span class="message">
					服务器地址：192.168.0.0，服务器端口：1888，
				</span>
			</div>
			<div id='polardb4oracle' style="display:none">
                <span class="message">
                        服务器地址：landray.polardb.rds.aliyuncs.com，服务器端口：1521，数据库名：ekp
                </span>
            </div>		
            <div id='openGauss' style="display:none">
                <span class="message">
                                    服务器地址：192.168.1.133，服务器端口：26000，数据库名：ekpdb
                </span>
            </div>				
		</td>
	</tr>
	<tr id="tr_userName">
		<td class="td_normal_title" width="15%">用户名</td>
		<td>
			<xform:text property="value(hibernate.connection.userName)" subject="用户名" required="true" style="width:150px" showStatus="edit" onValueChange="warnOracle();"/>
			<div id="oracle_warn" style="color: red;display: none">当前配置Oracle的连接帐号为系统帐号,请勿使用！</div>
		</td>
	</tr>
	<tr id="tr_password">
		<td class="td_normal_title" width="15%">密码</td>
		<td>
			<c:set var="_pass" value="${sysConfigAdminForm.map['hibernate.connection.password'] }"/>
			<%
				String pass = (String)pageContext.getAttribute("_pass");
				if(StringUtil.isNotNull(pass)){
					pass = new String(Base64.encodeBase64(pass.getBytes("UTF-8")),"UTF-8");
					pageContext.setAttribute("_pass", "\u4649\u5820\u4d45\u4241\u5345\u3634{" + pass +"}");	
				}
			%>
			<xform:text property="value(hibernate.connection.password)" subject="密码" 
				required="true" style="width:150px" showStatus="edit" htmlElementProperties="type='password'" value="${_pass}"/>
		</td>
	</tr>
	<tr id="tr_jdbcstat">
		<td class="td_normal_title" width="15%">启用JDBC监控</td>
		<td>
			<xform:radio property="value(kmss.jdbc.stat.enabled)" showStatus="edit" >
				<xform:simpleDataSource value="true">是</xform:simpleDataSource>
				<xform:simpleDataSource value="false">否</xform:simpleDataSource>
			</xform:radio><br>
			<span class="message">
				启用JDBC监控后，您可以在“管理员工具箱-请求监控-查看JDBC监控”，查阅监控结果
			</span>
		</td>
	</tr>
	<tr id="tr_datasource">
		<td class="td_normal_title" width="15%">数据源名称</td>
		<td>
			<xform:text property="value(hibernate.connection.datasource)" subject="数据源名称" required="true" style="width:150px" showStatus="edit" /><br />
			样例，数据源名称：jdbc/ekpds
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">测试数据库连接</td>
		<td>	
			<input type="button" class="btnopt" value="测试" onclick="testDbConn()"/>
		</td>
	</tr>
</table>