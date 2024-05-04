import BillService from '../../common/services/BillService'
import BillTypeService from '../../common/services/BillTypeService'
import colorUtil from '../../common/utils/ColorUtil'
import DateUtil from '../../common/utils/DateUtil'
import Bill from '../../viewmodel/Bill'
import BillType from '../../viewmodel/BillType'
import GroupInfo from '../../viewmodel/GroupInfo'
import addBillPanel from './addBillPanel'
import addBillTypePanel from './addBillTypePanel'
import allBillCard from './AllBillCard'
import detailsBillCard from './detailsBillCard'
import IECard from './IECard'


@Component
export default struct homeIndex {
  title:string = '首页'
  titleFont:number = 30

  @State @Watch('getValues') isPanelShow:boolean = false
  @Provide @Watch('getValues') billPanel:boolean = false
  @State groupId:number = 0



  @Provide total:number = 0
  @Provide sumValue:number = 0
  @Provide income:number = 0
  @Provide values:GroupInfo<BillType,Bill>[] = [
    new GroupInfo(new BillType('组1',800),[
      new Bill(100,new Date(),true,'吃饭',0),
      new Bill(100,new Date(),true,'吃饭',0),
      new Bill(100,new Date(),true,'吃饭',0),
    ]),
    new GroupInfo(new BillType('组2',130),[
      new Bill(10,new Date(),true,'吃饭',0),
    ]),
    new GroupInfo(new BillType('组3',130),[
      new Bill(100,new Date(),true,'吃饭',0),
      new Bill(100,new Date(),true,'吃饭',0),
      new Bill(100,new Date(),true,'吃饭',0),
      new Bill(100,new Date(),false,'吃饭',0),
    ]),
    new GroupInfo(new BillType('组4',130),[
      new Bill(100,new Date(),true,'吃饭',0),
    ]),
    new GroupInfo(new BillType('组5'),[
      new Bill(100,new Date(),true,'吃饭',0),
      new Bill(100,new Date(),true,'吃饭',0),
    ]),

  ]

  aboutToAppear(){
    console.log('testTag','homeIndex',DateUtil.getWeek(new Date()))
    this.getValues().then(rep=>{
      this.getSum()
      this.sortValue()
    })
  }

  // 获取所有的总消费和总预算和收入
  getSum(){
    this.values.forEach((group:GroupInfo<BillType,Bill>)=>{
      group.items.forEach((item:Bill)=>{
        if(item.isExpend){
          group.type.sumValue += item.amount
        }else{
          this.income += item.amount
          group.type.budget += item.amount
        }
      })
      this.sumValue += group.type.sumValue
      this.total += group.type.budget
    })
    console.log('testTag','Index','total',this.total)
  }


  // 将数据从小到大排序展示
  sortValue(){
    this.values = this.values.sort((a,b)=>b.type.sumValue-a.type.sumValue)
  }


  // 获取数据
  async getValues(){
    let bills:Bill[] = await BillService.getAllBill()
    let billtypes:BillType[] = await BillTypeService.getBillType()
    this.values = BillService.getBillGroup(bills,billtypes)
    console.log('testTag','Index','billtypes',JSON.stringify(billtypes))
    console.log('testTag','Index','bills',JSON.stringify(bills))
  }

  build() {
    Column() {
      // 头部
      this.header({title:this.title})

      Stack(){
        // 主要内容
        this.main()
        // 消费类型分组
        Panel(this.isPanelShow){
          addBillTypePanel({isPanelShow:this.isPanelShow})
        }
        .dragBar(false)
        .type(PanelType.Temporary)

        // 2024年5月5日02:29:34
        Panel(this.billPanel){
          addBillPanel({groupId:this.groupId})
        }
        .dragBar(false)
        .type(PanelType.Temporary)
      }
      // .backgroundColor('red')



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
    Stack(){
      // 固定定位按钮
      Row(){
        Button(){
          Text('+')
            .layoutWeight(1)
            .fontSize(30)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
        }
          .type(ButtonType.Circle)
          .width(70)
          .backgroundColor($r('app.color.contrast_primary_color'))
          .onClick(()=>{
            this.isPanelShow = true
          })
      }
      .position({x:'100%',y:'50%'})
      .translate({x:'-100%'})
      .opacity(.5)
      // .backgroundColor('red')
      .zIndex(1000)

      Scroll(){
        Column(){
          // 封装后的卡片
          IECard()
          // 账单总图
          allBillCard()
          // 今日详情消费
          detailsBillCard({groupId:this.groupId})

        }
        .align(Alignment.Top)
        .width('100%')
        // .backgroundColor('green')


      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      // .backgroundColor('red')
      .padding(10)
      .margin({bottom:0})
      .layoutWeight(1)
    }
  }
  // 首页页脚 已经不用了
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