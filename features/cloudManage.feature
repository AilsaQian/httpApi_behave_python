#language: zh-CN
功能: 跨云管理接口


    # 场景大纲: 业务组导入
    #     # # 避免已添加，所以根据user_id和key从数据库中先删除此业务组
    #     假如 删除业务组<params>
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    #     假如 删除业务组<params>
    # 例子:
    #     | subUrl | method | params | code | msg |
    #     # 非空判断
    #     | /user/api-key/add | post | {'provider': '', 'key': '', 'secret': ''}                       | 0 | Key不能为空。    |
    #     | /user/api-key/add | post | {'provider': 'aliyun', 'key': '', 'secret': ''}                 | 0 | Key不能为空。    |
    #     | /user/api-key/add | post | {'provider': 'aliyun', 'key': 'LTAIOqOrLFSYdhYf', 'secret': ''} | 0 | Secret不能为空。 |
    #     # 错误的provider
    #     | /user/api-key/add | post | {'provider': 'aliyun1', 'key': 'LTAIOqOrLFSYdhYf1', 'secret': 'JKPKrovC2QOkJPuNdzwkl4YUA13eoU'} | 0 | 云提供商是无效的。 |
    #     # 不存在的key
    #     | /user/api-key/add | post | {'provider': 'aliyun', 'key': 'testtset', 'secret': 'testetat'} | 0 | Key找不到主机。 |
    #     # 错误的secret
    #     | /user/api-key/add | post | {'provider': 'aliyun', 'key': 'LTAIOqOrLFSYdhYf2', 'secret': 'testwetst'} | 0 | secret错误。 |
    #     # 添加腾讯机器
    #     | /user/api-key/add | post | {'provider': 'tx', 'key': 'AKID394oNmyGJAuXyFqPDqIiDbt0kPyMIN0S', 'secret': 'PcjfPxKWNDsNg5hEduz1rVxEc7vlU7Zq'} | 1 | None |
    #     # 添加阿里云
    #     | /user/api-key/add | post | {'provider': 'aliyun', 'key': 'LTAIOqOrLFSYdhYf', 'secret': 'KPKrovC2QOkJPuNdzwkl4YUA13eoU'} | 1 | None |


    # 场景大纲: 业务组导入 - 检查重复
    #     假如 删除业务组<params>
    #     当 传入参数<subUrl>和<method>和<params>
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl            | method | params                                                                          | code | msg       |
    #     | /user/api-key/add | post   | {'provider': 'aliyun', 'key': 'LTAIOqOrLFSYdhYf', 'secret': 'LTAIOqOrLFSYdhYf'} | 0    | 该Key已经添加过 |


    # 场景大纲: 云主机导入查询 - 错误验证
    #     当 需要动态修改key_id并传入其他参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl | method | params | code | msg |
    #     # 错误的key_id
    #     | /cvm/list/import | post | {'key_id': '123456' } | 0 | 无权对此API KEY操作 |
    #     # 空值判断
    #     | /cvm/list/import | post | {'key_id': '' } | 0 | 业务组ID不能为空。 |
    #     # 非整数key_id
    #     | /cvm/list/import | post | {'key_id': 'testKeyID' } | 0 | 业务组ID必须是整数。 |


    # 场景大纲: 云主机导入查询进度 - 错误验证
    #     当 需要动态修改task_id及ifContinue并传入其他参数<subUrl>和<method>和<params>和<ifContinue>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl | method | params | ifContinue | code | msg |
    #     # 空值
    #     | /cvm/list/import-progress | get | {'task_id': ''} | N | 0 | 导入任务ID不能为空。 |
    #     # 错误值
    #     | /cvm/list/import-progress | get | {'task_id': 2333333333335} | N | 1 | None |
    #     # 非数值
    #     | /cvm/list/import-progress | get | {'task_id': 'TaskID'} | N | 0 | 导入任务ID必须是整数。 |


    # 场景大纲: 云主机导入查询结果预览 - 错误验证
    #     当 需要动态修改task_id并传入其他参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl | method | params | code | msg |
    #     # 空值
    #     | /cvm/list/import-preview | get | {'task_id': ''} | 0 | 导入任务ID不能为空。 |
    #     # 错误值
    #     | /cvm/list/import-preview | get | {'task_id': 2333333333335} | 0 | 没有查询到主机 |
    #     # 非数值
    #     | /cvm/list/import-preview | get | {'task_id': 'TaskID'} | 0 | 导入任务ID必须是整数。 |


    # 场景大纲: 云主机确认导入 - 错误验证
    #     当 需要动态修改task_id并传入其他参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl | method | params | code | msg |
    #     # 空值
    #     | /cvm/list/import-confirm | post | {'task_id': ''} | 0 | 导入任务ID不能为空。 |
    #     # 错误值
    #     | /cvm/list/import-confirm | post | {'task_id': 2333333333335} | 0 | 没有要导入的主机 |
    #     # 非数值
    #     | /cvm/list/import-confirm | post | {'task_id': 'TaskID'} | 0 | 导入任务ID必须是整数。 |


    # 场景大纲: 业务组导入 - 云主机导入查询 - 查询进度 - 查询结果预览 - 确认导入
    #     假如 删除业务组<params1>
    #     当 传入参数<subUrl1>和<method1>和<params1>
    #     那么 获得key_id和key_name
    #     当 需要动态修改key_id并传入其他参数<subUrl2>和<method2>和<params2>
    #     那么 获得task_id
    #     当 需要动态修改task_id及ifContinue并传入其他参数<subUrl3>和<method3>和<params3>和<ifContinue>
    #     当 需要动态修改task_id并传入其他参数<subUrl4>和<method4>和<params4>
    #     当 需要动态修改task_id并传入其他参数<subUrl5>和<method5>和<params5>
    #     那么 获得返回值<code5>和提示<msg5>
    # 例子:
    #     | subUrl1  | method1 | params1| subUrl2| method2 | params2| subUrl3   | method3 | params3  | ifContinue | subUrl4  | method4 | params4 | subUrl5 | method5 | params5  | code5 | msg5 |
    #     | /user/api-key/add | post|{'provider': 'tx', 'key': 'AKID1wgDmClSIyX1LVEHvSq10UtAHCYxo1Pk', 'secret': 'P1TpzyqX6Wmrlw1vd8RddSAoMirowwpa'}| /cvm/list/import | post| {'key_id': 'rightKeyID'} | /cvm/list/import-progress|get| {'task_id': 'rightTaskID'} |Y|/cvm/list/import-preview|get|{'task_id': 'rightTaskID'}|/cvm/list/import-confirm|post|{'task_id': 'rightTaskID'} | 1| None |


    # 场景大纲: 业务组设置 - 错误验证1
    #     当 需要动态修改id并传入其他参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl | method | params | code | msg |
    #     # 非空
    #     | /user/api-key/update | post | {'id':'', 'is_auto_update':'', 'title':''}  | 0 | 业务组ID不能为空。 |
    #     | /user/api-key/update | post | {'id':122, 'is_auto_update':'', 'title':''} | 0 | 名称不能为空。    |
    #     | /user/api-key/update | post | {'id':122, 'is_auto_update': 0, 'title':''} | 0 | 名称不能为空。    |
    #     # 错误值
    #     | /user/api-key/update | post | {'id':'testID', 'is_auto_update': 0, 'title':'aliyun'} | 0 | 业务组ID必须是整数。 |
    #     # 非该用户业务组id
    #     | /user/api-key/update | post | {'id':122455, 'is_auto_update': 'yes', 'title':'aliyun'} | 0 | 无权对此API KEY操作 |


    # 场景大纲: 业务组设置 - 正确验证 + 错误验证2
    #     假如 删除业务组<params1>
    #     当 传入参数<subUrl1>和<method1>和<params1>
    #     那么 获得key_id和key_name
    #     当 需要动态修改id并传入其他参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl1           | method1 | params1                                                                                                         | subUrl               | method | params                                                    | code | msg  |
    #     | /user/api-key/add | post    | {'provider': 'tx', 'key': 'AKID394oNmyGJAuXyFqPDqIiDbt0kPyMIN0S', 'secret': 'PcjfPxKWNDsNg5hEduz1rVxEc7vlU7Zq'} | /user/api-key/update | post   | {'id':'rightID', 'is_auto_update': 0, 'title':'腾讯云test1'} | 1    | None |
    #     # is_auto_update错误值
    #     | /user/api-key/add | post | {'provider': 'tx', 'key': 'AKID394oNmyGJAuXyFqPDqIiDbt0kPyMIN0S', 'secret': 'PcjfPxKWNDsNg5hEduz1rVxEc7vlU7Zq'} | /user/api-key/update | post | {'id':'rightID', 'is_auto_update': 5, 'title':'aliyun'}     | 0 | 是否自动更新是无效的。 |
    #     | /user/api-key/add | post | {'provider': 'tx', 'key': 'AKID394oNmyGJAuXyFqPDqIiDbt0kPyMIN0S', 'secret': 'PcjfPxKWNDsNg5hEduz1rVxEc7vlU7Zq'} | /user/api-key/update | post | {'id':'rightID', 'is_auto_update': 'yes', 'title':'aliyun'} | 0 | 是否自动更新是无效的。 |


    场景大纲: 业务组列表
        当 传入参数<subUrl>和<method>和<params>
        那么 获得返回值<code>和提示<msg>
    例子:
        | subUrl             | method | params                        | code | msg      |
        | /user/api-key/list | get    | {'page':'', 'title':''}       | 1    | None     |
    #     | /user/api-key/list | get    | {'page':'', 'title':'test'}   | 1    | None     |
    #     | /user/api-key/list | get    | {'page':1, 'title':'test'}    | 1    | None     |
    #     | /user/api-key/list | get    | {'page':10, 'title':'test'}   | 1    | None     |
    #     | /user/api-key/list | get    | {'page':'tt', 'title':'test'} | 0    | 页数必须是整数。 |


    # 场景大纲: 业务组删除 - 错误验证
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl               | method | params        | code | msg           |
    #     | /user/api-key/delete | post   | {'id':''}     | 0    | 业务组ID不能为空。    |
    #     | /user/api-key/delete | post   | {'id':'test'} | 0    | 业务组ID必须是整数。   |
    #     | /user/api-key/delete | post   | {'id':3415}   | 0    | 无权对此API KEY操作 |


    # 场景大纲: 业务组删除 - 正确验证
    #     假如 删除业务组<params1>
    #     当 传入参数<subUrl1>和<method1>和<params1>
    #     那么 获得key_id和key_name
    #     当 需要动态修改id并传入其他参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl1           | method1 | params1                                                                                                         | subUrl               | method | params           | code | msg  |
    #     | /user/api-key/add | post    | {'provider': 'tx', 'key': 'AKID394oNmyGJAuXyFqPDqIiDbt0kPyMIN0S', 'secret': 'PcjfPxKWNDsNg5hEduz1rVxEc7vlU7Zq'} | /user/api-key/delete | post   | {'id':'rightID'} | 1    | None |


