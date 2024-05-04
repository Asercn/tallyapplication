import colorUtil from '../../common/utils/ColorUtil'
import BillType from '../../viewmodel/BillType'
import allBillCard from './AllBillCard'
import IECard from './IECard'

@Component
export default struct homeIndex {
  title:string = '首页'
  titleFont:number = 30

  @State items:any = [1,2,3]



  @Consume total:number
  @Consume sumValue:number
  @Consume income:number
  @Consume values:BillType[]

  build() {
    Column() {
      // 头部
      this.header({title:this.title})
      // 主要内容
      this.main()
      // 页脚
      // Blank()
      // this.footer()
    }
    .width('100%')
    .height('100%')
  }


  // 首页头部
  @Builder header($$:{title:string}){
    Row(){
      Row().layoutWeight(1)
      Stack(){
        Text($$.title)
          .offset({y:2})
          .fontColor(Color.Gray)
          .fontSize(this.titleFont)
        Text($$.title)
          .fontColor(Color.White)
          .fontSize(this.titleFont)
      }
      .layoutWeight(1)

      // 设置按钮
      Row(){
        Button(){
          Stack(){
            Image($r('app.media.setting_primary')).width(30).offset({y:3})
              .renderMode(ImageRenderMode.Template)
              .colorFilter([
                .5,0,0,0,0,
                0,.5,0,0,0,
                0,0,.5,0,0,
                1,1,1,1,0
              ])
              .blur(5)
            // .opacity(.5)

            Image($r('app.media.setting_primary')).width(30)

          }
        }
        .backgroundColor(Color.Transparent)
        .onClick((event: ClickEvent) => {
          // 打开设计面板或者页面

        })
      }
      .justifyContent(FlexAlign.End)
      .layoutWeight(1)

    }
    .padding(10)
    .shadow({radius:5,offsetY:2})
    .width('100%')
    .height(50)
    .backgroundColor($r('app.color.primary_color'))
  }

  // 首页中间部分
  @Builder main(){
    Scroll(){
      Column(){
        // 封装后的卡片
        IECard()

        // 账单总图
        allBillCard()

        // 今日详情消费
        Column(){
          Text('今日详情')
            .fontColor(Color.White)
            .fontSize(18)
            .fontWeight(FontWeight.Bolder)
          List({space:10}){
            ForEach(this.values,(billtype:BillType)=>{
              ListItemGroup({header:this.ListHead({title:billtype.name,sumValue:billtype.sumValue,budget:billtype.budget,color:billtype.color})}){
                ForEach(this.items,(item,index:number)=>{
                  ListItem(){
                    if (index === this.items.length-1){
                      Row(){
                        Column(){
                          Row(){
                            Text('原神大礼包')
                            Blank()
                            Text('684.00')
                          }
                          .width('100%')
                          Row(){
                            Text('10:48:23')
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
                            Text('原神大礼包')
                            Blank()
                            Text('684.00')
                          }
                          .width('100%')
                          Row(){
                            Text('10:48:23')
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
        .margin({top:10})
        .backgroundColor('#cfcfcf')
        .borderRadius(20)
        .width('100%')
        .padding(10)


      }
      // .backgroundColor('green')
    }
    .scrollBar(BarState.Off)
    // .backgroundColor('red')
    .layoutWeight(1)
    .padding(10)
  }
  // 首页页脚
  @Builder footer(){
    Row(){
      Row({space:20}){
        Button('历史账单')
          .buttonStyle()
          .onClick((event: ClickEvent) => {

          })
        Button('记一账')
          .buttonStyle()
          .onClick((event: ClickEvent) => {

          })
        Button('更多')
          .buttonStyle()
          .onClick((event: ClickEvent) => {

          })

      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor($r('app.color.primary_color'))
      .width('100%')
      .height(80)
      .shadow({radius:20})
    }
    .width('100%')
    .height(100)
    .backgroundColor($r('app.color.dark_primary_color'))
    .alignItems(VerticalAlign.Bottom)
    .shadow({radius:15})
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

@Extend(Button)function buttonStyle(){
  .backgroundColor($r('app.color.light_primary_color'))
  .borderRadius('50%')
  .width(70)
  .height(70)
  .shadow({radius:10,color:'#4f4f4f'})
  .offset({y:-15})
}