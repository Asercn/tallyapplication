export default class BillModelType{
  /**
   * 类型id
   */
  id:number
  /**
   * 类型名称
   */
  typeName:ResourceStr

  constructor(id: number, typeName: ResourceStr) {
    this.id = id
    this.typeName = typeName
  }
}