# ************************云主机操作 ************************


    # 场景大纲: 云主机列表
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                     | method | params                                                   | code | msg  |
    #     | /cloudwebapi/host/hostlist | get    | {'instance_name':'','cloud_id':'','page':'','limit':''}  | 1    | None |
    #     | /cloudwebapi/host/hostlist | get    | {'instance_name':'','cloud_id':'','page':1,'limit':''}   | 1    | None |
    #     | /cloudwebapi/host/hostlist | get    | {'instance_name':'','cloud_id':'','page':100,'limit':''} | 1    | None |
    #     | /cloudwebapi/host/hostlist | get    | {'instance_name':'','cloud_id':'','page':1,'limit':1}    | 1    | None |
    #     | /cloudwebapi/host/hostlist | get    | {'instance_name':'','cloud_id':'','page':'','limit':1}   | 1    | None |
    #     # cloud_id正确
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'','cloud_id':325,'page':'','limit':''} | 1 | None |
    #     # instance_name正确
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'sssssjljl','cloud_id':'','page':'','limit':''} | 1 | None |
    #     # cloud_id和instance_name同时存在, 但会出现不匹配
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'sssssjljl','cloud_id':428,'page':'','limit':''} | 0 | 无效的cloud_id |
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'新加坡','cloud_id':428,'page':'','limit':''} | 1 | None |
    #     # cloud_id不存在
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'','cloud_id':3333,'page':'test','limit':''} | 0 | 无效的cloud_id    |
    #     # instance_name不是string, page或者limit非整数
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'','cloud_id':'test','page':'','limit':''}   | 0 | cloud_id不能为非整型 |
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'','cloud_id':'','page':'test','limit':''} | 0 | page不能为非整型 |
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':123,'cloud_id':'','page':'','limit':''}    | 1 | instance_name不能为非字符 |
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'','cloud_id':'','page':'','limit':'test'} | 1 | limit不能为非整型 |
    #     # instance_name不存在
    #     | /cloudwebapi/host/hostlist | get | {'instance_name':'test','cloud_id':'','page':'','limit':''} | 1 | None |


    # 场景大纲: 单个云主机详情
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                     | method | params              | code | msg           |
    #     | /cloudwebapi/host/hostinfo | get    | {'host_id':90}      | 1    | None          |
    #     | /cloudwebapi/host/hostinfo | get    | {'host_id':13}      | 1    | None          |
    #     | /cloudwebapi/host/hostinfo | get    | {'host_id':''}      | 0    | host_id不能为非整数   |
    #     | /cloudwebapi/host/hostinfo | get    | {'host_id':'test'}  | 0    | host_id不能为非整数 |
    #     | /cloudwebapi/host/hostinfo | get    | {'host_id':1211111} | 1    | None          |


    # 场景大纲: 云主机重启
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                       | method | params        | code | msg  |
    #     | /cloudwebapi/host/hostreboot | post   | {'host_id':90} | 1    | None |
    #     # 主机存在，但对应业务组被删除
    #     | /cloudwebapi/host/hostreboot | post | {'host_id':13}      | 0 | 无此实例          |
    #     | /cloudwebapi/host/hostreboot | post | {'host_id':''}      | 0 | host_id不能为非整数   |
    #     | /cloudwebapi/host/hostreboot | post | {'host_id':'test'}  | 0 | host_id不能为非整数 |
    #     | /cloudwebapi/host/hostreboot | post | {'host_id':1211111} | 0 | 无此实例          |


    # 场景大纲: 云主机关机
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                         | method | params         | code | msg  |
    #     | /cloudwebapi/host/hostpoweroff | post   | {'host_id':90} | 1    | None |
    #     # 主机存在，但对应业务组被删除
    #     | /cloudwebapi/host/hostpoweroff | post | {'host_id':13}      | 0 | 无此实例          |
    #     | /cloudwebapi/host/hostpoweroff | post | {'host_id':''}      | 0 | host_id不能为非整数   |
    #     | /cloudwebapi/host/hostpoweroff | post | {'host_id':'test'}  | 0 | host_id不能为非整数 |
    #     | /cloudwebapi/host/hostpoweroff | post | {'host_id':1211111} | 0 | 无此实例          |
    #     # 一个已关机的再次关机


    # 场景大纲: 云主机开机
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                        | method | params         | code | msg  |
    #     | /cloudwebapi/host/hostpoweron | post   | {'host_id':90} | 1    | None |
    #     # 主机存在，但对应业务组被删除
    #     | /cloudwebapi/host/hostpoweron | post | {'host_id':13}      | 0 | 无此实例          |
    #     | /cloudwebapi/host/hostpoweron | post | {'host_id':''}      | 0 | host_id不能为非整数   |
    #     | /cloudwebapi/host/hostpoweron | post | {'host_id':'test'}  | 0 | host_id不能为非整数 |
    #     | /cloudwebapi/host/hostpoweron | post | {'host_id':1211111} | 0 | 无此实例          |
    #     # 一个开机的再次开机


    # 场景大纲: 云主机重置系统密码
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                              | method | params                                                 | code | msg  |
    #     | /cloudwebapi/host/hostresetpassword | post   | {'host_id':90,'password':'jietest','user_name':'root'} | 1    | None |
    #     # 非空判断
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':'','password':'','user_name':''} | 1 | None |
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':90,'password':'','user_name':''}        | 0 | password不能为空 |
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':90,'password':'jietest','user_name':''} | 1 | None |
    #     # 主机存在，但对应业务组被删除
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':13,'password':'jietest','user_name':'root'} | 0 | 无此实例 |
    #     # 不存在此云主机
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':11111,'password':'jietest','user_name':'root'}  | 0 | 无此实例          |
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':'test','password':'jietest','user_name':'root'} | 0 | host_id不能为非整数 |
    #     # 密码或者用户不是字符串
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':90,'password':123434514,'user_name':'root'} | 0 | 参数错误！ |
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':90,'password':'jietest','user_name':12234}  | 0 | 参数错误！ |
    #     # 用户不存在
    #     | /cloudwebapi/host/hostresetpassword | post | {'host_id':90,'password':'jietest','user_name':'jietest'} | 0 | 无此实例 |
    #     # 非root用户
    #     # 目前如何确认密码是否重置


    # 场景大纲: 云主机重置VNC连接密码
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                                 | method | params                              | code | msg  |
    #     | /cloudwebapi/host/hostresetvncpassword | post   | {'host_id':90,'password':'jietest'} | 1    | None |
    #     # 非空判断
    #     | /cloudwebapi/host/hostresetvncpassword | post | {'host_id':'','password':''} | 0 | host_id不能为空  |
    #     | /cloudwebapi/host/hostresetvncpassword | post | {'host_id':90,'password':''} | 0 | password不能为空 |
    #     # 主机存在，但对应业务组被删除
    #     | /cloudwebapi/host/hostresetvncpassword | post | {'host_id':13,'password':'jietest'} | 0 | 无此实例 |
    #     # 不存在此云主机
    #     | /cloudwebapi/host/hostresetvncpassword | post | {'host_id':11111,'password':'jietest'}  | 0 | 无此实例          |
    #     | /cloudwebapi/host/hostresetvncpassword | post | {'host_id':'test','password':'jietest'} | 0 | host_id不能为非整数 |
    #     # 密码或者用户不是字符串，int会被转为字符串
    #     | /cloudwebapi/host/hostresetvncpassword | post | {'host_id':90,'password':123434514} | 1 | None |
    #     # 目前如何确认密码是否重置


    # 场景大纲: 获取主机状态
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                       | method | params         | code | msg  |
    #     | /cloudwebapi/host/hoststatus | post   | {'host_id':90} | 1    | None |
    #     # 主机存在，但对应业务组被删除
    #     | /cloudwebapi/host/hoststatus | post | {'host_id':13}      | 0 | 无此实例          |
    #     | /cloudwebapi/host/hoststatus | post | {'host_id':''}      | 0 | host_id不能为空   |
    #     | /cloudwebapi/host/hoststatus | post | {'host_id':'test'}  | 0 | host_id不能为非整数 |
    #     | /cloudwebapi/host/hoststatus | post | {'host_id':1211111} | 0 | 无此实例          |


    # 场景大纲: 删除主机
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                       | method | params              | code | msg           |
    #     | /cloudwebapi/host/hostdelete | post   | {'host_id':74}      | 1    | None          |
    #     | /cloudwebapi/host/hostdelete | post   | {'host_id':''}      | 0    | host_id不能为空   |
    #     | /cloudwebapi/host/hostdelete | post   | {'host_id':'test'}  | 0    | host_id不能为非整数 |
    #     | /cloudwebapi/host/hostdelete | post   | {'host_id':1211111} | 0    | 无此实例          |


