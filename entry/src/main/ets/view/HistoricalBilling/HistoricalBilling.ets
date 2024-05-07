import BillService from '../../services/BillService'
import Bill from '../../viewmodel/Bill'
import BudgetList from './BudgetList'
import Middle from './Middle'


@Component
export default struct HistoricalBilling {
  @Provide selectedType: string = ''; // 中央管理状态
  @Consume @Watch('aboutToAppear') currentIndex:number
  @Provide bills:Bill[] = []
  // @Provide newMonth:string=''
  @Provide sumIncome:number = 0
  @Provide sumExpenditure:number = 0
  @Provide counter:number = 0
  // scanSelectedType(){
  //   console.log('testTag','HistoricalBilling','selectedType',this.selectedType)
  // }
  aboutToAppear(){
    this.getBills()
    this.filterData()
    console.log('testTag','HistorB','currentIndex',this.currentIndex)
  }
  setSelectedType(){
    this.selectedType = '全部账单'
  }
  // 获取到所有的bill数据方法
  async getBills(){
    this.bills = await BillService.list()
  }

  //过滤方法
  filterData():Bill[] {
    let res = true
    console.log('testTag', 'BudgetList', 'bills', this.bills)
    return this.bills.filter((item: Bill) => {
      if (this.selectedType == '收入') {
        res = !item.isExpend
      }
      if (this.selectedType == '支出') {
        res = item.isExpend
      }
      console.log('testTag', 'BudgetList', 'res', res)
      return res
    });
  }


  build() {
    Column({space:15}){
      //1.头部
      //Header()
      //中间
      Middle()
      // Middle({ selectedType: this.selectedType })
      // 3.记录列表
      BudgetList({filterData:this.filterData.bind(this)})
      // BudgetList({ selectedType: this.selectedType })
    }
    .width('100%')
    .height('100%')
  }
}

