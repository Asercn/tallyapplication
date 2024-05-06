import BillService from '../../services/BillService'
import router from '@ohos.router'
import { BillTypeEnum } from '../../model/BillTypeModels'

@Entry
@Component
export default struct addBillPanel {


  groupId:number
  @State label:string = ''
  @State date:Date = new Date()
  @State isExpend:boolean = true
  @State amount:number = 0
  @State typeId:BillTypeEnum = BillTypeEnum.TRAVEL


  aboutToAppear(){
    this.groupId = router.getParams()['groupId']
    console.log('testTag','addBillPanel','groupId',this.groupId)
  }

  build() {
    Column({space:20}){
      Text('记一账')
      TextInput({text:this.label,placeholder:'名称'})
        .onChange(value=>this.label=value)
      TextInput({text:`${this.amount}`,placeholder:'金额'})
        .type(InputType.Number)
        .onChange((text)=>{
          let value = parseFloat(text)
          if (isNaN(value)) {
            value = 0
          }
          this.amount = value
          console.log('testTag','addBillTypePanel','amount',this.amount)
        })
      //类型展示
      Row({space:10}){
        Text('消费类型')
          .fontSize(20)

        /**
         * 选择定义的枚举常量，下标与枚举常量值对应
         */
        Select([
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
          { value: $r('app.string.app_name'), icon:  $r('app.media.year') },
        ])
          .selected(6) //默认选择的下标
          .value('请选择')
          .font({ size: 20, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 20, weight: 400 })
          .optionFont({ size: 20, weight: 400 })
          .onSelect((index: number,value?:string) => {
            let i = index
            console.info('Select:' + index)
            this.typeId = i
          })
      }

      Row({space:20}){
        Row(){
          Text('支出')
          Radio({value:'true',group:'isExpend'})
            .checked(true)
            .onChange(isChecked=>{
              this.isExpend = isChecked
            })
        }
        Row(){
          Text('收入')
          Radio({value:'false',group:'isExpend'})
            .onChange(isChecked=>{
              this.isExpend = !isChecked
            })

        }
      }

      Row({space:20 }){
        Button('提交')
          .backgroundColor($r('app.color.contrast_primary_color'))
          .onClick((event: ClickEvent) => {
            console.log('testTag','addBillPanel','type',this.typeId)
            // 新增账单bill
            BillService.insert(this.label,this.amount,this.date,this.isExpend,this.groupId,this.typeId).then((rep)=>{
              router.back()
              this.label = ''
              this.amount = 0
              this.date = new Date()
              this.isExpend = true
              console.log('testTag','addBillPanel','rep',JSON.stringify(rep))

            })
          })
        Button('取消')
          .backgroundColor($r('app.color.contrast_primary_color'))
          .onClick((event: ClickEvent) => {
            // 取消新增
            router.back()
          })
      }
    }
    .padding(10)
  }
}