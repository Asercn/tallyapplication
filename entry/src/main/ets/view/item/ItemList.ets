import DateUtil from '../../common/utils/DateUtil'
import { BillModelTypes } from '../../model/BillTypeModels'
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
          // [0,1,2]
          ,(item:Bill)=>{
          ListItem(){
            if (item.isExpend) {
              Row({space:10}){
                //日期
                Column(){
                  //月
                  Text(`${DateUtil.formatDate(item.date)}`)
                  // Text(`05月`)
                  //日
                  // Text('05日')
                }
                //支出类型图片,此处可换成不同颜色显示，对应颜色字段
                // Image($r('app.media.consume'))
                Image($r('app.media.consume')) //此处还未换，将
                  .width(25)
                //支出类型
                // Text('水电')
                Text(BillModelTypes[item.groupId].typeName)
                Blank()
                //金额
                Text(`-${item.amount}`)
              }
              .backgroundColor(Color.White)
              .borderRadius(15)
              .width('100%')
              // .justifyContent(FlexAlign.Center)
              .padding(10)
              .margin(5)
            }
          }
        })
      }
      .height('100%')
    }

  }
}