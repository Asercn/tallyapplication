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
    Row(){
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

      Button(){
        Image($r('app.media.setting_primary')).width(50)
      }.onClick((event: ClickEvent) => {

      })

    }
    .shadow({radius:5,offsetY:2})
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(80)
    .backgroundColor($r('app.color.primary_color'))
  }

  // 首页中间部分
  @Builder main(){
    Column(){
      Row(){

      }
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