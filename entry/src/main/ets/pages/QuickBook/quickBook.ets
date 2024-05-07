import {BillTypeImages, BillTypeNames} from '../../model/BillTypeModels'


@Entry
@Component
struct QuickBook {
  @State amount:number = 0
  @State label:string = ''
  @State isExpend:boolean = true



  build() {
    Column({space:20}){
      Row(){
        Text('快速记账')
          .fontSize(22)
      }

      Row(){
        Text('账单描述')
          .width('20%')
          .textAlign(TextAlign.End)
        TextInput({placeholder:'账单描述'})
      }
      Row(){
        Text('金额')
          .width('20%')
          .textAlign(TextAlign.End)
        TextInput({placeholder:'金额'})
      }
      // 单选框
      Row({space:20}){
        Row(){
          Text('支出')
          Radio({value:`支出`,group:'type'})
            .checked(true)
            .onChange((isCheck)=>{
              this.isExpend = true
            })
        }
        Row(){
          Text('收入')
          Radio({value:`收入`,group:'type'})
            .checked(false)
            .onChange((isCheck)=>{
              this.isExpend = false
            })
        }
      }

      // 类型选择
      Row(){
        Select([
          {value:BillTypeNames[0],icon:BillTypeImages[0]}
        ])
      }

    }
    .padding(10)
    .width('100%')
    .height('100%')
  }
}