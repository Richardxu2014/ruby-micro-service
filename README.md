# RMS 框架 

## 基于 RubbitMQ 的 ruby 微服务 

用到以下第三方组件：
* sneakers：  用于连接 RubbitMQ [使用手册](https://github.com/jondot/sneakers/wiki)

* sequel：  数据库ORM框架 [使用手册](http://sequel.jeremyevans.net/rdoc/files/README_rdoc.html) 

* mysql2

* redis 

## 目录结构

```
.
├── bin                 
│   └── test             # 启动脚本
├── config
│   ├── application.yml  # 各种配置数据
│   └── setup.rb         # 初始化程序
├── Gemfile
├── Gemfile.lock
├── logs           # 日志文件夹 
├── models         # 模型文件夹（数据库表对应模型）
│   └── user.rb   
├── README.md
└── workers        # 消息处理逻辑
    └── test.rb

```


## 启动命令 
```
# 开发模式(默认env=development)
$ ./bin/test

# 生产模式
$ ./bin/test env=prodution

#测试模式
$ ./bin/test env=test
```