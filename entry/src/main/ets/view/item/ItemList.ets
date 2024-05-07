import DateUtil from '../../common/utils/DateUtil'
import { BillTypeImages, BillTypeNames } from '../../model/BillTypeModels'

import BillService from '../../services/BillService'
import Bill from '../../viewmodel/Bill'

@Component
export default struct ItemList {
  //获取本月的消费记录
  @Link billArr:Bill[]

  build() {
    Column(){
      Text($r('app.string.wallet_consume_records'))
        .fontWeight(FontWeight.Bold)
        .fontSize(20)

      List(){
        ForEach(
          this.billArr
          ,(item:Bill)=>{
              ListItem(){
                // if (item.isExpend) {
                  Row({space:10}){
                    //支出类型图片,此处可换成不同颜色显示，对应颜色字段
                    Image(BillTypeImages[item.typeId].typeName)
                      .width(40)
                    Column(){
                      //支出类型
                      // Text('水电')
                      Text(BillTypeNames[item.typeId].typeName)
                      //日期
                      Text(`${DateUtil.formatDate(item.date)}`)
                        .fontSize(12)
                        .fontColor(Color.Gray)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .layoutWeight(1)

                    //金额
                    if (item.isExpend) {
                      Column(){
                        Text(`-${item.amount}￥`)
                          .fontColor(Color.Red)
                        Text(item.label)
                      }
                    }else {
                      Column(){
                        Text(`${item.amount}￥`)
                          .fontColor(Color.Green)
                        Text(item.label)
                      }
                    }
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(15)
                  .width('100%')
                  .padding(10)
                  .margin(5)
                // }
          }
        })
      }
      .scrollBar(BarState.On)
      .height('100%')
    }

  }
}