import preferences from '@ohos.data.preferences';
import Logger from './Logger';

class PreferenceUtil{
  private pref: preferences.Preferences

  async loadPreference(context,preferencesName){
    try { // 加载preferences
      this.pref = await preferences.getPreferences(context, preferencesName)
      Logger.debug(`加载Preferences[${preferencesName}]成功`)
    } catch (e) {
      Logger.debug(`加载Preferences[${preferencesName}]失败`, JSON.stringify(e))
    }
  }

  async putPreferenceValue(key: string, value: preferences.ValueType, preferencesName:string){
    if (!this.pref) {
      Logger.debug(`Preferences[${preferencesName}]尚未初始化！`)
      return
    }
    try {
      // 写入数据
      await this.pref.put(key, value)
      // 刷盘
      await this.pref.flush()
      Logger.debug(`保存Preferences[${key} = ${value}]成功`)
    } catch (e) {
      Logger.debug(`保存Preferences[${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  async getPreferenceValue(key: string, defaultValue: preferences.ValueType, preferencesName:string){
    if (!this.pref) {
      Logger.debug(`Preferences[${preferencesName}]尚未初始化！`)
      return
    }
    try {
      // 读数据
      let value = await this.pref.get(key, defaultValue)
      Logger.debug(`读取Preferences[${key} = ${value}]成功`)
      return value
    } catch (e) {
      Logger.debug(`读取Preferences[${key}]失败`, JSON.stringify(e))
    }
  }
}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil