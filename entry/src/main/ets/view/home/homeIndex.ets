
import colorUtil from '../../common/utils/ColorUtil'
import DateUtil from '../../common/utils/DateUtil'
import Bill from '../../viewmodel/Bill'
import BillType from '../../viewmodel/BillType'
import GroupInfo from '../../viewmodel/GroupInfo'
import addBillPanel from '../../pages/home/addBillPanel'
import addBillTypePanel from './addBillTypePanel'
import allBillCard from './AllBillCard'
import detailsBillCard from './detailsBillCard'
import IECard from './IECard'
import BillTypeService from '../../services/BillTypeService'
import BillService from '../../services/BillService'

@Component
export default struct homeIndex {
  @Consume @Watch('aboutToAppear') Refresh:boolean

  @State @Watch('aboutToAppear') isPanelShow:boolean = false

  @Provide groupId:number = 0


  @Provide total:number = 0
  @Provide sumValue:number = 0
  @Provide income:number = 0
  @Provide values:GroupInfo<BillType,Bill>[] = []

  refresh(){
    this.Refresh = !this.Refresh
  }

  aboutToAppear(){
    console.log('testTag','homeIndex',DateUtil.getWeek(new Date()))
    this.getValues().then(rep=>{
      this.getSum()
      this.sortValue()
    })
  }

  async removeValues(id:number){
    let l = this.values.length
    let index:number[] = []
    // 找到当中类型的id等于此id
    for(let i = 0; i < l;i++){
      if (this.values[i].type.id == id) {
        index.push(i)
      }
    }
    await index.forEach(i=>{
      this.values.splice(i,1)
    })


  }

  // 获取所有的总消费和总预算和收入
  async getSum(){
    this.sumValue = await BillTypeService.getSumValue()
    this.total = await BillTypeService.getBudget()
    this.income = await BillService.getIncome()
    console.log('testTag','Index','total',this.total)
  }


  // 将数据从小到大排序展示
  sortValue(){
    this.values = this.values.sort((a,b)=>b.type.sumValue-a.type.sumValue)
  }


  // 获取数据
  async getValues(){
    let bills:Bill[] = await BillService.getAllBill()
    let billtypes:BillType[] = await BillTypeService.getBillType()
    this.values = BillService.getBillGroup(bills,billtypes)
    console.log('testTag','Index','billtypes',JSON.stringify(billtypes))
    // console.log('testTag','Index','billPanel',JSON.stringify(this.billPanel))
    console.log('testTag','Index','groupId',JSON.stringify(this.groupId))
    console.log('testTag','Index','bills',JSON.stringify(bills))
  }

  build() {
    Column() {
      // 主要内容
      this.main()
      // 消费类型分组
      Panel(this.isPanelShow){
        addBillTypePanel({isPanelShow:this.isPanelShow})
      }
      .position({})
      .dragBar(false)
      .type(PanelType.Temporary)
      // .backgroundColor('red')



    }
    .width('100%')
    .height('100%')
  }




  // 首页中间部分
  @Builder main(){
    Stack(){
      // 固定定位按钮
      Row(){
        Button(){
          Text('+')
            .layoutWeight(1)
            .fontSize(30)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
        }
          .type(ButtonType.Circle)
          .width(70)
          .backgroundColor($r('app.color.contrast_primary_color'))
          .onClick(()=>{
            this.isPanelShow = true
          })
      }
      .position({x:'100%',y:'50%'})
      .translate({x:'-100%'})
      .opacity(.5)
      // .backgroundColor('red')
      .zIndex(1000)

      Scroll(){
        Column(){
          // 封装后的卡片
          IECard()
          // 账单总图
          allBillCard()
          // 今日详情消费
          detailsBillCard({groupId:this.groupId,removeValues:this.removeValues.bind(this),refresh:this.refresh.bind(this)})

        }
        .align(Alignment.Top)
        .width('100%')
        // .backgroundColor('green')


      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      // .backgroundColor('red')
      .padding(10)
      .margin({bottom:50})
      .layoutWeight(1)
    }
  }
  // // 首页页脚 已经不用了
  // @Builder footer(){
  //   Row(){
  //     Row({space:20}){
  //       Button('历史账单')
  //         .buttonStyle()
  //         .onClick((event: ClickEvent) => {
  //
  //         })
  //       Button('记一账')
  //         .buttonStyle()
  //         .onClick((event: ClickEvent) => {
  //
  //         })
  //       Button('更多')
  //         .buttonStyle()
  //         .onClick((event: ClickEvent) => {
  //
  //         })
  //
  //     }
  //     .justifyContent(FlexAlign.SpaceEvenly)
  //     .backgroundColor($r('app.color.primary_color'))
  //     .width('100%')
  //     .height(80)
  //     .shadow({radius:20})
  //   }
  //   .width('100%')
  //   .height(100)
  //   .backgroundColor($r('app.color.dark_primary_color'))
  //   .alignItems(VerticalAlign.Bottom)
  //   .shadow({radius:15})
  // }


}

@Extend(Button)function buttonStyle(){
  .backgroundColor($r('app.color.light_primary_color'))
  .borderRadius('50%')
  .width(70)
  .height(70)
  .shadow({radius:10,color:'#4f4f4f'})
  .offset({y:-15})
}