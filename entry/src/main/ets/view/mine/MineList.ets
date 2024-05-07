
import { ItemType } from '../../viewmodel/types'
import promptAction from '@ohos.promptAction'; //弹窗
@Component
export default struct MineList {
  @State message:string = '我的列表'
  private listData:Array<ItemType> = [
    {
      title:'推送通知',
      img:$r('app.media.wallet')
    },
    {
      title:'数据管理',
      img:$r('app.media.wallet')
    },
    {
      title:'菜单设置',
      img:$r('app.media.wallet')
    },
    {
      title:'关于',
      img:$r('app.media.wallet')
    },
    {
      title:'清除缓存',
      img:$r('app.media.wallet')
    },
    {
      title:'隐私协议',
      img:$r('app.media.wallet')
    },
    {
      title:'其他',
      img:$r('app.media.wallet')
    }
  ]
  build() {
   List(){
     ForEach(this.listData,(item:ItemType)=>{
       ListItem(){
         Row(){
           Row({space:10}){
             Image(item.img)
               .width('22vp')
               .height('22vp')
             Text(item.title)
               .fontSize('16fp')
           }
           //开关组件
           Toggle({type:ToggleType.Switch,isOn:false})
             .onChange((isChange:boolean)=>{
               //isChange打开或关闭的状态
               let tip:string = isChange?'系统选项打开':'系统选项关闭'
               promptAction.showToast({
                 message:tip,
                 duration:3000
               })
             })
         }
         .width('100%')
         .justifyContent(FlexAlign.SpaceBetween)
         .padding('12vp')
       }
       .height('50vp')
     })

   }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius('25vp')
    .padding({
      top:'5vp',
      bottom:'5vp'
    })
    .divider({
      color:'#dddd',
      strokeWidth:'1vp',
      startMargin:'46vp',//分割线的开始的位置
      endMargin:'12vp'
    })
  }
}