@Preview
@Component
export default struct DetailedBudget{
  @Builder DisplayInformation({}){
    Column(){
      Stack(){
        DataPanel({values:[1000],max:2000,type:DataPanelType.Circle})
        Column(){
          Text('衣')
          Row(){
            Text('30').fontSize(35).fontColor('#182431')
            Text('%') .fontSize(9.33)
              .lineHeight(12.83)
              .fontWeight(500)
              .opacity(0.6)
              // .position({ x: 104.42, y: 78.17 })
          }
        }
      }
    }
  }
  //
  build(){
    Row(){
      this.DisplayInformation({})
      this.DisplayInformation({})
      this.DisplayInformation({})
      this.DisplayInformation({})
    }.width('100%').justifyContent(FlexAlign.SpaceEvenly).padding({top:30,bottom:40})
    .backgroundColor(Color.White).borderRadius(20)
  }
}