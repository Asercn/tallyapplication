/**
 * 账单数据模型
 */
export default class Bill{
  /**
   * 账单id
   */
  id?:number
  /**
   * 账单分类id
   */
  groupId?:number
  /**
   * 账单说明
   */
  label:string
  /**
   * 账单金额
   */
  amount:number
  /**
   * 账单日期
   */
  date:number
  /**
   * 收入还是支出类型
   */
  isExpend:boolean=true

  /**
   * 类型id
   */
  typeId:number


  constructor(amount: number,
              date: Date,
              isExpend: boolean,
              label: string,
              typeId?:number,
              id?: number,
              groupId?: number) {
    this.id = id
    this.groupId = groupId
    this.label = label
    this.amount = amount
    this.date = date.getTime()
    this.isExpend = isExpend
    this.typeId = typeId
  }

}