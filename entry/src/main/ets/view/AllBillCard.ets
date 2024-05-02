
@Component
export default struct allBillCard {
  build() {
    // 账单总图
    Column({space:8}){
      // 周项
      this.DataItem($r('app.media.week'),'本周',`2024年04月29日-2024年5月5日`,200.00,1000)
      this.DataItem($r('app.media.month'),'本月',`2024年05月02日`,100,3000.00)
      this.DataItem($r('app.media.year'),'本年',`2024年05月02日`,1111.11,5555)

    }
    .cardStyle()
    .backgroundColor('#fcfcfc')
    .margin({top:10})
    .width('100%')
  }

  @Builder DataItem(image:ResourceStr,title:string,time:string,expend:number,income:number){
    Row({space:8}){
      Image(image).width(20)
      Column(){
        Text(title)
          .fontSize(14)
        Text(time)
          .fontColor('#cfcfcf')
          .fontSize(10)
      }.alignItems(HorizontalAlign.Start)
      Blank()
      Column(){
        Row({space:5}){
          Text(`总收入`)
            .fontSize(10)
            .fontColor('#cfcfcf')
          Text(`${income}`)
            .fontColor($r('app.color.primary_color'))
            .fontSize(14)
        }
        Row({space:5}){
          Text(`总支出`)
            .fontSize(10)
            .fontColor('#cfcfcf')
          Text(`${expend}`)
            .fontColor($r('app.color.contrast_primary_color'))
            .fontSize(14)
        }
      }

    }.width('100%')
  }
}


@Styles function cardStyle(){
  .padding(10)
  .backgroundColor(Color.White)
  .width('100%')
  .shadow({radius:10,color:Color.Gray})

  .borderRadius(20)
}

