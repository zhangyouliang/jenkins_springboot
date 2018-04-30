jenkins + maven + nexus3 + docker 持续集成持续发布案例
====

我们的需求是,将 Java 项目打包为 docker 镜像,便于后记的部署

准备
--
- Ubuntu 16.04 服务器一台 [docker 自行安装..](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- jenkins 镜像

1.获取 jenkins 镜像
----
```bash
# 方式一
git clone https://github.com/zhangyouliang/dockerfile
cd jenkins 
docker build -t jenkins:2.107.2 .
//... 推送到个人仓库
# 方式二 (个人构建:2018年04月30日)
docker pull registry.cn-hangzhou.aliyuncs.com/zhangyouliang/jenkins:2.107.2

# 方式三 (官方 jenkins docker 地址)
https://hub.docker.com/r/jenkins/jenkins/


# 运行
docker run -d -v /root/nas/jenkins/data:/var/jenkins:rw -v /var/run/docker.sock:/var/run/docker.sock registry.cn-hangzhou.aliyuncs.com/zhangyouliang/jenkins:2.107.2
```

**Gitlab插件**

> 每次修改配置,需要点击 Manage Jenkins > Reload Configuration from Disk

我这里要使用Gitlab来做演示，所以先安装相应的插件

- GitLab Plugin
- Gitlab Hook Plugin
- AnsiColor（可选）这个插件可以让Jenkins的控制台输出的log带有颜色（就和linux控制台那样）
- Blue Ocean pipeline 可视化工具


**Jenkins系统设置**
操作： `Manage Jenkins -> Configure System`

Jenkins内部shell UTF-8 编码设置，如下图所示，LANG=zh_CN.UTF-8

![image](https://raw.githubusercontent.com/zhangyouliang/jenkins_springboot/master/doc/images/step02.png)

**配置SSH**

本机生成SSH：`ssh-keygen -t rsa -C "Your email"`，最终生成i`d_rsa`和`id_rsa.pub(公钥)`

Gitlab上添加公钥：复制`id_rsa.pub`里面的公钥添加到Gitlab

Jenkins上配置密钥到SSH：复制 `id_rsa `里面的公钥添加到Jenkins（private key选项）

操作： `Manage Jenkins -> Credentials -> System -> Global credentials (unrestricted) -> Add Credentials`

然后选择`kind`类型为 `SSH username with private key，username`随便填， `Private Key`选择`Enter directly`，然后把你的私钥直接copy到这里来，保存即可。 如果你生成sshkey的时候输入了密码，那么这里的`Passphrase`也要输入，否则留空。

![image](https://raw.githubusercontent.com/zhangyouliang/jenkins_springboot/master/doc/images/step03.png)

**创建管道**

![image](https://raw.githubusercontent.com/zhangyouliang/jenkins_springboot/master/doc/images/step01.png)

选择从SCM中的Jenkinsfile来定义管道

![image](https://raw.githubusercontent.com/zhangyouliang/jenkins_springboot/master/doc/images/step04.png)

最后点击构建即可

**效果**

点击 Open Blue Ocean

![image](https://raw.githubusercontent.com/zhangyouliang/jenkins_springboot/master/doc/images/step05.png)



2.搭建nexu3 (可选)
----
```bash
docker run -d --restart always -v /data/nexus-data:/nexus-data:rw sonatype/nexus3:latest
```

设置主机 maven 配置 [settings.xml](https://github.com/zhangyouliang/jenkins_springboot/master/doc/settings.md)


