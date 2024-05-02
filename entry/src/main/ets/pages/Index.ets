import colorUtil from '../common/utils/ColorUtil';
import IECard from '../view/IECard';
import Bill from '../viewmodel/Bill';

@Entry
@Component
struct Index {
  @State titleFont:number = 40
  @Provide total:number = 100
  @Provide sumValue:number = 0
  @Provide income:number = 0
  @Provide values:Bill[] = [
    new Bill(70.00,1411111,true,'测试数据1',this.randomColor(),1),
    new Bill(10.00,1411111,true,'测试数据2',this.randomColor(),1),
    new Bill(25.00,1411111,true,'测试数据3',this.randomColor(),1),
    new Bill(45.00,1411111,true,'测试数据4',this.randomColor(),1),
    new Bill(65.00,1411111,true,'测试数据5',this.randomColor(),1),
    new Bill(2.00,1411111,true,'测试数据5',this.randomColor(),1),
    new Bill(65.00,1411111,true,'测试数据5',this.randomColor(),1),
    new Bill(65.00,1411111,true,'测试数据5',this.randomColor(),1),
    new Bill(65.00,1411111,true,'测试数据5',this.randomColor(),1),
  ]

  // 获取今日的账单
  getSum(){
    this.values.forEach(bill=>{
      this.sumValue += bill.amount
    })
    console.log('testTag','Index','total',this.total)
  }
  randomColor(){
    let rgb:{r:number,g:number,b:number} = colorUtil.getRandomColor()
    // console.log('testTag','Index','rgb',rgb)
    return colorUtil.rgbToHex(rgb.r,rgb.g,rgb.b)
  }
  // 将数据从小到大排序展示
  initValue(){
    this.values = this.values.sort((a,b)=>b.amount-a.amount)
  }
  aboutToAppear(){
    this.initValue()
    this.getSum()
  }

  build() {
    Column() {
      // 头部
      this.header()
      // 主要内容
      this.main()
      // 页脚
      Blank()
      this.footer()
    }
    .width('100%')
    .height('100%')
  }


  // 首页头部
  @Builder header(){
    Row(){
      Row().layoutWeight(1)
      Stack(){
        Text('首页')
          .offset({y:2})
          .fontColor(Color.Gray)
          .fontSize(this.titleFont)
        Text('首页')
          .fontColor(Color.White)
          .fontSize(this.titleFont)
      }
      .layoutWeight(1)

      // 设置按钮
      Row(){
        Button(){
          Stack(){
            Image($r('app.media.setting_primary')).width(50).offset({y:3})
              .renderMode(ImageRenderMode.Template)
              .colorFilter([
                .5,0,0,0,0,
                0,.5,0,0,0,
                0,0,.5,0,0,
                1,1,1,1,0
              ])
              .blur(5)
              // .opacity(.5)

            Image($r('app.media.setting_primary')).width(50)

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
    .height(80)
    .backgroundColor($r('app.color.primary_color'))
  }

  // 首页中间部分
  @Builder main(){
    Scroll(){
      Column(){
        // 封装后的卡片
        IECard()

        Text('下面面板正在施工')
        // 账单总图
        Column(){

        }
        .backgroundColor('#cfcfcf')
        .width('100%')
      }
    }
    .padding(10)
  }

  // 首页页脚
  @Builder footer(){
    Row(){
      Row(){

      }
      .backgroundColor($r('app.color.primary_color'))
      .width('100%')
      .height(80)
      .shadow({radius:20})
    }
    .width('100%')
    .height(100)
    .backgroundColor($r('app.color.dark_primary_color'))
    .alignItems(VerticalAlign.Bottom)
    .shadow({radius:15})
  }
}
