import router from '@ohos.router'
import BillService from '../../common/services/BillService'
import Bill from '../../viewmodel/Bill'
import BudgetList from './BudgetList'
import Header from './Header'
import Middle from './Middle'


@Component
export default struct HistoricalBilling {
  @Provide selectedType: string = ''; // 中央管理状态
  @Prop @Watch('aboutToAppear') currentIndex:number
  @Provide bills:Bill[] = []
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
      BudgetList({filterData:this.filterData})
      // BudgetList({ selectedType: this.selectedType })
    }
    .width('100%')
    .height('100%')
  }
}

