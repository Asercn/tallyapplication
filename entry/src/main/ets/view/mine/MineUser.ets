import router from '@ohos.router'

@Component
export default struct MineUser {
  @State message:string = '用户描述'
  build() {
    Row(){
     Image($r('app.media.profile_picture'))
       .width('50vp')
       .height('50vp')
      Column(){
        Text('张三')
          .fontSize('20fp')
        Text('1733520092@qq.com')
          .fontSize('14fp')
          .margin({top:'5vp'})
      }
      .alignItems(HorizontalAlign.Start)
      .margin({top:'15vp'})
      Button('编辑')
        .fontSize('16fp')
        .backgroundColor('#a3a1b5')
        .margin({left:30})
        .onClick(()=>{
          router.pushUrl({
            url:'pages/setting/Personal_Information'
          }).catch((error:Error)=>{
            //异常处理
          })
        })
    }
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .width('100%')
    .height('100vp')
    .margin({
      top:'50vp',
      bottom:'12vp'
    })
    .borderRadius('25vp')
    .padding({left:'20vp'})
  }
}