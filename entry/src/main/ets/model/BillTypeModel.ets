import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import DbUtil from '../common/utils/DbUtil';
import BillType from '../viewmodel/BillType';

/**
 * 建表语句
 */
const CREATE_TABLE_SQL: string =
  `CREATE TABLE IF NOT EXISTS billtype(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          color TEXT NOT NULL,
          sum_value DOUBLE NOT NULL,
          budget DOUBLE NOT NULL
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

  /**
   * 新增分组
   * @param billtype
   * @returns
   */
  insert(billtype:BillType):Promise<number>{
    console.log('testTag','BillTypeModel','insert()',JSON.stringify(billtype));
    return DbUtil.insert(TABLE_NAME,billtype,COLUMNS)
  }
  /**
   * 修改BillType
   */
  update(billtype:BillType){
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id',billtype.id)
    return DbUtil.update(predicates,billtype,COLUMNS)
  }

  // 根据id删除
  deleteById(id:number):Promise<number>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id',id)
    return DbUtil.delete(predicates)
  }

  list():Promise<BillType[]>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    return DbUtil.queryForList<BillType>(predicates,COLUMNS)
  }

  getBillTypeById(id:number):Promise<BillType[]>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id',id)
    return DbUtil.queryForList(predicates,COLUMNS)
  }


}


let billTypeModel = new BillTypeModel()
export default billTypeModel as BillTypeModel