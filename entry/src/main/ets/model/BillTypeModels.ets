
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
 * 记录消费类型图片
 */
const BillTypeImages:BillModelType[] = [
  new BillModelType(0,$r('app.media.travel')),
  new BillModelType(1,$r('app.media.shop')),
  new BillModelType(2,$r('app.media.hydropower')),
  new BillModelType(3,$r('app.media.rent')),
  new BillModelType(4,$r('app.media.eating')),
  new BillModelType(5,$r('app.media.phone')),
  new BillModelType(6,$r('app.media.others')),
]

/**
 * 记录消费类型常量
 */
const BillTypeNames:BillModelType[]=[
  new BillModelType(0,$r('app.string.consume_type_travel')),
  new BillModelType(1,$r('app.string.consume_type_shop')),
  new BillModelType(2,$r('app.string.consume_type_hydropower')),
  new BillModelType(3,$r('app.string.consume_type_rent')),
  new BillModelType(4,$r('app.string.consume_type_eating')),
  new BillModelType(5,$r('app.string.consume_type_phonebill')),
  new BillModelType(6,$r('app.string.consume_type_other')),
]


export {BillTypeEnum,BillTypeImages,BillTypeNames}