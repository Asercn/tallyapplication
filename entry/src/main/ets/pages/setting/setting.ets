import accessibility from '@ohos.accessibility'
import data from '@ohos.telephony.data'
import router from '@ohos.router'
import PreferenceUtil from '../../common/utils/PreferenceUtil'
import preferences from '@ohos.data.preferences'


@Entry
@Component
export default struct Setting {
  @State QuickBookkeeping: boolean = false
  @State AutomaticBookkeeping: boolean = false

  async aboutToAppear() {
    let captionsManager = accessibility.getCaptionsManager()

    // 获取首选项信息
    this.QuickBookkeeping = await PreferenceUtil.getPreferenceValue('QuickBookkeeping', false, 'setting') as boolean
    this.AutomaticBookkeeping = await PreferenceUtil.getPreferenceValue('AutomaticBookkeeping', false, 'setting') as boolean

    // let abilityType:accessibility.AbilityType = 'all'
    // let abilityState:accessibility.AbilityState = 'enable'
    // 获取无障碍应用的信息,并输出
    // accessibility.getAccessibilityExtensionList(abilityType,abilityState,(err,data)=>{
    //   if (err) {
    //     console.log('testTag','setting','err','获取无障碍失败',err);
    //   } else {
    //     for(let item of data){
    //       console.log(item.id)
    //       console.info(item.name);
    //       console.info(item.description);
    //       console.info(item.bundleName);
    //     }
    //   }
    // })

    captionsManager.on('enableChange', (data => {
      console.log('testTag', 'setting', data)
    }))
  }

  build() {
    Scroll() {
      Column() {
        Row() {
          Button() {
            Image($r('app.media.ic_public_back')).width(30)
          }
          .backgroundColor(Color.Transparent)
          .onClick((event: ClickEvent) => {
            router.back()
          })
        }.width('100%')


        Row() {
          Text('设置')
            .fontSize(35)
        }
        .margin({ top: 10 })
        .width('100%')

        this.settingItem({ title: '快速记账', text: '开启此功能后默认会直接打开记账界面',key:'QuickBookkeeping',isOn:this.QuickBookkeeping})
        this.settingItem({ title: '自动记账', text: '该功能暂时无法实现', key:'AutomaticBookkeeping',isOn:this.AutomaticBookkeeping})


      }
      .width('100%')
      .height('100%')
    }
    .padding(20)
  }

  @Builder
  settingItem($$: {
    title: string,
    text: string,
    key:string,
    isOn?: boolean
  }) {
    // 设置项
    Row() {
      Column() {
        Row() {
          Text(`${$$.title}`)
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
        }
        .width('100%')

        Row() {
          Text(`${$$.text}`)
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .margin({ top: 5 })
        .width('100%')
      }
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: $$.isOn }).onChange(isOn=>{
        // 当值发生改变的时候修改首选项的值
        PreferenceUtil.putPreferenceValue($$.key,isOn,'setting')

      })
    }
    .width('100%')
    .margin({ top: 20 })
  }
}