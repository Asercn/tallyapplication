import BillService from '../../common/services/BillService'
import colorUtil from '../../common/utils/ColorUtil'
import DateUtil from '../../common/utils/DateUtil'
import DbUtil from '../../common/utils/DbUtil'
import Bill from '../../viewmodel/Bill'
import BillType from '../../viewmodel/BillType'
import GroupInfo from '../../viewmodel/GroupInfo'
import router from '@ohos.router'


@Component
export default struct detailsBillCard {
  @Link groupId:number

  @Consume values:GroupInfo<BillType,Bill>[]

  // @Consume billPanel:boolean


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
          ForEach(this.values,(group:GroupInfo<BillType,Bill>)=>{
            ListItem(){
              Column(){
                this.ListHead({title:group.type.name,sumValue:group.type.sumValue,budget:group.type.budget,color:group.type.color})
                List(){
                  ForEach(group.items,(item:Bill,index:number)=>{
                    ListItem(){
                      if (index === group.items.length-1){
                        Row(){
                          Column(){
                            Row(){
                              Text(`${item.label}`)
                              Blank()
                              Text(`${item.amount.toFixed(2)}`)
                                .fontColor(item.isExpend?$r('app.color.primary_color'):$r('app.color.contrast_primary_color'))
                            }
                            .width('100%')
                            Row(){
                              Text(`${DateUtil.formatDateMore(item.date)}`)
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
                              Text(`${item.label}`)
                              Blank()
                              Text(`${item.amount.toFixed(2)}`)
                                .fontColor(item.isExpend?$r('app.color.primary_color'):$r('app.color.contrast_primary_color'))
                            }
                            .width('100%')
                            Row(){
                              Text(`${DateUtil.formatDateMore(item.date)}`)
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
              }
            }
            .swipeAction({end:this.deleteButton({id:group.type.id})})
            .onClick(()=>{
              // 1.传回groupId
              this.groupId = group.type.id
              console.log('testTag','detailsBillCard','groupId',this.groupId)
              // 2.打开新增账单界面
              router.pushUrl({
                url:"pages/home/addBillPanel",
                params:{
                  groupId:this.groupId
                }
              })
            })
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


  // 删除组选项
  @Builder deleteButton($$:{id:number}){
    Row(){
      Button(){
        Image($r('app.media.delete'))
          .width(40)
      }
      .backgroundColor(Color.Transparent)
      .onClick((event: ClickEvent) => {
        // 删除该分组
        BillService.deleteBillType($$.id)
      })


    }
    .alignItems(VerticalAlign.Top)
    .height('100%')
    // .backgroundColor('red')
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

        Row({space:8}){

          if ($$.sumValue>$$.budget){
            Text(`超出预算:${$$.sumValue-$$.budget}`)
              .fontColor('#FFD700')
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .width('100%')
          }else{
            Blank()
            Text(`${$$.sumValue}/${$$.budget}元`)
              .fontSize(10)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bolder)
          }

        }
        // .width(`${$$.sumValue*100/$$.budget}%`)
        .width(`${$$.sumValue>$$.budget?100:$$.sumValue*100/$$.budget}%`)
        .height('100%')
        // .padding(10)
        .borderRadius(20)
        .backgroundColor($$.color)

        Stack(){
          Text(`${$$.title}`)
            .fontColor(Color.Gray)
            .fontSize(20)
            .offset({ y: 2 })
            .margin({left:10})
            .blur(2)
          Text(`${$$.title}`)
            .fontColor(colorUtil.getComplementaryColor($$.color))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({left:10})
        }


      }
      .alignContent(Alignment.Start)
      .height(50)
    }
  }

}