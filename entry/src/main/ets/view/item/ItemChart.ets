/**
 * 绘制折线图的面板
 */
// @CustomDialog
// struct CustomDialogChart{
//   //定义一个数组
//   numbersY:number[] = [12,25,50,34.00,90,80,94]
//
//   numX:number = 0
//
//   controller:CustomDialogController
//   build(){
//     Column(){
//       //绘制折线图
//       Polyline({width:200,height:200})
//         // .width(200)
//         // .height(200)
//         .points(this.parseArr(this.numX,this.numbersY))
//         .fillOpacity(0)
//         .stroke(Color.Black)
//         .strokeWidth(2)
//
//       Button('关闭')
//         .onClick(()=>{
//           this.controller.close()
//         })
//     }
//     .width('100%')
//   }
//
//   parseArr(numX:number,numbers:number[]):number[][]{
//     let arr:number[][] = []
//     numbers.forEach((num)=>{
//       arr.push([numX+=40,num])
//     })
//     return arr;
//   }
// }


/**
 * 获取设置预算的面板
 */
@CustomDialog
struct CustomDialogBudget{
  //预算
  // budget:number
  @Consume budget:number

  controller:CustomDialogController
  build(){
    Column() {
      Row(){
        Text("预算")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        //弹窗内容
        TextInput({placeholder:'请输入预算'})
          .fontSize(20)
          .type(InputType.Number)
          .width(200)
          .height(50)
          .onChange(val=>{
            let value = parseFloat(val)
            this.budget = value>0?value:0
          })
      }
      .width('100%')
      .height('70%')

      Row(){
        Button('确认')
          .onClick(()=>{
            // this.
            this.controller.close()
          })
        Button('取消')
          .onClick(()=>{
            this.controller.close()
          })
      }
    }
    .width('80%')
    .height(300)
  }

}



@Extend(Column) function ColumnStyle(){
  .width(100)
  .height(100)
  .borderRadius(5)
  .shadow({radius:5,color:'#CCCCCC',offsetX:5,offsetY:5})
  .backgroundColor(Color.White)
  .justifyContent(FlexAlign.Center)
}


@Component
export default struct ItemChart {

  @Consume budget:number //预算
  // @Prop budget:number //预算

  //开启弹窗
  controller:CustomDialogController = new CustomDialogController({
    // builder:CustomDialogChart({}),
    builder:CustomDialogBudget()
  })

  build() {
    Row({space:10}){
      //1.图表展示本月支出消费
      Column({space:5}){
        Image($r("app.media.chart"))
          .width(30)
        Text($r('app.string.wallet_chart'))
      }
      .ColumnStyle()
      .onClick(()=>{
        //展示图表的信息
        // this.controller.open()
      })

      //2.历史账单记录
      Column({space:5}){
        Image($r("app.media.bill"))
          .width(30)
        Text($r('app.string.wallet_bill'))
      }
      .ColumnStyle()
      .onClick(()=>{

      })

      //3.预算剩余
      Column({space:5}){
        Image($r("app.media.budget"))
          .width(30)

        Text($r('app.string.wallet_budget'))

      }
      .ColumnStyle()
      .onClick(()=>{
        //展示输入列表
        this.controller.open()
      })
    }
    // .width('100%')
    // .height('100%')
    .margin({top:20,bottom:20})
  }
}