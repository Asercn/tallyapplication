import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import DbUtil from '../common/utils/DbUtil';

/**
 * 建表语句
 */
const CREATE_TABLE_SQL: string =
  `CREATE TABLE IF NOT EXISTS billtype(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          color TEXT NOT NULL,
          sum_value DOUBLE NOT NULL,
          budger DOUBLE NOT NULL,
        )`
const TABLE_NAME = 'billtype'
/**
 * 映射关系表
 */
const COLUMNS: ColumnInfo[] = [
  { name: 'id', columnName: 'id', type: ColumnType.LONG },
  { name: 'name', columnName: 'name', type: ColumnType.STRING },
  { name: 'color', columnName: 'color', type: ColumnType.STRING },
  { name: 'sumValue', columnName: 'sum_value', type: ColumnType.DOUBLE },
  { name: 'budget', columnName: 'budget', type: ColumnType.DOUBLE },
]


class BillTypeModel {
  // 创建表
  getCreateTableSql(): string {
    return CREATE_TABLE_SQL;
  }

  // 根据id删除
  deleteById(id:number):Promise<number>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id',id)
    return DbUtil.delete(predicates)
  }
}


let billTypeModel = new BillTypeModel()
export default billTypeModel as BillTypeModel