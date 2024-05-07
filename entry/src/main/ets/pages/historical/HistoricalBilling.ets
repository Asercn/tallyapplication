import BillService from '../../services/BillService'
import Bill from '../../viewmodel/Bill'
import BudgetList from '../../view/HistoricalBilling/BudgetList'
import Middle from '../../view/HistoricalBilling/Middle'
import router from '@ohos.router'


@Entry
@Component
export default struct HistoricalBilling {
  @Provide selectedType: string = ''; // 中央管理状态
  // @Consume @Watch('aboutToAppear') currentIndex:number
  @Provide bills:Bill[] = []
  @Provide newMonth:string=''
  @Provide sumIncome:number = 0
  @Provide sumExpenditure:number = 0
  @Provide counter:number = 0


  // @Consume @Watch('aboutToAppear') count:number
  // @StorageLink('historical') @Watch('aboutToAppear') count:number = 0

  // scanSelectedType(){
  //   console.log('testTag','HistoricalBilling','selectedType',this.selectedType)
  // }
  aboutToAppear(){

    this.getBills()
    this.filterData()
    console.log('testTag','HistorB','currentIndex')
    // console.log('testTag','HistorB','currentIndex',this.currentIndex)
  }
  setSelectedType(){
    this.selectedType = '全部账单'
  }
  // 获取到所有的bill数据方法
  async getBills(){
    this.bills = await BillService.list()
  }

  filterData(): Bill[] {
    // 转换 newMonth 为 Date 对象
    let selectedDate: Date | null = null;
    if (this.newMonth) {
      selectedDate = new Date(this.newMonth);
    }

    return this.bills.filter((item: Bill) => {
      if (selectedDate) {
        const itemDate = new Date(item.date); // 假设 Bill 有日期字段

        // 比较日期，确保年份、月份、日都相同
        const sameDate = (
          itemDate.getFullYear() === selectedDate.getFullYear() &&
            itemDate.getMonth() === selectedDate.getMonth() &&
            itemDate.getDate() === selectedDate.getDate()
        );

        if (!sameDate) {
          return false; // 如果日期不匹配，过滤掉
        }
      }

      // 根据收入/支出类型筛选
      if (this.selectedType === '收入') {
        return !item.isExpend; // 只保留收入
      } else if (this.selectedType === '支出') {
        return item.isExpend; // 只保留支出
      }

      return true; // 如果未指定类型，返回所有符合日期的账单
    });
  }


  build() {
    Column({space:15}){
      //1.头部
      this.Header()
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

  //头部显示
  @Builder Header(){
    Row(){
      Image($r('app.media.ic_public_back'))
        .width(20)
        .onClick(()=>{
          router.back()
        })

      Blank()

      Text('历史账单')

    }
    .width('90%')
    .margin(5)
  }
}