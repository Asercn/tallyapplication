import colorUtil from '../../common/utils/ColorUtil'
import Bill from '../../viewmodel/Bill'
import BillType from '../../viewmodel/BillType'
import GroupInfo from '../../viewmodel/GroupInfo'


@Component
export default struct detailsBillCard {
  @Consume values:GroupInfo<BillType,Bill[]>[]

  @State items:any = [1,2,3]

  build() {
    // 今日详情消费
    Column(){
      Text('今日详情')
        .fontColor(Color.White)
        .fontSize(18)
        .fontWeight(FontWeight.Bolder)
      if (this.values.length < 1){
        Text('没有对消费分组，马上创建一个吧')
          .fontSize(12)
          .fontColor(Color.White)
      }else{
        List({space:10}){
          ForEach(this.values,(group:GroupInfo<BillType,Bill[]>)=>{
            ListItemGroup({header:this.ListHead({title:group.type.name,sumValue:group.type.sumValue,budget:group.type.budget,color:group.type.color})}){
              ForEach(group.items,(item:Bill,index:number)=>{
                ListItem(){
                  if (index === this.items.length-1){
                    Row(){
                      Column(){
                        Row(){
                          Text(item.label)
                          Blank()
                          Text(item.amount.toFixed(2))
                        }
                        .width('100%')
                        Row(){
                          Text(`${item.date}`)
                            .fontColor('#cfcfcf')
                            .fontSize(12)
                        }
                        .width('100%')
                      }
                    }
                    .padding(10)
                    .offset({x:15})
                    .backgroundColor(Color.White)
                    .width('90%')
                    .borderRadius({bottomLeft:20,bottomRight:20})
                    .border({width:{bottom:2},color:Color.Gray})
                  } else {
                    Row(){
                      Column(){
                        Row(){
                          Text(item.label)
                          Blank()
                          Text(item.amount.toFixed(2))
                        }
                        .width('100%')
                        Row(){
                          Text(`${item.date}`)
                            .fontColor('#cfcfcf')
                            .fontSize(12)
                        }
                        .width('100%')
                      }
                    }
                    .padding(10)
                    .offset({x:15})
                    .backgroundColor(Color.White)
                    .width('90%')
                  }
                }
              })
            }
          })
        }
      }
    }
    .margin({top:10})
    .backgroundColor('#cfcfcf')
    .borderRadius(20)
    .width('100%')
    .padding(10)
  }


  // 列表分组头
  @Builder ListHead($$:{title:string,sumValue:number,budget:number,color:string}){
    Row(){
      Stack(){
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(20)
          .shadow({radius:2,offsetY:10,color:'#868686'})

        Row(){
          Text($$.title)
            .fontColor(colorUtil.getComplementaryColor($$.color))
            .fontSize(20)
          if ($$.sumValue>$$.budget){
            Text('超出预算')
              .fontColor('#FFD700')
              .fontWeight(FontWeight.Bold)
          }else{
            Blank()
            Text(`${$$.sumValue}/${$$.budget}元`)
              .fontSize(10)
              .fontColor('#cccccc')
              .fontWeight(FontWeight.Bolder)
          }

        }
        .width(`${$$.sumValue*100/$$.budget}%`)
        .height('100%')
        .padding(10)
        .borderRadius(20)
        .backgroundColor($$.color)

      }
      .alignContent(Alignment.Start)
      .height(50)
    }
  }

}