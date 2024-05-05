import BillService from '../../common/services/BillService'
import DateUtil from '../../common/utils/DateUtil'
import Bill from '../../viewmodel/Bill'

@Component
export default struct allBillCard {

  @State weekValues:Bill[] = []
  @State weekIncome:number = 0
  @State weekExpend:number = 0
  @State monthValues:Bill[] = []
  @State monthExpend:number = 0
  @State monthIncome:number = 0
  @State yearValues:Bill[] = []
  @State yearIncome:number = 0
  @State yearExpend:number = 0


  week = DateUtil.getWeekStartAndEndTimestamps()
  month = DateUtil.getMonthStartAndEndTimestamps()
  year = DateUtil.getYearStartAndEndTimestamps()

  // 获取到所有的周,月,年的数据
  getValues(){
    // 获取到所有的bill数据
    BillService.getAllBill().then(bills=>{

      this.weekValues = bills.map((bill:Bill)=>{
        if(bill.date>this.week.startTimestamp && bill.date < this.week.endTimestamp){
          if (bill.isExpend) {
            this.weekExpend += bill.amount
          }else{
            this.weekIncome += bill.amount
          }
          return bill
        }
      })
      this.monthValues = bills.map((bill:Bill)=>{
        if(bill.date>this.month.startTimestamp && bill.date < this.month.endTimestamp){
          if (bill.isExpend) {
            this.monthExpend += bill.amount
          }else{
            this.monthIncome += bill.amount
          }
          return bill
        }
      })
      this.yearValues = bills.map((bill:Bill)=>{
        if(bill.date>this.year.startTimestamp && bill.date < this.year.endTimestamp){
          if (bill.isExpend) {
            this.yearExpend += bill.amount
          }else{
            this.yearIncome += bill.amount
          }
          return bill
        }
      })
    })

  }

  aboutToAppear(){
    this.getValues()
  }

  build() {
    // 账单总图
    Column({space:8}){
      // 周项
      this.DataItem($r('app.media.week'),'本周',`${DateUtil.formatDate(this.week.startTimestamp)}-${DateUtil.formatDate(this.week.endTimestamp)}`,this.weekExpend,this.weekIncome)
      this.DataItem($r('app.media.month'),'本月',`${new Date(this.month.startTimestamp).getMonth()+1}月`,this.monthExpend,this.weekIncome)
      this.DataItem($r('app.media.year'),'本年',`${new Date(this.year.startTimestamp).getFullYear()}年`,this.yearExpend,this.yearIncome)

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

