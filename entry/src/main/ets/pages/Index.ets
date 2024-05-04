import colorUtil from '../common/utils/ColorUtil';
import DateUtil from '../common/utils/DateUtil';
import allBillCard from '../view/home/AllBillCard';
import homeIndex from '../view/home/homeIndex';
import IECard from '../view/home/IECard';
import Bill from '../viewmodel/Bill';
import BillType from '../viewmodel/BillType';

@Entry
@Component
struct Index {
  @State currentIndex:number = 0
  @State items:any = [1,2,3]

  @Provide total:number = 1300
  @Provide sumValue:number = 0
  @Provide income:number = 0
  @Provide values:BillType[] = [
    new BillType('组1',800,1200),
    new BillType('组2',130,200),
    new BillType('组3',200,180),
    new BillType('组4',101,200),
    new BillType('组5',21,100),
    new BillType('组6',81,80),
    new BillType('组7',51,100),

  ]



  // 获取今日的总消费和总预算
  getSum(){
    this.values.forEach(billtype=>{
      this.sumValue += billtype.sumValue
      this.total += billtype.budget
    })
    console.log('testTag','Index','total',this.total)
  }

  // 将数据从小到大排序展示
  initValue(){
    this.values = this.values.sort((a,b)=>b.sumValue-a.sumValue)
  }
  aboutToAppear(){
    console.log('testTag','Index',DateUtil.getWeek(new Date()))
    this.initValue()
    this.getSum()
  }

  build() {
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        Column() {
          // 首页
          homeIndex()
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.TabBuilder('首页',0,$r('app.media.home_select'),$r('app.media.home')))
      TabContent(){
        // 账单记录页面
        Text('历史账单页面，正在施工中')
      }
      .tabBar(this.TabBuilder('账单记录',1,$r('app.media.historicalBill_select'),$r('app.media.historicalBill')))
    }
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

}
