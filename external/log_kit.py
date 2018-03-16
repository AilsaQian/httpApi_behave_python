# -*- coding:utf-8 -*-
"""
log handler
"""
import os
import logging
import sys

class LogFilter(logging.Filter):
    """
    Filters (lets through) all messages with level < LEVEL
    """
    def __init__(self, level):
        self.level = level

    def filter(self, record):
        return record.levelno < self.level

def get_logger():
    ROOT_PATH = os.path.dirname(os.path.realpath(__file__))
    LOG_INFO_PATH = os.path.join(ROOT_PATH, '../result/info.log')
    LOG_ERR_PATH = os.path.join(ROOT_PATH, '../result/err.log')

    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)
    formatter = logging.Formatter('[%(asctime)s] $%(levelname)s (%(filename)s:%(lineno)d) %(message)s')
    stdout_hdlr = logging.StreamHandler(sys.stdout)
    stderr_hdlr = logging.StreamHandler(sys.stderr)
    log_filter = LogFilter(logging.WARNING)
    stdout_hdlr.addFilter(log_filter)
    stdout_hdlr.setLevel(logging.INFO)
    stderr_hdlr.setLevel(logging.WARNING)
    stdout_hdlr.setFormatter(formatter)
    stderr_hdlr.setFormatter(formatter)
    root_logger.addHandler(stdout_hdlr)
    root_logger.addHandler(stderr_hdlr)
    file_info_hdlr = logging.FileHandler(LOG_INFO_PATH)
    file_err_hdlr = logging.FileHandler(LOG_ERR_PATH)
    file_info_hdlr.addFilter(log_filter)
    file_info_hdlr.setLevel(logging.INFO)
    file_err_hdlr.setLevel(logging.WARNING)
    file_info_hdlr.setFormatter(formatter)
    file_err_hdlr.setFormatter(formatter)
    root_logger.addHandler(file_info_hdlr)
    root_logger.addHandler(file_err_hdlr)

    return root_logger