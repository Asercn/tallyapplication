import router from '@ohos.router'


@Component
export default struct Header{
  build(){
    Row(){
      Button(){
        Image($r('app.media.ic_public_back')).width(24)
      }
      .backgroundColor(Color.Transparent)
        .onClick((event: ClickEvent) => {
        router.back()
      })
      Text('账单').fontWeight(FontWeight.Bold)
      Text('常见问题')
    }
    .margin({top:20})
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
  }
}