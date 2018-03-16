# -*- coding: utf-8 -*-
import requests
# from log import *
import json
# from mysqlob import*
from ext import mySql, root_logger
# from nose.tools import assert_equals
from infoConfig import COOKIE, BASEURL


# logger = get_logger(on_screen=True)
baseUrl = BASEURL
cookies = {'PHPSESSID': COOKIE}


def api_method(subUrl, method, params):
    mainUrl = baseUrl + subUrl
    if method == 'get':
        response_message = requests.get(mainUrl, params=params, cookies=cookies)
    else:
        response_message = requests.post(mainUrl, data=params, cookies=cookies)

    root_logger.info(response_message.url)
    root_logger.info(response_message.text)

    return response_message


def json_decode(json_info):
    info = json.JSONDecoder().decode(json_info)
    return info


def del_cloud_key(key):
    userId = '100699'
    sqls = "delete from cloud_key where api_key = %s and user_id = %s"
    param = (key, userId, )
    mySql.delete(sqls, param)
