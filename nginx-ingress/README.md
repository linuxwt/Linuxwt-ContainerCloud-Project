## 说明
当初为了通过nginx-ingress来统一暴漏各个组件及应用的服务，jenkins、nexus3、nacos、front都设置访问url带有二级路径
，但是harbor、elk、sonarqube均是采用的nginx反向代理加nodeport方式来访问
