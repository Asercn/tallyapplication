import BillModel from '../model/BillModel'
import BillTypeModel from '../model/BillTypeModel'
import Bill from '../viewmodel/Bill'
import BillType from '../viewmodel/BillType'
import BillService from './BillService'

class BillTypeService{
  /**
   * 获取该组的消耗量
   * @param id
   * @returns
   */
  async getBillTypeSumValue(id:number){
    let billtype:BillType[] = await this.getBillTypeById(id)
    return billtype.map(billtype=>billtype.sumValue)
  }

  //更新数据
  update(billtype:BillType){
    BillTypeModel.update(billtype)
  }
  /**
   * 获取该组的预算
   * @param id
   * @returns
   */
  async getBillTypeBudget(id:number){
    let billtype:BillType[] = await this.getBillTypeById(id)
    return billtype.map(billtype=>billtype.budget)
  }

  /**
   * 获取所有的billType
   */
  list(){
    return BillTypeModel.list()
  }

  /**
   * 获取总预算
   */
  async getBudget(){
    let billtypes:BillType[] = await this.list()
    let budget = 0
    billtypes.forEach(billtype=>{
      budget += billtype.budget
    })
    return budget

  }

  /**
   * 获取总支出
   */
  async getSumValue(): Promise<number>{
    let billtypes:BillType[] = await this.list()
    let sumValue:number = 0
    billtypes.forEach(billtype=>{
      sumValue += billtype.sumValue
    })
    return sumValue

  }


  getBillTypeById(id:number){
    return BillTypeModel.getBillTypeById(id)
  }



  getBillType(){
    return BillTypeModel.list()
  }

  insert(name?:string,budget?:number,color?:string){
    return BillTypeModel.insert(new BillType(name,budget,color))
  }

  /**
   * 根据分组id删除分组
   * @param id
   */
  async deleteBillType(id:number){
    // 先删除账单或者将分组id变成空
    console.log('testTag','BillTypeService','进入到删除分组方法')
    await BillModel.deleteByGroupId(id)
    await BillTypeModel.deleteById(id)

  }




}

let billTypeService = new BillTypeService()
export default billTypeService as BillTypeService