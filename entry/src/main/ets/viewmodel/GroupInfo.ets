export default class GroupInfo<TYPE,ELEMENT>{
  /**
   * 分组类型
   */
  type:TYPE

  /**
   * 组内数据集合
   */
  items:ELEMENT[]


  constructor(type:TYPE,items:ELEMENT[]) {
    this.type = type
    this.items = items
  }

}