import { CommonConstants } from '../../common/constants/CommonConstants'

// @Preview
@CustomDialog
export default struct DatePickerDialog {
  controller:CustomDialogController
  selectedDate:Date = new Date()
  onDateSelected: (selectedDate: Date) => void; // 添加回调函数参数
  build() {
    Column(){
      // 1.日期选择器
      DatePicker({
        start: new Date('2020-01'),
        end: new Date(),
        selected:new Date()
      })

        .onChange((value:DatePickerResult)=>{
          this.selectedDate.setFullYear(value.year,value.month,value.day)
        })


      // 2.按钮
      Row({space:CommonConstants.SPACE_12}){

        Button('取消')
          .width(120)
          // .backgroundColor($r('app.color.light_gray'))
          .onClick(()=>this.controller.close())

        Button('确定')
          .width(120)
          // .backgroundColor($r('app.color.primary_color'))
          .onClick((event: ClickEvent) => {
            //AppStorage-->整个应用中的所有组件都可以使用里面的值
            // 1.保持日期都全局存储
            // 监听Date对象会报错，建议转换为毫秒
            // 2.AppStorage也有状态管理的功能
            AppStorage.SetOrCreate('selectedDate',this.selectedDate.getTime())
            // 3.关闭窗口
            this.controller.close();
            // 调用回调函数
            if (this.onDateSelected) {
              this.onDateSelected(this.selectedDate); // 将选定日期传递给回调
            }
          })
      }
    }
    .padding(CommonConstants.SPACE_12)
  }
}