import accessibility from '@ohos.accessibility'
import data from '@ohos.telephony.data'
import router from '@ohos.router'

@Entry
@Component
export default struct Setting {


aboutToAppear(){
  let captionsManager = accessibility.getCaptionsManager()
  let abilityType:accessibility.AbilityType = 'all'
  let abilityState:accessibility.AbilityState = 'enable'
  // 获取无障碍应用的信息,并输出
  accessibility.getAccessibilityExtensionList(abilityType,abilityState,(err,data)=>{
    if (err) {
      console.log('testTag','setting','err','获取无障碍失败',err);
    } else {
      for(let item of data){
        console.log(item.id)
        console.info(item.name);
        console.info(item.description);
        console.info(item.bundleName);
      }
    }


  })

  captionsManager.on('enableChange',(data=>{
    console.log('testTag','setting',data)
  }))
}

  build() {
    Scroll() {
      Column(){
        Row(){
          Button(){
            Image($r('app.media.ic_public_back')).width(30)
          }
          .backgroundColor(Color.Transparent)
          .onClick((event: ClickEvent) => {
            router.back()
          })
        }.width('100%')


        Row(){
          Text('设置')
            .fontSize(35)
        }
        .margin({top:10})
        .width('100%')

        this.settingItem({title:'快速记账',text:'开启此功能后默认会直接打开记账界面'})
        this.settingItem({title:'自动记账',text:'该功能暂时无法实现'})




      }
      .width('100%')
      .height('100%')
    }
    .padding(20)
  }



  @Builder settingItem($$:{title:string,text:string,isOn?:boolean}){
    // 设置项
    Row(){
      Column(){
        Row(){
          Text(`${$$.title}`)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
        }
        .width('100%')

        Row(){
          Text(`${$$.text}`)
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .margin({top:5})
        .width('100%')

        Row(){

        }
        .width('100%')

      }
      .layoutWeight(1)
      Toggle({type:ToggleType.Switch,isOn:$$.isOn})
    }
    .width('100%')
    .margin({top:20})
  }
}