
@Component
export default struct ItemShow {
  //今日剩余预算
  @Link restTodayBudget:number

  build() {
    Stack(){
      Image($r('app.media.budget_background'))
        .width('90%')
        .height(120)
        .borderRadius(15)
        .margin({bottom:5})

      Column({space:10}){
        Text('今日剩余预算')
          .fontSize(15).fontColor(Color.White)
          .opacity(0.6)
        Text(`￥${this.restTodayBudget.toFixed(2)}`)
          .fontSize(20).fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .width('80%')
      .alignItems(HorizontalAlign.Start)
    }
  }
}