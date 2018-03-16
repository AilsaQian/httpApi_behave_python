# -*- coding: utf-8 -*-
from behave import *
from nose.tools import assert_equals
# from datetime import datetime
from commonSteps import *
import time
from datetime import datetime,date,timedelta


def parse_params(subUrl, method, params):
    # 全局变量，传到下一个方法
    root_logger.info(subUrl)
    root_logger.info(params)
    global response_message
    response_message = api_method(subUrl, method, params)
    # root_logger.info(response_message.text)
    response_code = response_message.status_code
    try:
        assert_equals(response_code, 200)
    except Exception as err:
        root_logger.error(err)

def get_percentage():
    info = json_decode(response_message.text)
    percentage = info['percentage']
    root_logger.info(percentage)
    return percentage


def get_before_timeStamp(day):
    now = datetime.now();
    beforeDay = now - timedelta(days = day)
    beforeStamp = int(time.mktime(beforeDay.timetuple()))
    return beforeStamp


@given(u'删除业务组{params}')
def del_business_group(context, params):
    params = eval(params)
    root_logger.info("删除业务组")
    root_logger.info(params)
    key = params['key']
    del_cloud_key(key)


@when(u'传入参数{subUrl}和{method}和{params}')
def parse_static_params(context, subUrl, method, params):
    # 将Str转换为Dic
    params = eval(params)
    parse_params(subUrl, method, params)


# 云主机导入查询需要key_id
@then(u'获得key_id和key_name')
def get_key_id(context):
    info = json_decode(response_message.text)
    root_logger.info(info)
    global key_id_pass, key_name_pass
    key_id_pass = info["key_id"]
    key_name_pass = info["key_name"]
    # return key_id, key_name


@when(u'需要动态修改key_id并传入其他参数{subUrl}和{method}和{params}')
def parse_dynamic_keyID_params(context, subUrl, method, params):
    # root_logger.info(params)
    params = eval(params)
    if params['key_id'] == 'rightKeyID':
        params['key_id'] = key_id_pass
    # root_logger.info(params)
    parse_params(subUrl, method, params)


@then(u'获得task_id')
def get_task_id(context):
    info = json_decode(response_message.text)
    root_logger.info(info)
    global task_id_pass
    task_id_pass = info["task_id"]


@when(u'需要动态修改task_id及ifContinue并传入其他参数{subUrl}和{method}和{params}和{ifContinue}')
def parse_params_ifContinue(context, subUrl, method, params, ifContinue):
    # root_logger.info(params)
    params = eval(params)
    if params['task_id'] == 'rightTaskID':
        params['task_id'] = task_id_pass
    # root_logger.info(params)
    parse_params(subUrl, method, params)
    if ifContinue == 'Y':
        request_time = 0
        percentage = get_percentage()
        while percentage < 100 and request_time < 10:
            time.sleep(3)
            parse_params(subUrl, method, params)
            percentage = get_percentage()
            request_time = request_time + 1


@when(u'需要动态修改task_id并传入其他参数{subUrl}和{method}和{params}')
def parse_taskID_params(context, subUrl, method, params):
    # root_logger.info(params)
    params = eval(params)
    if params['task_id'] == 'rightTaskID':
        params['task_id'] = task_id_pass
    # root_logger.info(params)
    parse_params(subUrl, method, params)


@when(u'需要动态修改id并传入其他参数{subUrl}和{method}和{params}')
def parse_id_params(context, subUrl, method, params):
    # root_logger.info(params)
    params = eval(params)
    if params['id'] == 'rightID':
        params['id'] = key_id_pass
    # root_logger.info(params)
    parse_params(subUrl, method, params)


@when(u'云服务器监控传入参数{subUrl}和{method}和{params}')
def parse_monitor_params(context, subUrl, method, params):
    # root_logger.info(params)
    currentTimeStamp = int(time.time())
    params = eval(params)

    if params['start_time'] == 'rightStartTime':
        params['start_time'] = get_before_timeStamp(35) + 100
    elif params['start_time'] == 'beforeStartTime':
        params['start_time'] = get_before_timeStamp(35) - 100
    elif params['start_time'] == 'lessCurrent1000':
        params['start_time'] = currentTimeStamp - 1000

    if params['end_time'] == 'rightEndTime':
        params['end_time'] = currentTimeStamp - 100
    elif params['end_time'] == 'afterEndTime':
        params['end_time'] = currentTimeStamp + 100
    elif params['end_time'] == 'lessCurrent2000':
        params['end_time'] = currentTimeStamp - 2000

    # root_logger.info(params)
    parse_params(subUrl, method, params)


@then(u'获得返回值{code}和提示{msg}')
def check_code_msg(context, code, msg):
    code = int(code)
    info = json_decode(response_message.text)
    # root_logger.info(info)
    messageCode = info["code"]
    assert_equals(messageCode, code)
    if code == 0:
        messageMsg = info["msg"]
        # try:
        assert_equals(messageMsg, msg)
        # except Exception as e:
        #     root_logger.error(e)
    # # count会有不同的类型，所以需要不同处理
    # if isinstance(info["count"], unicode):
    #     messageCount = json_decode(info["count"])
    # else:
    #     messageCount = info["count"]
    # assert_equals(messageCount, count)


@then(u'获得返回值{code}和监控提示{msg}')
def check_monitor_code_msg(context, code, msg):
    code = int(code)
    info = json_decode(response_message.text)
    # root_logger.info(info)
    messageCode = info["code"]
    assert_equals(messageCode, code)
    if code == 0:
        messageMsg = info["msg"]
        if msg == "beforeStartTime":
            msg = "开始时间的值必须不小于" + str(get_before_timeStamp(35)) + "。"
        elif msg == "afterEndTime":
            msg = "结束时间的值必须不大于" + str(int(time.time())) + "。"
        # try:
        assert_equals(messageMsg, msg)
        # except Exception as e:
        #     root_logger.error(e)