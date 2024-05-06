import BillModel from '../model/BillModel';
import BillTypeModel from '../model/BillTypeModel';
import Bill from '../viewmodel/Bill';
import BillType from '../viewmodel/BillType';
import GroupInfo from '../viewmodel/GroupInfo';
import DateUtil from '../common/utils/DateUtil';
import DbUtil from '../common/utils/DbUtil';
import BillTypeService from './BillTypeService';

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
  async insert(label:string,amount:number,date:Date,isExpend:boolean,groupId?:number,typeId?:number):Promise<number>{
    let billtypes:BillType[] = await BillTypeService.getBillTypeById(groupId)
    // 修改数值
    billtypes.forEach(billtype=>{
      if(isExpend){
        billtype.sumValue += amount
      }
      // 传入数据库
      BillTypeService.update(billtype)
    })



    return BillModel.insert({label:label,amount:amount,date:date.getTime(),isExpend:isExpend.toString(),groupId:groupId,typeId:typeId})
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
      groups.forEach((group:GroupInfo<BillType,Bill>)=>{
        if (bill.groupId == group.type.id) {
          group.items.push(bill)
        }
      })
      // groups[bill.groupId].items.push(bill)


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
   * 查询雏该组的所有bill
   * @param groupId
   * @returns
   */
  getBillByGroupId(groupId:number){
    return BillModel.getBillByGroupId(groupId)
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

  async getIncome(){
    let bills:Bill[] = await this.list()
    let income = 0
    bills.forEach(bill=>{
      if (!bill.isExpend) {
        income += bill.amount
      }
    })

    return income
  }

  async list(){
    let bills:Bill[] = await BillModel.list()
    return bills
  }


  getAllBill(){
    return BillModel.list()
  }


}

let billService = new BillService()
export default billService as BillService