修改Informix数据库字符集，分为以下几步：

1.修改DB_LOCALE和CLIENT_LOCALE的值

在Informix用户下执行

export DB_LOCALE=en_US.utf8

export CLIENT_LOCALE=en_US.utf8

2.重启实例

仍然在Informix用户下执行

oninit -vy

然后，重新创建数据库