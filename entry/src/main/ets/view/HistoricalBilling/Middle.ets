import DateUtil from '../../common/utils/DateUtil';
import BillService from '../../services/BillService';
import Bill from '../../viewmodel/Bill';


@Component
export default struct Middle {
  @Consume selectedType: string; // 用于存储选择的类别
  @Consume bills:Bill[]
  @Consume @Watch('aboutToAppear') counter:number
  @Consume sumIncome: number
  @Consume sumExpenditure: number

  @Consume newMonth: string
  @State Date:number = 0

  aboutToAppear(){
    this.Date = AppStorage.Get('selectedDate')
  }


  // 处理所选日期的函数
  handleDateSelected(selectedDate: Date) {
    this.newMonth = selectedDate.toDateString(); // 转换为需要的格式
    console.log('Middle', 'newMonth', this.newMonth)
    // 其他逻辑处理
  }

  build() {
    Column({ space: 15 }) {
      // 上半部分
      Row() {

        // 单选框
        Row() {
          Column() {
            Radio({ value: '全部账单', group: '账单' })
              .checked(true)
              .onChange((flag) => {
                if (flag) {
                  this.selectedType = '全部账单'
                }
              })
            Text('全部账单').fontSize(10).fontWeight(FontWeight.Bold)
          }

          Column() {
            Radio({ value: '收入', group: '账单' })
              .onChange((flag) => {
                if (flag) {
                  this.selectedType = '收入'
                }
              })
            Text('收入').fontSize(10).fontWeight(FontWeight.Bold)
          }

          Column() {
            Radio({ value: '支出', group: '账单' })
              .onChange((flag) => {
                if (flag) {
                  this.selectedType = '支出'
                }
              })
            Text('支出').fontSize(10).fontWeight(FontWeight.Bold)
          }
        }
        // 统计 暂无功能
        Row() {
          Text('统计')
          Image($r('app.media.ic_public_arrow_down_0')).width(19)
        }

      }.justifyContent(FlexAlign.SpaceAround).width('100%')

      Divider().color(Color.Gray)

      // 下半部分
      Row() {
        // 时间
        Button(DateUtil.formatDate(this.Date))
          .onClick(() => {
            DatePickerDialog.show({
              selected:AppStorage.Get('selectedDate'),
              onAccept:(value)=>{
                let y = value.year
                let m = value.month+1
                let d = value.day
                let date = new Date(`${y}-${m}-${d}`)
                AppStorage.SetOrCreate('selectedDate',new Date(date))
                this.counter++
              }
            })
          })

        Row() {
          Text(`支出￥${this.sumExpenditure}`).fontSize(12).fontWeight(FontWeight.Bold)
        }

        Row() {
          Text(`收入￥${this.sumIncome}`).fontSize(12).fontWeight(FontWeight.Bold)
        }
      }.justifyContent(FlexAlign.SpaceAround).width('100%')

    }
    .width('100%')
    .borderRadius(15)
    .shadow({ radius: 15, color: Color.Gray })
    .padding(10)
    .margin({top:10})

  }
}

