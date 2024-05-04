import BillTypeModel from '../../model/BillTypeModel'
import BillType from '../../viewmodel/BillType'

class BillTypeService{
  getBillType(){
    return BillTypeModel.list()
  }

  insert(name?:string,budget?:number,color?:string){
    return BillTypeModel.insert(new BillType(name,budget,color))
  }
}

let billTypeService = new BillTypeService()
export default billTypeService as BillTypeService