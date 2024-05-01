
import mediaQuery from '@ohos.mediaquery'
import BreakpointConstants from '../constants/BreakpointConstants'

export default class BreakpointSystem{
  private smListener:mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_SM);
  private mdListener:mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_MD);
  private lgListener:mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_LG);

  //设置监听器的回调函数
  smListenerCallback(result:mediaQuery.MediaQueryResult){
    if(result.matches){
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_SM);
    }
  }
  mdListenerCallback(result:mediaQuery.MediaQueryResult){
    if(result.matches){
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_MD);
    }
  }
  lgListenerCallback(result:mediaQuery.MediaQueryResult){
    if(result.matches){
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_LG);
    }
  }

  updateCurrentBreakpoint(breakpoint:BreakpointConstants){
    if (breakpoint) {
      AppStorage.SetOrCreate(BreakpointConstants.CURRENT_BREAKPOINT,breakpoint)
    }
  }

  // 注册监听器
  register(){
    this.smListener.on('change',this.smListenerCallback.bind(this))  // 不加括号表示回调函数，不是引用方法
    this.mdListener.on('change',this.mdListenerCallback.bind(this))  // 不加括号表示回调函数，不是引用方法
    this.lgListener.on('change',this.lgListenerCallback.bind(this))  // 不加括号表示回调函数，不是引用方法
  }


  unregister(){
    this.smListener.off('change',this.smListenerCallback.bind(this))  // 不加括号表示回调函数，不是引用方法
    this.mdListener.off('change',this.mdListenerCallback.bind(this))  // 不加括号表示回调函数，不是引用方法
    this.lgListener.off('change',this.lgListenerCallback.bind(this))  // 不加括号表示回调函数，不是引用方法
  }
}