import BudgetList from './BudgetList'
import Header from './Header'
import Middle from './Middle'


@Component
export default struct HistoricalBilling {
  @Provide selectedType: string = '全部账单'; // 中央管理状态
  // scanSelectedType(){
  //   console.log('testTag','HistoricalBilling','selectedType',this.selectedType)
  // }


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
    .width('100%')
    .height('100%')
  }
}

