import BillTypeService from '../../common/services/BillTypeService'
import BillModel from '../../model/BillModel'
import BillTypeModel from '../../model/BillTypeModel'
import BillType from '../../viewmodel/BillType'

@Component
export default struct addBillTypePanel {
  @Link isPanelShow:boolean
  @State billTypeName:string = '其它'
  @State budget:number = 0
  build() {
    Column({space:20}){
      Text('新建分组')
      TextInput({text:this.billTypeName,placeholder:'分组名'})
        .onChange(value=>this.billTypeName=value)
      TextInput({text:`${this.budget}`,placeholder:'分组预算'})
        .type(InputType.Number)
        .onChange((text)=>{
          let value = parseFloat(text)
          if (isNaN(value)) {
            value = 0
          }
          this.budget = value
          console.log('testTag','addBillTypePanel','budget',this.budget)
        })

      Button('submit').onClick(async (event: ClickEvent) => {

        // 新增分组
        BillTypeService.insert(this.billTypeName,this.budget).then(()=>{
          this.isPanelShow = false
          this.billTypeName = '其它'
          this.budget = 0
        })
      })
      Button('cancel').onClick((event: ClickEvent) => {
        this.billTypeName = '其它'
        this.budget = 0
        // 取消新增
        this.isPanelShow = false
      })
    }
    .padding(10)
  }
}