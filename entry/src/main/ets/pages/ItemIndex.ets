import ItemBudget from '../view/item/ItemBudget'
import ItemBudgetAndIncome from '../view/item/ItemBudgetAndIncome'
import ItemChart from '../view/item/ItemChart'
import ItemConsumeType from '../view/item/ItemConsumeType'
import ItemList from '../view/item/ItemList'
import ItemShow from '../view/item/ItemShow'
import NumberKeyboard from '../view/item/NumberKeyboard'

@Entry
@Component
struct ItemIndex {
  @State showPanel:boolean = false
  //收入支出类型选择
  @State isIncome:boolean = true

  @State amount:number = 0
  @State value:string = ''

  build() {
    Stack(){
      Column({space:10}){
        //1.返回按钮展示
        this.Header()

        //2.顶部剩余预算展示
        ItemShow()

        //3.图表、账单、预算入口按钮
        ItemChart()

        //4.展示本月所有收入和支出
        ItemBudget()

        //5.本月消费记录列表
        ItemList()
          .layoutWeight(1)

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#fff1f1f1')

      //记录面板
      Panel(this.showPanel){//展示
        //1.消费描述
        this.consumeDescribe()

        //2.金额及类型
        ItemConsumeType({amount:this.amount})

        //3.选择收入还是支出类型
        ItemBudgetAndIncome()

        //4.输入面板
        NumberKeyboard({amount:$amount,value:$value})

        //5.按钮
        this.PanelButton()


      }
      .mode(PanelMode.Full)
      .dragBar(true)
      .backgroundMask('#b5b5b7')
      .backgroundColor(Color.White)

      Image($r('app.media.ic_public_add_norm_filled'))
        .fillColor($r('app.color.primary_color'))
        .width(70)
        .position({x:260,y:700})
        .onClick(()=>{
          //点击后跳转
          this.showPanel = true
        })
    }

  }

  @Builder consumeDescribe(){
    Row(){
      Text('消费描述:')
        .fontSize(20)
      TextInput({placeholder:'消费描述'})
        .maxLength(20)
        .type(InputType.Normal)
        .width(250)
    }
  }

  @Builder PanelButton(){
    Row({space:10}){
      Button('取消')
        .backgroundColor(Color.Gray)
        .onClick(()=>{
          this.showPanel = false
        })
      Button('确认')
        .onClick(()=>{
          this.showPanel = false
        })
    }
    .width('100%')
    .margin(20)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder Header(){
    Row(){
      Image($r('app.media.ic_public_back'))
        .width(20)

      Blank()

      Text('财务管理页面')
      // .layoutWeight(1)
    }
    .width('90%')
    .margin(5)
  }
}