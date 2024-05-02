import colorUtil from '../common/utils/ColorUtil';
import Bill from '../viewmodel/Bill';

@Entry
@Component
struct Index {
  @State titleFont:number = 40
  @State total:number = 100
  @State sumValue:number = 0
  @State income:number = 0
  @State values:Bill[] = [
    new Bill(70.00,1411111,true,'测试数据1',this.randomColor(),1),
    new Bill(10.00,1411111,true,'测试数据2',this.randomColor(),1),
    new Bill(25.00,1411111,true,'测试数据3',this.randomColor(),1),
    new Bill(45.00,1411111,true,'测试数据4',this.randomColor(),1),
    new Bill(45.00,1411111,true,'测试数据5',this.randomColor(),1),
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
    Scroll(){
      Column() {
        this.header()
        this.main()
        this.footer()
      }
      .width('100%')
      .height('100%')
    }
  }


  // 首页头部
  @Builder header(){
    Flex({direction:FlexDirection.Row}){
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
    Column(){
      Column(){
        // 卡片标题
        Row(){
          Text('今日收支')
            .fontColor($r('app.color.primary_color'))
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        // 消费进度条文字
        Row(){
          Text(`消费${this.sumValue}元`)
            .fontColor($r('app.color.primary_color'))
          Blank()
          Text(`预算:${this.total}元`)
            .fontColor(Color.Gray).fontSize(12)
        }
        .width('100%')
        // 消费进度条
        Row(){
          Stack(){
            ForEach(this.values,(bill:Bill)=>{
              Progress({value:bill.amount,total:this.total})
                .color(bill.color)
                .style({
                  strokeWidth:10
                })
            })
          }
        }
        .margin({top:10})

        // 收入字样
        Row(){
          Text(`收入 ${this.income} 元`)
            .fontSize(14)
            .fontColor($r('app.color.dark_primary_color'))
        }
        // 图例
        Scroll(){
          Row({space:10}){
            ForEach(this.values,(bill:Bill)=>{
              this.tl({text:'www',color:bill.color})
            })
          }
          .margin({top:20})
        }

      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .cardStyle()



    }
    .padding(10)
    .layoutWeight(1)
  }

  @Builder tl($$:{text:string,color:ResourceColor}){
    Row({space:2}){
      Rect({width:7,height:7}).fill($$.color)
      Text($$.text)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
  }

  // 首页页脚
  @Builder footer(){
    Row(){
      Row(){

      }
      .backgroundColor($r('app.color.primary_color'))
      .width('100%')
      .height(80)
    }
    .width('100%')
    .height(100)
    .backgroundColor($r('app.color.dark_primary_color'))
    .alignItems(VerticalAlign.Bottom)
  }
}

@Styles function cardStyle(){
  .padding(10)
  .backgroundColor(Color.White)
  .width('100%')
  .height(150)
  .shadow({radius:10,color:Color.Gray})

  .borderRadius(20)
}