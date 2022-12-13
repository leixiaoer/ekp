把EKPlib下的GBase8s-Ifxjdbc.jar替换成Gbasedbt-jdbc-8Sv8.8.jar

kmssconfig.properties中的数据库配置改为
hibernate.connection.driverClass=com.gbasedbt.jdbc.Driver
hibernate.dialect=com.landray.kmss.sys.hibernate.dialect.KmssGBase8SDialect
hibernate.connection.url=jdbc:gbasedbt-sqli://db.landray.com.cn:9088/ekp:GBASEDBTSERVER=gbaseserver;DB_LOCALE=zh_CN.utf8;CLIENT_LOCALE=zh_CN.utf8;IFX_USE_STRENC=true
hibernate.connection.userName=gbasedbt
hibernate.connection.password=Gbase@123