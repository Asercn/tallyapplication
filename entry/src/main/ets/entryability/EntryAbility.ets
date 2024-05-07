import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import DbUtil from '../common/utils/DbUtil';
import billModel from '../model/BillModel';
import billTypeModel from '../model/BillTypeModel';
import accessibility from '@ohos.accessibility';
import PreferenceUtil from '../common/utils/PreferenceUtil';
// 首选项变量
let QuickBookkeeping:boolean
let AutomaticBookkeeping:boolean

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    // 初始化数据库
    await DbUtil.initDB(this.context).then(()=>{
      console.log('testTag','EntryAbility','初始化数据库成功！')
    })
    //初始化账单表
    DbUtil.createTable(billModel.getCreateTableSql()).then(()=>{
      console.log('testTag','EntryAbility','账单表初始化成功！')
    })
    //初始化账单类型表
    DbUtil.createTable(billTypeModel.getCreateTableSql()).then(()=>{

      console.log('testTag','EntryAbility','账单分组初始化成功！')
    })



    // // 创建持久化任务
    // // 查看是否启用无障碍功能
    // accessibility.on('accessibilityStateChange',(data)=>{
    //   console.log('testTag','EntryAbility','data',JSON.stringify(data))
    // })



    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 加载首选项
    PreferenceUtil.loadPreference(this.context,'setting').then(async ()=>{
      console.log('testTag','EntryAbility','加载设置首选项成功')
      QuickBookkeeping = await PreferenceUtil.getPreferenceValue('QuickBookkeeping',false,'setting') as boolean
      AutomaticBookkeeping = await PreferenceUtil.getPreferenceValue('AutomaticBookkeeping',false,'setting') as boolean

      // 无法获取到首选项的值bug 2024年5月7日12:07:30
      console.log('testTag','EntryAbility','QuickBookkeeping',QuickBookkeeping)
      // 如果打开了快速记账则直接进入到记账界面
      if (QuickBookkeeping){
        // 直接进入到记账界面
        windowStage.loadContent('pages/Index', (err, data) => {
          if (err.code) {
            hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
            return;
          }
          hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
        });
      } else {
        windowStage.loadContent('pages/Welcome', (err, data) => {
          if (err.code) {
            hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
            return;
          }
          hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
        });
      }

    })

    // 获取首选项

  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
