import common from '@ohos.app.ability.common';
import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../bean/ColumnInfo';
import Logger from './Logger';

const DB_FILENAME: string = 'tally.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore

  initDB(context: common.UIAbilityContext): Promise<void> {
    let config: relationalStore.StoreConfig = {
      name: DB_FILENAME,
      securityLevel: relationalStore.SecurityLevel.S1
    }
    return new Promise<void>((resolve, reject) => {
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => {
          this.rdbStore = rdbStore
          Logger.debug('testTag','rdbStore 初始化完成！')
          resolve()
        })
        .catch(reason => {
          Logger.debug('testTag','rdbStore 初始化异常', JSON.stringify(reason))
          reject(reason)
        })
    })
  }

  createTable(createSQL: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.rdbStore.executeSql(createSQL)
        .then(() => {
          Logger.debug('testTag','创建表成功', createSQL)
          resolve()
        })
        .catch(err => {
          Logger.error('testTag','创建表失败,' + err.message, JSON.stringify(err))
          reject(err)
        })
    })
  }

  insert(tableName: string, obj: any, columns: ColumnInfo[]): Promise<number> {
    return new Promise((resolve, reject) => {
      // 1.构建新增数据
      let value = this.buildValueBucket(obj, columns)
      // let value:relationalStore.ValuesBucket={"name":"其它","color":"#4409b7","sum_value":0,"budget":0}
      console.log('testTag','DbUtil','value',JSON.stringify(value))
      // 2.新增
      this.rdbStore.insert(tableName, value, (err, id) => {
        if (err) {
          Logger.error('testTag','新增失败！', JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('testTag','新增成功！新增id：', id.toString())
          resolve(id)
        }
      })
    })
  }

  delete(predicates: relationalStore.RdbPredicates): Promise<number> {
    return new Promise((resolve, reject) => {
      this.rdbStore.delete(predicates, (err, rows) => {
        if (err) {
          Logger.error('testTag','删除失败！', JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('testTag','删除成功！删除行数：', rows.toString())
          resolve(rows)
        }
      })
    })
  }

  /**
   * 修改
   * @param predicates 修改谓词
   * @param obj 数据模型名
   * @param columns 表字段名
   * @returns
   */
  update(predicates: relationalStore.RdbPredicates, obj: any, columns: ColumnInfo[]): Promise<number>{
    return new Promise((resolve, reject) => {
      // 1.构建新增数据
      let value = this.buildValueBucket(obj, columns)

      this.rdbStore.update(value,predicates ,(err, id) => {
        if (err) {
          Logger.error('testTag','修改失败！', JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('testTag','修改成功！修改id:', id.toString())
          resolve(id)
        }
      })
    })
  }



  queryForList<T>(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<T[]> {
    return new Promise((resolve, reject) => {
      this.rdbStore.query(predicates, columns.map(info => info.columnName), (err, result) => {
        if (err) {
          Logger.error('testTag','查询失败！', JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('testTag','查询成功！查询行数：', result.rowCount.toString())
          resolve(this.parseResultSet(result, columns))
        }
      })
    })
  }

  parseResultSet<T> (result: relationalStore.ResultSet, columns: ColumnInfo[]): T[] {
    // 1.声明最终返回的结果
    let arr = []
    // 2.判断是否有结果
    if (result.rowCount <= 0) {
      return arr
    }
    // 3.处理结果
    while (!result.isAtLastRow) {
      // 3.1.去下一行
      result.goToNextRow()
      // 3.2.解析这行数据，转为对象
      let obj = {}
      columns.forEach(info => {
        let val = null
        switch (info.type) {
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(info.columnName))
            break
          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(info.columnName))
            break
          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(info.columnName))
            break
          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(info.columnName))
            break
        }
        obj[info.name] = val
      })
      // 3.3.将对象填入结果数组
      arr.push(obj)
      Logger.debug('testTag','查询到数据：', JSON.stringify(obj))
    }
    return arr
  }

  buildValueBucket(obj: any, columns: ColumnInfo[]): relationalStore.ValuesBucket {
    let value = {}
    columns.forEach(info => {
      let val = obj[info.name]
      if (typeof val !== 'undefined') {
        value[info.columnName] = val
      }
    })
    return value
  }
}


let dbUtil: DbUtil = new DbUtil();

export default dbUtil as DbUtil