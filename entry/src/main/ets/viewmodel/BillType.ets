import ColorUtil from '../common/utils/ColorUtil'

export default class BillType{
  // 组id
  id?:number
  // 分组的组名
  name:string
  // 该组的颜色
  color:string
  // 组内总金额
  sumValue:number = 0
  // 组预算
  budget:number

  constructor(name: string = '其它',
              sumValue:number,
              budget:number = sumValue,
              color: string = ColorUtil.getRandomColorHex(),
              id?:number,) {
    this.name = name
    this.color = color
    this.budget = budget
    this.sumValue = sumValue
    this.id = id
  }

}