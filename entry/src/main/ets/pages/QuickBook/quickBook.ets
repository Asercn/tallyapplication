import {BillTypeImages, BillTypeNames} from '../../model/BillTypeModels'
import router from '@ohos.router'
import BillService from '../../services/BillService'
import DateUtil from '../../common/utils/DateUtil'


@Entry
@Component
struct QuickBook {
  @State amount:number = 0
  @State label:string = ''
  @State isExpend:boolean = true
  @State typeId:number = 6
  @State date:number = new Date().getTime()
  groupId:number
aboutToAppear(){
  let params = router.getParams()
  if (params) {
    this.groupId = params['groupId']
  }

  console.log('testTag','quickBook','groupId',this.groupId)
}

  build() {
    Scroll(){
      Column({space:20}){
        Row(){
          Text('快速记账')
            .fontSize(22)
        }

        Row(){
          Text('账单描述')
            .width('25%')
            .textAlign(TextAlign.End)
          TextInput({placeholder:'账单描述'})
            .onChange(value=>{
              this.label = value
            })
        }
        Row(){
          Text('金额')
            .width('25%')
            .textAlign(TextAlign.End)
          TextInput({placeholder:'金额'})
            .type(InputType.Number)
            .onChange(value=>{
              let val = parseFloat(value)
              if (isNaN(val)) {
                val = 0
              }
              this.amount = val
            })
        }

        Row(){
          Row(){
            Text('金额类型')
              .textAlign(TextAlign.End)
              .width('100%')
          }
          .width('25%')

          // 单选框
          Row({space:20}){
            Row(){
              Text('支出')
              Radio({value:`支出`,group:'type'})
                .checked(true)
                .onChange((isCheck)=>{
                  this.isExpend = true
                })
            }
            Row(){
              Text('收入')
              Radio({value:`收入`,group:'type'})
                .checked(false)
                .onChange((isCheck)=>{
                  this.isExpend = false
                })
            }
          }
          .width('75%')
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')

        // 日期/时间
        Row(){
          Column({space:10}){
            Row(){
              Text('日期/时间:')
                .textAlign(TextAlign.End)
                .width('25%')
              Text(DateUtil.formatDateMore(this.date))
                .textAlign(TextAlign.Center)
                .width('75%')
            }
            .width('100%')
            Row({space:30}){
              Button('选择日期')
                .backgroundColor($r('app.color.primary_color'))
                .onClick((event: ClickEvent) => {
                  DatePickerDialog.show({
                    selected:new Date(this.date),
                    onAccept:(value)=>{
                      let y = value.year
                      let m = value.month+1
                      let d = value.day
                      let h = new Date(this.date).getHours()
                      let mi = new Date(this.date).getMinutes()
                      let s = new Date(this.date).getSeconds()
                      let date = new Date(`${y}-${m}-${d} ${h}:${mi}:${s}`)
                      console.log('testTag','quickBook','date',JSON.stringify(DateUtil.formatDateMore(date.getTime())))
                      this.date = date.getTime()
                    }
                  })
                })
              Button('选择时间')
                .backgroundColor($r('app.color.primary_color'))
                .onClick((event: ClickEvent) => {
                  TimePickerDialog.show({
                    selected:new Date(this.date),
                    useMilitaryTime:true,
                    onAccept:(value)=>{
                      let y = new Date(this.date).getFullYear()
                      let m = new Date(this.date).getMonth()+1
                      let d = new Date(this.date).getDate()
                      let h = value.hour
                      let mi = value.minute
                      let s = new Date(this.date).getSeconds()
                      let date = new Date(`${y}-${m}-${d} ${h}:${mi}:${s}`)
                      console.log('testTag','quickBook','time',JSON.stringify(date))
                      this.date = date.getTime()
                    },
                  })
                })
            }
            .justifyContent(FlexAlign.Center)
            .width('75%')
          }
          .width('100%')
        }
        .width('100%')

        // 类型选择
        Row(){
          Text('类型选择  ')
          Image(BillTypeImages[this.typeId].typeName)
            .width(30)
          Select([
            {value:BillTypeNames[0].typeName,icon:BillTypeImages[0].typeName},
            {value:BillTypeNames[1].typeName,icon:BillTypeImages[1].typeName},
            {value:BillTypeNames[2].typeName,icon:BillTypeImages[2].typeName},
            {value:BillTypeNames[3].typeName,icon:BillTypeImages[3].typeName},
            {value:BillTypeNames[4].typeName,icon:BillTypeImages[4].typeName},
            {value:BillTypeNames[5].typeName,icon:BillTypeImages[5].typeName},
            {value:BillTypeNames[6].typeName,icon:BillTypeImages[6].typeName}
          ])
            .selected(6) //默认选择的下标
            .value('其它')
            .onSelect((index?: number,value?:string) => {
              console.info('Select:' + index)
              this.typeId = index;
            })
        }

        Row({space:20}){
          Button('提交')
            .backgroundColor($r('app.color.primary_color'))
            .onClick((event: ClickEvent) => {
              BillService.insert(this.label,this.amount,new Date(this.date),this.isExpend,this.groupId,this.typeId).then(rep=>{
                this.groupId = null
                this.amount = 0
                this.label = ''
                this.isExpend = true
                this.typeId = 6
                this.date = new Date().getTime()
                router.pushUrl({
                  url: "pages/Index"
                },router.RouterMode.Single)
              })
            })
          Button('返回')
            .backgroundColor($r('app.color.dark_contrast_primary_color'))
            .onClick((event: ClickEvent) => {
              router.pushUrl({
                url: "pages/Index"
              },router.RouterMode.Single)
            })
        }

      }
      .padding(10)
      .width('100%')
      .height('100%')
    }
  }



}

