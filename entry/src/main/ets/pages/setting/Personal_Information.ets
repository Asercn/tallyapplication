import router from '@ohos.router'

@Entry
@Component
struct Personal_Information {
  build() {
    Row(){
      Column({space:10}){

        Row(){
          Image($r('app.media.ic_public_back'))
            .width(25)
            .onClick(()=>{
              router.back()
            })
          Blank()
          Text('个人信息')
            .fontSize('20fp')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)


        Row(){
          Text('头像')
            .fontSize(20)
            .margin({left:20})
          Blank()
          Image($r('app.media.profile_picture'))
            .width(100)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .borderRadius(25)
        .padding('6vp')
        .margin({top:'10vp',bottom:'6vp'})

        this.Item({title:'电话号码',text:'19580770225'})
        this.Item({title:'邮箱地址',text:'1733520092@qq.com'})
        this.Item({title:'地址',text:'test'})
        this.Item({title:'我的收藏',text:'xxxxxxxxx'})


      }
      .height('100%')


    }
    .padding(10)
    .backgroundColor('#f1f3f4')
  }

  @Builder Item($$:{title:string,text:string,}){
    Row(){
      Text($$.title)
        .fontSize(20)
        .margin({left:20})
      Blank()
      Text($$.text)
        .fontSize(18)
        .margin({left:20})
        .fontColor(Color.Gray)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
    .borderRadius(25)
    .padding(10)
  }
}


