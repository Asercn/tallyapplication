import router from '@ohos.router'
import MineList from '../../view/mine/MineList'
import MineUser from '../../view/mine/MineUser'

@Entry
@Component
export default struct MinePage {
  build() {
    Row(){
      Column(){
        // 2024年5月8日01:58:59陈显洪修改，感觉不好看，去掉了
        // Row(){
        //   Image($r('app.media.ic_public_back'))
        //     .width(20)
        //   Blank()
        //   Image($r('app.media.count'))
        //     .width(20)
        // }
        // .width('100%')
        // .justifyContent(FlexAlign.SpaceBetween)
        //用户描述
        MineUser()
        //列表
        MineList()

        Button('退出登录')
          .width('90%')
          .height('40vp')
          .fontSize('16fp')
          .backgroundColor('#e5e8ea')
          .fontColor(Color.Red)
          .margin({
            top:'30vp'
          })
          .onClick(()=>{
            //跳转
            router.pushUrl({
              url:'pages/Index'
            },router.RouterMode.Single).catch((error:Error)=>{
            //异常处理
            })
          })
      }
      .width('100%')
      .padding('10vp')
      .height('100%')
    }
    .backgroundColor('#f1f3f5')
  }
}