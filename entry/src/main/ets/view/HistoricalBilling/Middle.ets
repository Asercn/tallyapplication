import DateUtil from '../../common/utils/DateUtil';
import DatePickerDialog from './DatePickerDialog'

@Component
export default struct Middle{
  @Consume selectedType:string ; // 用于存储选择的类别
  @Consume sumIncome:number
  @Consume sumExpenditure:number
  @Consume  counter:number
  // @Consume newMonthL:string

  @StorageProp('selectedDate') selectedDate:number = DateUtil.beginTimeOfDay(new Date())
  controller:CustomDialogController = new CustomDialogController({
    builder:DatePickerDialog({
      selectedDate:new Date(this.selectedDate)
    })  // 数据回显
  })



  build(){
    Column({space:15}){
      Row(){
        Row(){
          Column(){
            Radio({value:'全部账单',group:'账单'})
              .checked(false)
              .onChange((flag) => {
                this.counter++
                if (flag) {
                  this.selectedType = '全部账单'
                  console.log('a','Middle',this.selectedType)
                  // 点击按钮 触发方法
                  // 使用计数器，当数值发生改变的时候，触发方法
                }
              })
            Text('全部账单').fontSize(10).fontWeight(FontWeight.Bold)
          }
          Column(){
            Radio({value:'收入',group:'账单'})
              .onChange((flag) => {
                if (flag) {
                  this.selectedType = '收入'
                  console.log('b','Middle',this.selectedType)
                }
              })
            Text('收入').fontSize(10).fontWeight(FontWeight.Bold)
          }
          Column(){
            Radio({value:'支出',group:'账单'})
              .onChange((flag) => {
                if (flag) {
                  this.selectedType = '支出'
                  console.log('c','Middle',this.selectedType)
                }
              })
            Text('支出').fontSize(10).fontWeight(FontWeight.Bold)
          }
        }
        Row(){
          Text('统计')
          Image($r('app.media.ic_public_arrow_down_0')).width(19)
        }
      }.justifyContent(FlexAlign.SpaceAround).width('100%')
      Row(){
        Text(DateUtil.formatDate(this.selectedDate))
          .onClick(()=>this.controller.open())
        Row(){
          Text(`支出￥${this.sumExpenditure}`).fontSize(10).fontWeight(FontWeight.Bold)
        }
        Row(){
          Text(`收入￥${this.sumIncome}`).fontSize(10).fontWeight(FontWeight.Bold)
        }
      }.justifyContent(FlexAlign.SpaceAround).width('98%')
    }.width('98%').backgroundColor('#CFCFCF')
  }
}
