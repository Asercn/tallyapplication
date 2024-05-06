import BillService from '../services/BillService';
import homeIndex from '../view/home/homeIndex';
import ItemBudget from '../view/item/ItemBudget';
import ItemBudgetAndIncome from '../view/item/ItemBudgetAndIncome';
import ItemChart from '../view/item/ItemChart';
import ItemConsumeType from '../view/item/ItemConsumeType';
import ItemList from '../view/item/ItemList';
import ItemShow from '../view/item/ItemShow';
import NumberKeyboard from '../view/item/NumberKeyboard';
import Bill from '../viewmodel/Bill';
import ItemIndex from './ItemIndex';

@Entry
@Component
struct Index {
  @State currentIndex:number = 0
  title:string = '首页'
  titleFont:number = 30
  @Provide Refresh:boolean = false


  @State showPanel:boolean = false
  //收入支出类型选择
  @State isIncome:boolean = true

  @State amount:number = 0
  @State value:string = ''

  @State restTodayBudget:number = 0
  //定义状态变量消费描述
  @State label:string = 'a'
  @State type:string = '' //消费类型

  @State inCome:number = 0 //本月收入
  @State expenditure:number = 0 //本月支出
  // @Provide budget:number = 0 //本月预算

  //接收今日消费页面数据的数据的数组
  @State todayBillArr:Bill[] = []
  @State billArr:Bill[] = []

  //页面加载时获取数据
  async aboutToAppear(){
    this.todayBillArr = await BillService.getBill() //获取当日的账单数据
    let date = new Date()
    //获取本月所有消费数据
    this.billArr = await BillService.listByDateBetween(new Date(date.getFullYear(), date.getMonth(), 1),
      new Date(date.getFullYear(),date.getMonth()+1, 0))

    // Prompt.showToast({message:this.label+':'+this.amount+':'+this.isIncome})
  }

  onPageShow(){
    this.Refresh = true
  }
  onPageHide(){
    this.Refresh = false
  }
  build() {
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        Column() {
          // 头部
          this.header({title:this.title})
          // 首页
          homeIndex()
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.TabBuilder('首页',0,$r('app.media.home_select'),$r('app.media.home')))

      TabContent(){
        ItemIndex()
      }
      .tabBar(this.TabBuilder('财务管理页面',1,$r('app.media.historicalBill_select'),$r('app.media.historicalBill')))


      TabContent(){
        // 账单记录页面
        Text('历史账单页面，正在施工中')
      }
      .tabBar(this.TabBuilder('账单记录',1,$r('app.media.historicalBill_select'),$r('app.media.historicalBill')))
    }
    .animationDuration(100)
    .scrollable(false)
    .onChange((index:number)=>{
      this.currentIndex = index
    })

  }


  // 自定义tabBar
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Row(){
      Column() {
        Stack(){
          Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
            .size({ width: 25, height: 25 })
            .offset({y:2})
            .blur(2)
            .colorFilter([
              .5,0,0,0,0,
              0,.5,0,0,0,
              0,0,.5,0,0,
              1,1,1,1,0
            ])
          Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
            .size({ width: 25, height: 25 })
        }
        Stack(){
          Text(title)
            .fontColor(Color.Gray)
            .offset({y:2})
          Text(title)
            .fontColor(this.currentIndex === targetIndex ? $r('app.color.light_primary_color') : Color.White)
        }
      }
      .backgroundColor($r('app.color.primary_color'))
      .width('100%')

      .border({color:{top:Color.Gray},width:{top:1}})
      .height('90%')
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(VerticalAlign.Bottom)
    .border({color:{top:Color.Gray},width:{top:1}})
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.dark_primary_color'))
  }


  // 首页头部
  @Builder header($$:{title:string}){
    Row(){
      Row().layoutWeight(1)
      Stack(){
        Text($$.title)
          .offset({y:2})
          .fontColor(Color.Gray)
          .fontSize(this.titleFont)
        Text($$.title)
          .fontColor(Color.White)
          .fontSize(this.titleFont)
      }
      .layoutWeight(1)

      // 设置按钮
      Row(){
        Button(){
          Stack(){
            Image($r('app.media.setting_primary')).width(30).offset({y:3})
              .renderMode(ImageRenderMode.Template)
              .colorFilter([
                .5,0,0,0,0,
                0,.5,0,0,0,
                0,0,.5,0,0,
                1,1,1,1,0
              ])
              .blur(5)
            // .opacity(.5)

            Image($r('app.media.setting_primary')).width(30)

          }
        }
        .backgroundColor(Color.Transparent)
        .onClick((event: ClickEvent) => {
          // 打开设计面板或者页面

        })
      }
      .justifyContent(FlexAlign.End)
      .layoutWeight(1)

    }
    .padding(10)
    .shadow({radius:5,offsetY:2})
    .width('100%')
    .height(50)
    .backgroundColor($r('app.color.primary_color'))
  }

}

