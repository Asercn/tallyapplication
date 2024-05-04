import ColorUtil from '../common/utils/ColorUtil'

export default class BillType{
  // 组id
  id?:number
  // 分组的组名
  name:string
  // 该组的颜色
  color:string
  // 组预算
  budget:number


  // 组内总金额
  sumValue:number

  constructor(name: string = '其它',
              budget:number = 0,
              color: string = ColorUtil.getRandomColorHex()) {
    this.name = name
    this.color = color
    this.budget = budget
    this.sumValue = 0
  }

}