@Component
export default struct ItemBudget {

  @Link inCome:number //本月收入
  @Link expenditure:number //本月支出
  @Link budget:number //本月预算

  build() {
    Row(){
      Column({space:10}){
        Text('本月收入')
          .fontSize(15)
          .opacity(0.8)
          .fontColor($r('app.color.light_primary_color'))
        Text(`${this.inCome}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bolder)
      }


      Column({space:10}){
        Text('本月支出')
          .fontSize(15)
          .opacity(0.8)
          .fontColor(Color.Red)

        Text(`${this.expenditure}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bolder)
      }

      Column({space:10}){
        Text('本月预算')
          .fontSize(15)
          .opacity(0.8)
          .fontColor(Color.Red)

        Text(`${this.budget}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bolder)
      }
    }
    .width('90%')
    .height(80)
    .padding(10)
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor(Color.White)
    .borderRadius(5)
    .margin({bottom:20})
  }
}