
import BillModelType from '../viewmodel/BillModelType'


/**
 * 账单数据类型的枚举
 */
enum BillTypeEnum{
  /**
   * 出行
   */
  TRAVEL,

  /**
   * 购物
   */
  SHOP,

  /**
   * 水电
   */
  HYDROPOWER,

  /**
   * 房租
   */
  RENT,

  /**
   * 饮食
   */
  EATING,

  /**
   * 话费
   */
  PHONE_BILL,

  /**
   * 其他
   */
  OTHER_COST

}

/**
 * 记录消费类型常量
 */
const BillModelTypes:BillModelType[] = [
  new BillModelType(0,$r('app.media.year')),
  new BillModelType(1,$r('app.media.year')),
  new BillModelType(2,$r('app.media.year')),
  new BillModelType(3,$r('app.media.year')),
  new BillModelType(4,$r('app.media.year')),
  new BillModelType(5,$r('app.media.year')),
  new BillModelType(6,$r('app.media.year')),
]

export {BillTypeEnum,BillModelTypes}