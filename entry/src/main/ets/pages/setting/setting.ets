import accessibility from '@ohos.accessibility'
import data from '@ohos.telephony.data'

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
      Text('设置界面正在施工')
    }
    .width('100%')
  }
}