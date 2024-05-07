import { BillTypeEnum } from '../../model/BillTypeModels'

@Component
export default struct ItemConsumeType {
  @Link amount:number
  @Link typeId:number

  build() {
    Column({space:10}){
      //金额展示
      Row({space:10}){
        Text('金额')
          .fontSize(20)

        Text(this.amount.toFixed(2))
          .width(100)
          .height(50)
          .padding(10)
          .borderRadius(5)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ffd8d9de')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceEvenly)

      //类型展示
      Row({space:10}){
        Text('消费类型')
          .fontSize(20)

        /**
         * 选择定义的枚举常量，下标与枚举常量值对应
         */
        Select([
          { value: $r('app.string.consume_type_travel'), icon:  $r('app.media.travel') },
          { value: $r('app.string.consume_type_shop'), icon:  $r('app.media.shop') },
          { value: $r('app.string.consume_type_hydropower'), icon:  $r('app.media.hydropower') },
          { value: $r('app.string.consume_type_rent'), icon:  $r('app.media.rent') },
          { value:$r('app.string.consume_type_eating'), icon:  $r('app.media.eating') },
          { value: $r('app.string.consume_type_phonebill'), icon:  $r('app.media.phone') },
          { value: $r('app.string.consume_type_other'), icon:  $r('app.media.others') },
        ])
          .selected(6) //默认选择的下标
          .value('请选择')
          .font({ size: 20, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 20, weight: 400 })
          .optionFont({ size: 20, weight: 400 })
          .onSelect((index?: number) => {
            console.info('Select:' + index)
            this.typeId = index;
          })
      }

    }
    .margin(10)
  }
}