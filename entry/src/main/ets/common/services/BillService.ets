import BillModel from '../../model/BillModel';
import Bill from '../../viewmodel/Bill';
import BillType from '../../viewmodel/BillType';
import GroupInfo from '../../viewmodel/GroupInfo';
import DateUtil from '../utils/DateUtil';

class BillService{

  /**
   * 插入一条账单
   * @param label 账单名字
   * @param amount 账单金额
   * @param date 账单日期
   * @param isExpend 出账还是入账
   * @param groupId 分组id
   * @returns
   */
  insert(label:string,amount:number,date:Date,isExpend:boolean,groupId?:number):Promise<number>{

    return BillModel.insert({label:label,amount:amount,date:date,isExpend:isExpend,groupId:groupId})
  }

  getBillGroup(bills:Bill[],billtypes:BillType[]):GroupInfo<BillType,Bill>{
    let group = billtypes.map((billtype:BillType)=>{
      return new GroupInfo(billtype,[])
    })
    return
  }


}