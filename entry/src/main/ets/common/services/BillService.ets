import BillModel from '../../model/BillModel';
import BillTypeModel from '../../model/BillTypeModel';
import Bill from '../../viewmodel/Bill';
import BillType from '../../viewmodel/BillType';
import GroupInfo from '../../viewmodel/GroupInfo';
import DateUtil from '../utils/DateUtil';
import DbUtil from '../utils/DbUtil';

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

  /**
   * 根据分组id删除分组
   * @param id
   */
  deleteBillType(id:number){
    // 先删除账单或者将分组id变成空
    BillModel.deleteByGroupId(id).then(rep=>{
      BillTypeModel.deleteById(id)
    })

  }

  /**
   * 将分组和账单变成一个数据
   * @param bills 账单
   * @param billtypes 用户定义的账单分组
   * @returns
   */
  getBillGroup(bills:Bill[],billtypes:BillType[]):GroupInfo<BillType,Bill>[]{
    let groups:GroupInfo<BillType,Bill>[] = billtypes.map((billtype:BillType)=>{
      return new GroupInfo(billtype,[])
    })
    bills.forEach((bill:Bill)=>{
      groups[bill.groupId].items.push(bill)
      // if (bill.isExpend) {
      //   groups[bill.groupId].type.sumValue += bill.amount
      // }

    })
    return groups
  }


  /**
   * 根据日期查询所有的bill
   * @param date
   * @returns
   */
  getBill(date?:Date){
    if (date) {
      return BillModel.listByDate(date.getTime())
    }else{
      return BillModel.listByDate(new Date().getTime())
    }
  }

  /**
   * 返回区间内日期的账单
   * @param startDate
   * @param endDate
   * @returns
   */
  listByDateBetween(startDate:Date,endDate:Date){
    return BillModel.listByDateBetween(startDate.getTime(),endDate.getTime())
  }




  getAllBill(){
    return BillModel.list()
  }


}

let billService = new BillService()
export default billService as BillService