# *************************云服务器监控**************************


    # 场景大纲: cpu监控排序并获取Top_n
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl | method | params | code | msg |
    #     | /cloudwebapi/hostmonitor/cpuusage | get    | {'limit':'','sort':''}         | 0    | 查询条数不能为空。      |
    #     | /cloudwebapi/hostmonitor/cpuusage | get    | {'limit':5,'sort':''}          | 0    | 排序规则不能为空。        |
    #     | /cloudwebapi/hostmonitor/cpuusage | get    | {'limit':100,'sort':'desc'}    | 0    | 查询条数的值必须不大于20。 |
    #     | /cloudwebapi/hostmonitor/cpuusage | get    | {'limit':'test','sort':'desc'} | 0    | 查询条数必须是整数。     |
    #     | /cloudwebapi/hostmonitor/cpuusage | get    | {'limit':5,'sort':5}           | 0    | 排序规则是无效的。      |
    #     | /cloudwebapi/hostmonitor/cpuusage | get    | {'limit':5,'sort':'test'}      | 0    | 排序规则是无效的。      |
    #     | /cloudwebapi/hostmonitor/cpuusage | get | {'limit':5,'sort':'desc'} | 1 | None |
    #     | /cloudwebapi/hostmonitor/cpuusage | get | {'limit':5,'sort':'asc'}  | 1 | None |


    # 场景大纲: 云服务器监控信息
    #     当 云服务器监控传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和监控提示<msg>
    # 例子:
    #     | subUrl                                  | method | params                                                   | code | msg       |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get    | {'host_id':'','start_time':'','end_time':'','metric':''} | 0    | 主机编号不能为空。 |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get    | {'host_id':89,'start_time':'','end_time':'','metric':''} | 0    | 开始时间不能为空。 |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get    | {'host_id':89,'start_time':1,'end_time':'','metric':''}  | 0    | 结束时间不能为空。 |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get    | {'host_id':89,'start_time':1,'end_time':2,'metric':''}   | 0    | 监控指标不能为空。 |
    #     # 时间戳范围及格式不正确
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':89,'start_time':'beforeStartTime','end_time':3,'metric':'CpuUsage'}             | 0 | beforeStartTime |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':89,'start_time':'rightStartTime','end_time':3,'metric':'CpuUsage'}              | 0 | 结束时间有误 |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':89,'start_time':'rightStartTime','end_time':'afterEndTime','metric':'CpuUsage'} | 0 | 结束时间有误    |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':89,'start_time':'test','end_time':3,'metric':'CpuUsage'}                        | 0 | 开始时间必须是整数。      |
    #     # 开始时间小于结束时间
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':87,'start_time':'lessCurrent1000','end_time':'lessCurrent2000','metric':'CpuUsage'} | 0 | 结束时间有误 |
    #     # host_id非整型
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':'test','start_time':1,'end_time':2,'metric':'InternetInTraffic'} | 0 | 主机编号必须是整数。 |
    #     # metric非指定值
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':89,'start_time':'rightStartTime','end_time':'rightEndTime','metric':'test'}                                | 0 | 指标监控配置有误 |
    #     | /cloudwebapi/hostmonitor/data-by-metric | get | {'host_id':89,'start_time':'rightStartTime','end_time':'rightEndTime','metric':'CpuUsage,MemoryUsage,InternetInRate'} | 1 | None     |


    # 场景大纲: 批量云服务器监控信息
    #     当 云服务器监控传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和监控提示<msg>
    # 例子:
    #     | subUrl                                   | method | params                                                         | code | msg       |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get    | {'host_ids':'','start_time':'','end_time':'','metric':''}      | 0    | Host Ids不能为空。 |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get    | {'host_ids':'89,90','start_time':'','end_time':'','metric':''} | 0    | 开始时间不能为空。 |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get    | {'host_ids':'89,90','start_time':1,'end_time':'','metric':''}  | 0    | 结束时间不能为空。 |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get    | {'host_ids':'89,90','start_time':1,'end_time':2,'metric':''}   | 0    | 监控指标不能为空。 |
    #     # 时间戳范围及格式不正确
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'beforeStartTime','end_time':3,'metric':'CpuUsage'}             | 0 | beforeStartTime |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'rightStartTime','end_time':3,'metric':'CpuUsage'}              | 0 | 结束时间有误          |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'rightStartTime','end_time':'afterEndTime','metric':'CpuUsage'} | 0 | 结束时间有误          |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'test','end_time':3,'metric':'CpuUsage'}                        | 0 | 开始时间必须是整数。      |
    #     # 开始时间小于结束时间
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'lessCurrent1000','end_time':'lessCurrent2000','metric':'CpuUsage'} | 0 | 结束时间有误 |
    #     # host_ids非整型
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'test','start_time':'rightStartTime','end_time':'rightEndTime','metric':'InternetInTraffic'} | 0 | 主机编号集合有误 |
    #     # metric非指定值
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'rightStartTime','end_time':'rightEndTime','metric':'test'}                                | 0 | 指标监控配置有误 |
    #     | /cloudwebapi/hostmonitor/batch-by-metric | get | {'host_ids':'89,90','start_time':'rightStartTime','end_time':'rightEndTime','metric':'CpuUsage,MemoryUsage,InternetInRate'} | 1 | None     |


