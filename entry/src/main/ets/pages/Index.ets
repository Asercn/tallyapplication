import colorUtil from '../common/utils/ColorUtil';
import DateUtil from '../common/utils/DateUtil';
import allBillCard from '../view/AllBillCard';
import IECard from '../view/IECard';
import Bill from '../viewmodel/Bill';
import BillType from '../viewmodel/BillType';

@Entry
@Component
struct Index {
  @State titleFont:number = 30
  @State items:any = [1,2,3]

  @Provide total:number = 1300
  @Provide sumValue:number = 0
  @Provide income:number = 0
  @Provide values:BillType[] = [
    new BillType('组1',800,1200),
    new BillType('组2',130,200),
    new BillType('组3',200,180),
    new BillType('组4',101,200),
    new BillType('组5',21,100),
    new BillType('组6',81,80),
    new BillType('组7',51,100),

  ]



  // 获取今日的总消费和总预算
  getSum(){
    this.values.forEach(billtype=>{
      this.sumValue += billtype.sumValue
      this.total += billtype.budget
    })
    console.log('testTag','Index','total',this.total)
  }

  // 将数据从小到大排序展示
  initValue(){
    this.values = this.values.sort((a,b)=>b.sumValue-a.sumValue)
  }
  aboutToAppear(){
    console.log('testTag','Index',DateUtil.getWeek(new Date()))
    this.initValue()
    this.getSum()
  }

  build() {
    Column() {
      // 头部
      this.header()
      // 主要内容
      this.main()
      // 页脚
      Blank()

      this.footer()
    }
    .width('100%')
    .height('100%')
  }


  // 首页头部
  @Builder header(){
    Row(){
      Row().layoutWeight(1)
      Stack(){
        Text('首页')
          .offset({y:2})
          .fontColor(Color.Gray)
          .fontSize(this.titleFont)
        Text('首页')
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
}


@Styles function cardStyle(){
  .padding(10)
  .backgroundColor(Color.White)
  .width('100%')
  .shadow({radius:10,color:Color.Gray})

  .borderRadius(20)
}

@Extend(Button)function buttonStyle(){
  .backgroundColor($r('app.color.light_primary_color'))
  .borderRadius('50%')
  .width(70)
  .height(70)
  .shadow({radius:10,color:'#4f4f4f'})
  .offset({y:-15})
}