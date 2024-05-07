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
      Column(){
        Text('设置界面正在施工，可能会有如下功能：')
        Text('自动记账-->因为模拟器无法获取调试证书，所以功能暂时搁置')
        Text('map热点图，记录下消费的经纬度，并且在地图上以红点的形式显示出来')
        Text('大转盘，拥有今天吃什么之类的界面')
      }
    }
    .height('100%')
    .width('100%')
  }
}