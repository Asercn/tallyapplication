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
   * 账单颜色
   */
  color?:string

  constructor(amount: number,
              date: number,
              isExpend: boolean,
              label: string,
              color?:string,
              id?: number,
              groupId?: number) {
    this.id = id
    this.groupId = groupId
    this.label = label
    this.amount = amount
    this.date = date
    this.isExpend = isExpend
    this.color = color
  }

}