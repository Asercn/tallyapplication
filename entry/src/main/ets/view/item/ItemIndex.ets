import BillService from '../../services/BillService'
import ItemBudget from './ItemBudget'
import ItemBudgetAndIncome from './ItemBudgetAndIncome'
import ItemChart from './ItemChart'
import ItemConsumeType from './ItemConsumeType'
import ItemList from './ItemList'
import ItemShow from './ItemShow'
import NumberKeyboard from './NumberKeyboard'
import Bill from '../../viewmodel/Bill'
import Prompt from '@system.prompt'
import DateUtil from '../../common/utils/DateUtil'

// import { Calendar } from '@ohos.util.';


@Component
export default struct ItemIndex {
  @State @Watch('aboutToAppear') showPanel:boolean = false
  //收入支出类型选择
  @State isIncome:boolean = false

  @State amount:number = 0
  @State value:string = ''

  @State restTodayBudget:number = 0
  //定义状态变量消费描述
  @State label:string = ''
  @State typeId:number = 6 //消费类型

  @State inCome:number = 0 //本月收入
  @State expenditure:number = 0 //本月支出
  @Provide budget:number = 0 //本月预算

  @Consume @Watch('aboutToAppear') currentIndex:number
  @Provide @Watch('aboutToAppear') count:number = 0
  // @StorageLink('historical') @Watch('aboutToAppear') count:number = 0

  //接收今日消费页面数据的数据的数组
  @State todayBillArr:Bill[] = [] //当日的消费数据
  @State billArr:Bill[] = []  //本月的消费数据

  @State taskId:number = setTimeout(this.handleBillArr,1000)//标识定时计数器


  async aboutToAppear(){
    this.todayBillArr = await BillService.getBill() //获取当日的账单数据
    //获取当天时间
    let date = new Date()
    //1.获取本月所有消费数据
    this.billArr = await BillService.listByDateBetween(new Date(
      date.getFullYear(), date.getMonth(), 1),
      new Date(date.getFullYear(),date.getMonth()+1, 1))

    this.handleBillArr() //更新每日剩余预算


    console.log('testTag','ItemIndex','restTodayBudget',this.restTodayBudget.toString())
    // Prompt.showToast({message:this.label+':'+this.amount+':'+this.isIncome})
    console.log('testTag','ItemIndex','billArr',JSON.stringify(this.billArr))
  }

  //处理数据
  async handleBillArr(){
    //获取当天时间
    let date = new Date()
    //1.获取本月所有消费数据
    this.billArr = await BillService.listByDateBetween(new Date(
      date.getFullYear(), date.getMonth(), 1),
      new Date(date.getFullYear(),date.getMonth()+1, 1))

    //归零数据
    this.expenditure = 0
    this.inCome = 0

    //2.遍历处理本月所有数据
    this.billArr.forEach((item:Bill)=>{
      if (item.isExpend) {
        this.expenditure += item.amount
      }else {
        this.inCome += item.amount
      }
    })

    //计算今日到月末的天数
    let days = DateUtil.getRestDayOfMonth(date)
    //获取每日的预算
    if (this.budget > this.expenditure) {
      this.restTodayBudget = (this.budget-this.expenditure)/days
    }else {
      this.restTodayBudget = 0
    }
  }

  build() {
    Stack(){
      Column({space:10}){
        //1.返回按钮展示
        // this.Header()

        //2.顶部剩余预算展示
        ItemShow({restTodayBudget:this.restTodayBudget})

        //3.图表、账单、预算入口按钮
        ItemChart()

        //4.展示本月所有收入和支出
        ItemBudget({inCome:this.inCome,expenditure:this.expenditure,budget:this.budget})

        //5.本月消费记录列表
        ItemList({billArr:this.billArr})
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
        ItemConsumeType({amount:this.amount,typeId:this.typeId})

        //3.选择收入还是支出类型
        ItemBudgetAndIncome({isIncome:this.isIncome})

        //4.输入面板
        NumberKeyboard({amount:this.amount,value:this.value})

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
        .position({x:260,y:650})
        .onClick(()=>{
          //点击后跳转
          this.showPanel = true
        })
    }

  }


  //处理面板消费描述输入的信息的方法
  @Builder consumeDescribe(){
    Row(){
      Text('消费描述:')
        .fontSize(20)
      TextInput({placeholder:'消费描述'})
        .maxLength(20)
        .type(InputType.Normal)
        .width(250)
        .onChange(value=>{
          this.label=value
        })
    }
  }

  //提交和取消面板显示的按钮方法
  @Builder PanelButton(){
    Row({space:10}){
      Button('取消')
        .backgroundColor(Color.Gray)
        .onClick(()=>{
          this.showPanel = false
          this.count++
        })
      Button('确认')
        .onClick(()=>{
            BillService.insert(this.label,this.amount,new Date(),this.isIncome,0,this.typeId).then(rep=>{
            this.showPanel = false
              this.count++
          })
          // this.handleBillArr() //处理数据库更新的新数据
          this.taskId++
        })
    }
    .width('100%')
    .margin(20)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  //头部显示
  @Builder Header(){
    Row(){
      Image($r('app.media.ic_public_back'))
        .width(20)

      Blank()

      Text('财务管理页面')

    }
    .width('90%')
    .margin(5)
  }
}