# **********************微信绑定&通知告警*****************************


    # 场景大纲: 生成微信绑定二维码URL
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                        | method | params | code | msg  |
    #    # 微信未绑定
    #     | /system/weixin/get-qrcode-url | get    | {}     | 1    | None |
       # 微信已绑定
        # | /system/weixin/get-qrcode-url | get    | {}     | 0    | None |


    # 场景大纲: 微信解绑
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                | method | params | code | msg  |
    #     # 微信已绑定
    #     | /system/weixin/unbind | get    | {}     | 1    | None |
    #     # 微信未绑定
    #     | /system/weixin/unbind | get    | {}     | 0    | None |


    # 场景大纲: 获取告警通知配置列表
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                        | method | params | code | msg  |
    #     | /security/alert/mon-item-list | post   | {}     | 1    | None |


    # 场景大纲: 提交统一告警通知设置
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                                | method | params                                                                                           | code | msg  |
    #     # | /security/alert/update-default-config | post   | {'monItems':'','mobiles':'','emails':'','weixinEnabled':'','mobileEnabled':'','emailEnabled':''} | 1    | None |
    #     | /security/alert/update-default-config | post   | {'monItems':[1,2],'mobiles':'','emails':'','weixinEnabled':'','mobileEnabled':'','emailEnabled':''} | 1    | None |


    # 场景大纲: 提交主机告警通知配置
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                             | method | params                      | code | msg  |
    #     | /security/alert/update-host-config | post   | {'hostId':'','monItems':''} | 1    | None |


    # 场景大纲: 提交主机告警通知配置
    #     当 传入参数<subUrl>和<method>和<params>
    #     那么 获得返回值<code>和提示<msg>
    # 例子:
    #     | subUrl                                  | method | params                                                            | code | msg  |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':'','mobileEnabled':'','emailEnabled':''}         | 0    | 操作失败 |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':True,'mobileEnabled':'','emailEnabled':''}       | 0    | 操作失败 |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':True,'mobileEnabled':False,'emailEnabled':''}    | 0    | 操作失败 |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':0,'mobileEnabled':'','emailEnabled':''}          | 0    | 操作失败 |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':False,'mobileEnabled':True,'emailEnabled':False} | 1    | None |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':0,'mobileEnabled':0,'emailEnabled':0}            | 1    | None |
    #     | /security/alert/receive-notification-by | post   | {'weixinEnabled':5,'mobileEnabled':5,'emailEnabled':166}          | 1    | None |


