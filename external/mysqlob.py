# -*- coding:utf-8 -*-
""" A middle ware of DBUtils and program """
from __future__ import absolute_import
from DBUtils.PooledDB import PooledDB
import pymysql as mysql
from pymysql.cursors import DictCursor
from infoConfig import (DB_HOST, DB_PORT, DB_USER, DB_DBNAME, DB_PASSWORD,
    DB_CHARSET, DB_AUTO_COMMIT, DB_MAX_SHARED, DB_MAX_CONNECYIONS, DB_BLOCKING, DB_MAX_USAGE)


class MySqlOB(object):
    def __init__(self, host=None, port=None, user=None, passwd=None,
                 db=None, charset=None, autocommit=None, maxshared=None,
                 maxconnections=None, blocking=None, maxusage=None, cursorclass=DictCursor):

        if host is None:
            host = DB_HOST
        if port is None:
            port = DB_PORT
        if user is None:
            user = DB_USER
        if passwd is None:
            passwd = DB_PASSWORD
        if db is None:
            db = DB_DBNAME
        if charset is None:
            charset = DB_CHARSET
        if autocommit is None:
            autocommit = DB_AUTO_COMMIT
        if maxshared is None:
            maxshared = DB_MAX_SHARED
        if maxconnections is None:
            maxconnections = DB_MAX_CONNECYIONS
        if blocking is None:
            blocking = DB_BLOCKING
        if maxusage is None:
            maxusage = DB_MAX_USAGE

        self.__POOL = PooledDB(
            mysql,
            host=host,
            user=user,
            passwd=passwd,
            db=db,
            port=port,
            charset=charset,
            cursorclass=cursorclass,
            autocommit=autocommit,
            maxshared=maxshared,
            maxconnections=maxconnections,
            blocking=blocking,
            maxusage=maxusage
        )

    def get_connection(self):
        return self.__POOL.connection()

    def insert(self, sql, params):
        conn = self.get_connection()
        cursor = conn.cursor()
        try:
            cursor.execute(sql, params)
            conn.commit()
        except Exception as err:
            conn.rollback()
            raise err
        cursor.close()
        conn.close()

    def update(self, sql, params):
        self.insert(sql, params)

    def select(self, sql, params, one=True):
        conn = self.get_connection()
        cursor = conn.cursor()
        cursor.execute(sql, params)
        if one:
            obj = cursor.fetchone()
        else:
            obj = cursor.fetchall()
        cursor.close()
        conn.close()
        return obj

    def delete(self, sql, params):
        self.insert(sql, params)

    def exec_iu_conn(self, commands, conn, params):
        cursor = conn.cursor()
        try:
            cursor.execute(commands, params)
            conn.commit()
        except Exception as err:
            raise err
            conn.rollback()

    def exec_query_conn(self, commands, conn, params, one=True):
        cursor = conn.cursor()
        cursor.execute(commands, params)
        if one:
            obj = cursor.fetchone()
        else:
            obj = cursor.fetchall()
        cursor.close()
        return obj
