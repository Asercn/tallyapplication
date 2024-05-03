import Bill from '../../viewmodel/Bill'
import BillType from '../../viewmodel/BillType'

@Component
export default struct IECard {
  @Consume sumValue:number
  @Consume total:number
  @Consume income:number
  @Consume values:BillType[]


  build() {
    // 卡片
    Column(){
      // 卡片标题
      Row(){
        Text('今日收支')
          .fontColor($r('app.color.primary_color'))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      // 消费进度条文字
      Row(){
        Row(){
          Text(`消费${this.sumValue}元`)
            .fontColor($r('app.color.primary_color'))
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Start)
        Row(){
          Text(`${this.sumValue}/${this.total}`)
            .fontSize(12)
            .fontColor(Color.Gray)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        Row(){
          Text(`预算:${this.total}元`)
            .fontColor(Color.Gray).fontSize(12)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)


      }
      .width('100%')

      // 消费条形图
      Row(){
        Progress({value:this.sumValue,total:this.total})
          .color($r('app.color.primary_color'))
          .style({
            strokeWidth:8
          })
          .width('100%')

      }
      .width('100%')

      // 消费柱状图
      Scroll(){
        Row(){
          ForEach(this.values,(billtype:BillType)=>{
            Progress({value:billtype.sumValue,total:billtype.budget})
              .width(20)
              .height(80)
              .color(billtype.color)
              .rotate({angle:180})
              .style({
                strokeWidth:10
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .margin({top:10})


      // 图例
      Scroll(){
        Row({space:10}){
          ForEach(this.values,(billtype:BillType)=>{
            this.tl({text:`${billtype.name}`,color:billtype.color})
          })
        }
        .margin({top:5})
      }
      .width('100%')
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Horizontal)

      // 收入字样
      Row(){
        Text(`今日收入 ${this.income} 元`)
          .fontSize(14)
          .fontColor($r('app.color.contrast_primary_color'))
      }
      .margin({top:10})

    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .cardStyle()
  }

  @Builder tl($$:{text:string,color:ResourceColor}){
    Row({space:2}){
      Rect({width:7,height:7}).fill($$.color)
      Text($$.text)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
  }
}


@Styles function cardStyle(){
  .padding(10)
  .backgroundColor(Color.White)
  .width('100%')
  .shadow({radius:10,color:Color.Gray})

  .borderRadius(20)
}