/**
 * 绘制折线图的面板
 */
import router from '@ohos.router'
import Bill from '../../viewmodel/Bill'

@CustomDialog
struct CustomDialogChart{
  //定义一个数组
  @State consumeMonths:Bill[] = []
  @State consumeYears:Bill[] = []

  numX:number = 0

  sumMonth:number = 0
  sumYear:number = 0

  controller:CustomDialogController

  aboutToAppear(){
    let sumMon:number = this.getSum(this.consumeMonths)
    this.consumeMonths.forEach(item=>{
      this.sumMonth+=(item.isExpend?item.amount:0)
    })
    this.consumeYears.forEach((item:Bill)=>{
      this.sumYear+=(item.isExpend?item.amount:0)
    })
  }

  build(){
    Column(){
      /**
       * 绘制本月消费数据占全年的比例
       */

      // DataPanel({values:this.consumeMonths,max:this.sumYear,type:DataPanelType.Circle})


      // //绘制折线图
      // Polyline({width:200,height:200})
      //   // .width(200)
      //   // .height(200)
      //   .points(this.parseArr(this.numX,this.numbersY))
      //   .fillOpacity(0)
      //   .stroke(Color.Blue)
      //   .strokeWidth(2)

      Button('关闭')
        .onClick(()=>{
          this.controller.close()
        })
    }
    .width('100%')
  }

  getSum(arr:Bill[]):number{
    let sum:number = 0
    if (arr){
      arr.forEach(item=>{
        sum+=(item.isExpend?item.amount:0)
      })
    }
    return sum
  }

  // parseArr(numX:number,numbers:number[]):number[][]{
  //   let arr:number[][] = []
  //   numbers.forEach((num)=>{
  //     arr.push([numX+=40,num])
  //   })
  //   return arr;
  // }
}


/**
 * 获取设置预算的面板
 */
@CustomDialog
struct CustomDialogBudget{
  //预算
  // budget:number
  @Consume budget:number
  @Consume count:number

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
            this.count++
            this.controller.close()
          })

        Button('取消')
          .onClick(()=>{
            this.count++
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
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
  @Consume count:number


  //开启弹窗
  controller:CustomDialogController = new CustomDialogController({
    // builder:CustomDialogChart({}),
    builder:CustomDialogBudget()
  })

  /**
   * 财务这统计折线图弹窗
   */
  imgController:CustomDialogController = new CustomDialogController({
    builder:CustomDialogChart({}),
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
        this.imgController.open()
      })

      //2.历史账单记录
      Column({space:5}){
        Image($r("app.media.bill"))
          .width(30)
        Text($r('app.string.wallet_bill'))
      }
      .ColumnStyle()
      .onClick(()=>{
        // AppStorage.SetOrCreate('historical',this.count)
        router.pushUrl({url:"pages/historical/HistoricalBilling"})

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