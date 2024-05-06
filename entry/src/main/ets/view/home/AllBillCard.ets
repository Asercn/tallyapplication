import BillService from '../../services/BillService'
import DateUtil from '../../common/utils/DateUtil'
import Bill from '../../viewmodel/Bill'

@Component
export default struct allBillCard {
  @Consume @Watch('aboutToAppear') Refresh:boolean

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
  async getValues(){

    // 获取到所有的bill数据
    let bills:Bill[] = await BillService.getAllBill()
    this.weekValues = await bills.map((bill:Bill)=>{
      console.log('testTag','AllBillCard','bill',JSON.stringify(bill))
      if(bill.date>this.week.startTimestamp && bill.date < this.week.endTimestamp){
        if (bill.isExpend) {
          this.weekExpend += bill.amount
        }else{
          this.weekIncome += bill.amount
        }
        return bill
      }
    })
    this.monthValues = await bills.map((bill:Bill)=>{
      if(bill.date>this.month.startTimestamp && bill.date < this.month.endTimestamp){
        if (bill.isExpend) {
          this.monthExpend += bill.amount
        }else{
          this.monthIncome += bill.amount
        }
        return bill
      }
    })
    this.yearValues = await bills.map((bill:Bill)=>{
      if(bill.date>this.year.startTimestamp && bill.date < this.year.endTimestamp){
        if (bill.isExpend) {
          this.yearExpend += bill.amount
        }else{
          this.yearIncome += bill.amount
        }
        return bill
      }
    })



    console.log('testTag','AllBillCard','week',this.weekIncome,this.weekExpend)
  }

  aboutToAppear(){
    this.weekExpend = 0
    this.weekIncome = 0
    this.monthExpend = 0
    this.monthIncome = 0
    this.yearExpend = 0
    this.yearIncome = 0
    this.getValues()
  }

  build() {
    // 账单总图
    Column({space:8}){
      // 周项
      this.DataItem({image:$r('app.media.week'),title:'本周',time:`${DateUtil.formatDate(this.week.startTimestamp)}-${DateUtil.formatDate(this.week.endTimestamp)}`,expend:this.weekExpend,income:this.weekIncome})
      this.DataItem({
        image: $r('app.media.month'),
        title: '本月',
        time: `${new Date(this.month.startTimestamp).getMonth() + 1}月`,
        expend: this.monthExpend,
        income: this.weekIncome
      })
      this.DataItem({
        image: $r('app.media.year'),
        title: '本年',
        time: `${new Date(this.year.startTimestamp).getFullYear()}年`,
        expend: this.yearExpend,
        income: this.yearIncome
      })

    }
    .cardStyle()
    .backgroundColor('#fcfcfc')
    .margin({top:10})
    .width('100%')
  }

  @Builder DataItem($$:{image:ResourceStr,title:string,time:string,expend:number,income:number}){
    Row({space:8}){
      Image($$.image).width(20)
      Column(){
        Text($$.title)
          .fontSize(14)
        Text($$.time)
          .fontColor('#cfcfcf')
          .fontSize(10)
      }.alignItems(HorizontalAlign.Start)
      Blank()
      Column(){
        Row({space:5}){
          Text(`总收入`)
            .fontSize(10)
            .fontColor('#cfcfcf')
          Text(`${$$.income}`)
            .fontColor($r('app.color.contrast_primary_color'))
            .fontSize(14)
        }
        Row({space:5}){
          Text(`总支出`)
            .fontSize(10)
            .fontColor('#cfcfcf')
          Text(`${$$.expend}`)
            .fontColor($r('app.color.primary_color'))
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

