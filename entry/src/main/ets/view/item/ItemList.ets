@Component
export default struct ItemList {
  build() {
    Column(){
      Text($r('app.string.wallet_consume_records'))
        .fontWeight(FontWeight.Bold)
        .fontSize(20)

      List(){
        ForEach([1,2,3,4,5,6,7,8,9],item=>{
          ListItem(){
            Row({space:10}){
              //日期
              Column(){
                //月
                Text('05月')
                //日
                Text('05日')
              }
              //支出类型图片,此处可换成不同颜色显示，对应颜色字段
              Image($r('app.media.consume'))
                .width(25)
              //支出类型
              Text('水电')
              Blank()
              //金额
              Text('-100')
            }
            .backgroundColor(Color.White)
            .borderRadius(15)
            .width('100%')
            // .justifyContent(FlexAlign.Center)
            .padding(10)
            .margin(5)
          }
        })
      }
      .height('100%')
    }

  }
}