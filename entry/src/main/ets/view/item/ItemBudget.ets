@Component
export default struct ItemBudget {
  build() {
    Row(){
      Column({space:10}){
        Text('收入')
          .fontSize(15)
          .opacity(0.8)
          .fontColor($r('app.color.light_primary_color'))
        Text('1000.00')
          .fontSize(20)
          .fontWeight(FontWeight.Bolder)
      }
      .margin({right:100})

      Column({space:10}){
        Text('支出')
          .fontSize(15)
          .opacity(0.8)
          .fontColor(Color.Red)

        Text('20.00')
          .fontSize(20)
          .fontWeight(FontWeight.Bolder)
      }

    }
    .width('90%')
    .height(80)
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(5)
    .margin({bottom:20})
  }
}