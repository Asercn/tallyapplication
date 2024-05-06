import BillTypeService from '../../services/BillTypeService'
import BillModel from '../../model/BillModel'
import BillTypeModel from '../../model/BillTypeModel'
import BillType from '../../viewmodel/BillType'

@Component
export default struct addBillTypePanel {
  @Link isPanelShow:boolean
  @State billTypeName:string = ''
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

      Row({space:20}){
        Button('添加')
          .backgroundColor($r('app.color.contrast_primary_color'))
          .onClick(async (event: ClickEvent) => {
          if (this.billTypeName == '' || this.billTypeName == null){
            this.billTypeName = '其它'
          }
          // 新增分组
          BillTypeService.insert(this.billTypeName,this.budget).then(()=>{
            this.isPanelShow = false
            this.billTypeName = ''
            this.budget = 0
          })
        })
        Button('取消')
          .backgroundColor($r('app.color.contrast_primary_color'))
          .onClick((event: ClickEvent) => {
          this.billTypeName = ''
          this.budget = 0
          // 取消新增
          this.isPanelShow = false
        })
      }
    }
    .padding(10)
  }
}