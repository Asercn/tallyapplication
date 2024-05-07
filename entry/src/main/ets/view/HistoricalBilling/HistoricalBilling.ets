import DateUtil from '../../common/utils/DateUtil'
import BillModel from '../../model/BillModel'
import BillService from '../../services/BillService'
import Bill from '../../viewmodel/Bill'
import BudgetList from './BudgetList'
import Middle from './Middle'


@Component
export default struct HistoricalBilling {
  @Provide selectedType: string = '全部账单'; // 中央管理状态
  @Consume @Watch('aboutToAppear') currentIndex:number
  @Provide bills:Bill[] = []  // 总数据
  @Provide InCome:Bill[] = []  // 收入数据
  @Provide Expenditure:Bill[] = []  // 支出数据
  @Provide @Watch('initValue') counter:number = 0



  @Provide sumIncome:number = 0
  @Provide sumExpenditure:number = 0
  @Provide newMonth:string=''


  aboutToAppear(){
    // 初始化时间
    AppStorage.SetOrCreate('selectedDate',new Date().getTime())
    this.initValue()
    // 过滤数据
    console.log('testTag','HistorB','currentIndex',this.currentIndex)
  }

  initValue(){
    // 获取所有数据
    this.getBills().then(rep=>{
      // 获取两个分组的数据
      this.getIE().then(rep=>{
        // 获取两个分组的总支出和预算
        let income = 0
        let expenditure = 0
        this.InCome.forEach(bill=> {
          income += bill.amount
          console.log('testTag','HistoricalBilling','income',income)
        })
        this.Expenditure.forEach(bill=> {
          expenditure += bill.amount
          console.log('testTag','HistoricalBilling','expenditure',expenditure)
        })
        this.sumIncome = income
        this.sumExpenditure = expenditure
      })

    })
    //   .then(rep=>{
    //   // this.filterData()
    // })
  }

  async getIE(){
    this.InCome = await this.bills.filter(bill=>!bill.isExpend)
    this.Expenditure = await this.bills.filter(bill=>bill.isExpend)
  }

  // 获取到所有的bill数据方法
  async getBills(){
    console.log('testTag','HistoricalBilling','selectedDate',AppStorage.Get('selectedDate'))
    let day = DateUtil.getTodayRange(new Date(AppStorage.Get('selectedDate')))
    this.bills = await BillModel.listByDateBetween(day.start,day.end)
    console.log('testTag','HistoricalBilling','bills',JSON.stringify(this.bills))
  }



  build() {
    Column({space:15}){
      //1.头部
      //Header()
      //中间
      Middle()
      // Middle({ selectedType: this.selectedType })
      // 3.记录列表
      BudgetList()
      // BudgetList({ selectedType: this.selectedType })
    }
    .padding(10)
    .width('100%')
    .height('100%')
  }
}

