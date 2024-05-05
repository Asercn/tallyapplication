import BillService from '../../common/services/BillService'
import router from '@ohos.router'

@Entry
@Component
export default struct addBillPanel {


  groupId:number
  @State label:string = ''
  @State date:Date = new Date()
  @State isExpend:boolean = true
  @State amount:number = 0


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

      Button('submit').onClick((event: ClickEvent) => {
        console.log('testTag','addBillPanel','isExpend',this.isExpend)
        // 新增账单bill
        BillService.insert(this.label,this.amount,this.date,this.isExpend,this.groupId).then((rep)=>{
          router.back()
          this.label = ''
          this.amount = 0
          this.date = new Date()
          this.isExpend = true
          console.log('testTag','addBillPanel','rep',JSON.stringify(rep))

        })
      })
      Button('cancel').onClick((event: ClickEvent) => {
        // 取消新增
        router.back()
      })
    }
    .padding(10)
  }
}