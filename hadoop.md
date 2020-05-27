#### hadoop

- 安装openjdk8：`sudo apt-get install openjdk-8-jdk`

    注：java8都可

- 安装配置openssh：

    ~~~bash
    sudo apt-get install openssh-server
    sudo /etc/init.d/ssh start
    ssh-keygen -t rsa # 设置免密登录
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys # 写入authorized_keys
    ufw disable # 关闭防火墙
    ~~~

- 安装hadoop：

    ~~~bash
    # 清华镜像 https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.2.1/
    sudo tar zxvf hadoop-3.2.1.tar.gz -C /usr/local
    cd /usr/local
    sudo mv hadoop-3.2.1 hadoop # 重命名
    sudo chmod 777 -R /usr/local/hadoop # 给权限
    ~~~

- openjdk环境变量：

    ~~~bash
    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
    export JRE_HOME=${JAVA_HOME}/jre 
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib 
    export PATH=${JAVA_HOME}/bin:$PATH
    ~~~

- hadoop环境变量：

    ~~~bash
    export HADOOP_HOME=/usr/local/hadoop
    export PATH=$PATH:$HADOOP_HOME/sbin
    export PATH=$PATH:$HADOOP_HOME/bin
    ~~~

- 后续还有一些xml文件的配置，部分内容参考博客：https://blog.csdn.net/kh896424665/article/details/78765175

- 注：hadoop2.×和3.×略有不同

