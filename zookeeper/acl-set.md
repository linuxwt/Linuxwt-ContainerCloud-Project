式一：（推荐）
1）增加一个认证用户
addauth digest 用户名:密码明文
eg. addauth digest user1:password1
2）设置权限
setAcl /path auth:用户名:密码明文:权限
eg. setAcl /test auth:user1:password1:cdrwa
3）查看Acl设置
getAcl /path

方式二：
setAcl /path digest:用户名:密码密文:权限

注：这里的加密规则是SHA1加密，然后base64编码。
