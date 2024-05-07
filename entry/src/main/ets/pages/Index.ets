import router from '@ohos.router';
import HistoricalBilling from '../view/HistoricalBilling/HistoricalBilling';
import homeIndex from '../view/home/homeIndex';
import ItemIndex from './ItemIndex';

@Entry
@Component
struct Index {
  @Provide currentIndex:number = 0

  titleFont:number = 30
  @Provide Refresh:boolean = false
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
          this.header({title:'首页'})
          // 首页
          homeIndex()
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.TabBuilder('首页',0,$r('app.media.home_select'),$r('app.media.home')))

      TabContent(){
        // 账单记录页面
        HistoricalBilling({currentIndex:this.currentIndex})
      }
      .tabBar(this.TabBuilder('账单记录',1,$r('app.media.historicalBill_select'),$r('app.media.historicalBill')))
      TabContent(){
        // 财务管理页面
        ItemIndex()
      }
      .tabBar(this.TabBuilder('财务管理',2,$r('app.media.financial_select'),$r('app.media.financial')))
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
          router.pushUrl({
            url:"pages/setting/setting"
          })
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