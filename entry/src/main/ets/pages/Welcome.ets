@Entry
@Component
struct Welcome {
  @State message: string = 'Hello World'

  build() {
    Row(){
      Column() {
        // 记账APP的logo
        this.logo()
        // 欢迎页面的提示语句
        this.prompt()
      }
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.dark_primary_color'))
      .width('100%')
      .height('100%')
    }
    .height('100%')

  }

  @Builder logo(){
    Stack(){
      // 背景
      Stack(){
        Circle({width:230,height:230})
          .fill($r('app.color.light_contrast_primary_color'))
          .clip(new Circle({width:'100%',height:'100%'}))
          .shadow({radius:20})


        Circle({width:220,height:220})
          .fill($r('app.color.dark_contrast_primary_color'))
      }

      Column(){
        // 名字
        Row(){
          Text($r('app.string.app_name'))
            .fontSize(70)
            .fontColor($r('app.color.light_contrast_primary_color'))
        }
        // app图片
        Row(){
          Image($r('app.media.wallet')).width(100)
        }
      }
    }
  }

  @Builder prompt(){
    Column(){
      Text('本应用用于帮助用户快速记账  不会动用您的财产')
        .promptText()
      Text('应用不会使用到网络权限  不会查看您的隐私')
        .promptText()
      Text('保证无广告  且永久免费')
        .promptText()
    }
    .padding({bottom:10})
    .position({y:'100%',x:'50%'})
    .translate({y:'-100%',x:'-50%'})
  }


}
@Extend(Text) function promptText(){
  .fontSize(12)
  .fontColor(Color.White)
}