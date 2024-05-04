import BillService from '../../common/services/BillService'

@Component
export default struct addBillPanel {
  @Consume billPanel:boolean
  @Prop groupId:number

  @State label:string = ''
  @State date:Date = new Date()
  @State isExpend:boolean = true
  @State amount:number = 0

  build() {
    Column({space:20}){
      Text('记一账')
      TextInput({text:this.label,placeholder:'名称'})
        .onChange(value=>this.label=value)
      TextInput({text:`${this.amount}`,placeholder:'金额'})
        .type(InputType.Number)
        .onChange(value=>{
          if (this.amount <= 0) {
            this.amount = 0
          }
          this.amount = parseFloat(value)
          console.log('testTag','addBillPanel','amount',this.amount)
        })
      Row(){
        Row(){
          Text('支出')
          Radio({value:'true',group:'isExpend'})
            .checked(this.isExpend)
            .onChange((isCheck:boolean)=>{
              this.isExpend = isCheck
            })
        }
        Row(){
          Text('收入')
          Radio({value:'false',group:'isExpend'})
            .checked(this.isExpend)
            .onChange((isCheck:boolean)=>{
              this.isExpend = !isCheck
            })
        }
      }

      Button('submit').onClick(async (event: ClickEvent) => {

        // 新增账单bill
        BillService.insert(this.label,this.amount,this.date,this.isExpend,this.groupId).then(()=>{
          this.billPanel = false
          this.label = ''
          this.amount = 0
          this.date = new Date()
          this.isExpend = true
        })
      })
      Button('cancel').onClick((event: ClickEvent) => {
        // 取消新增
        this.billPanel = false
      })
    }
    .padding(10)
  }
}