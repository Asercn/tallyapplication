import accessibility from '@ohos.accessibility'
import data from '@ohos.telephony.data'

@Entry
@Component
export default struct Setting {


aboutToAppear(){
  let captionsManager = accessibility.getCaptionsManager()
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