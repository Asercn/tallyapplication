import Prompt from '@system.prompt'

@Component
export default struct ItemBudgetAndIncome {

  @Link isIncome:boolean

  build() {
    Row(){
      Column({space:5}){
        Radio({value:'收入',group:'radioGroup'})
          .checked(true)
          .height(30)
          .width(30)
          .onChange((text:boolean)=>{
            //选择类型
            this.isIncome = false
            Prompt.showToast({
              message:this.isIncome.toString()+'收入',
            })
          })
        Text('收入')
      }
      Blank()
      Column({space:5}){
        Radio({value:'支出',group:'radioGroup'})
          .checked(false)
          .height(30)
          .width(30)
          .onChange((value:boolean)=>{
            //选择类型
            this.isIncome = true
            Prompt.showToast({
              message:this.isIncome.toString()+'支出',
            })
          })
        Text('支出')
      }
    }
    .width(200)
    .height(50)

  }
}