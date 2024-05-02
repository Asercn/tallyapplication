@Entry
@Component
struct Index {
  @State message: string = '页面正在施工';
  @State titleFont:number = 40

  build() {
    Column() {
      this.header()
      this.main()
      this.footer()
    }
    .width('100%')
    .height('100%')
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
          .clip(new Rect({width:'100%',height:'100%'}))
        Text('首页')
          .fontColor(Color.White)
          .fontSize(this.titleFont)
      }
      .layoutWeight(1)

      // 设置按钮
      Row(){
        Button(){
          Image($r('app.media.setting_primary')).width(50)
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
        Row(){
          Text('今日支出')
            .fontColor($r('app.color.primary_color'))
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row(){
          Text(`消费400元`)
            .fontColor($r('app.color.primary_color'))
          Blank()
          Text(`预算:1000元`)
            .fontColor(Color.Gray).fontSize(12)
        }
        .width('100%')
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .cardStyle()



    }
    .padding(10)
    .layoutWeight(1)
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
  .border({
    width:1,
    color: {
      bottom:Color.Gray,
      left:Color.Gray,
      top:Color.White,
      right:Color.White
    },
  })
  .borderRadius(20)
}