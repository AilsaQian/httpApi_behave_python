"""write log to file."""
import logging
import os


ROOT_PATH = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))


def get_logger(filename=None, logger_name=None, on_screen=False, level=None):
    """Return logger."""
    if filename is None:
        filename = 'stepLog'
    if not logger_name:
        logger_name = filename

    logger = logging.getLogger(logger_name)

    formatter = logging.Formatter(
        '[%(asctime)s] %(levelname)s - %(name)s:%(lineno)d - %(message)s',
        '%Y-%m-%d %X')

    if level is None:
        level = logging.INFO
    elif level == "debug":
        level = logging.DEBUG
    elif level == "warning":
        level = logging.WARN
    elif level == "error":
        level = logging.ERROR
    elif level == "critical":
        level = logging.CRITICAL

    stream_handler = logging.StreamHandler()
    stream_handler.setLevel(level)
    file_handler = logging.FileHandler('%s/result/%s.log' % (ROOT_PATH, filename))
    file_handler.setLevel(level)

    file_handler.setFormatter(formatter)
    stream_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    if on_screen:
        logger.addHandler(stream_handler)
    logger.setLevel(level)

    return logger
