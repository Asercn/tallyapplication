
@Preview
@Component
export default struct Header{
  build(){
    Row(){
      Image($r('app.media.ic_public_back')).width(24)
      Text('账单').fontWeight(FontWeight.Bold)
      Text('常见问题')
    }.justifyContent(FlexAlign.SpaceBetween).width('98%')
    .border({width:2,radius:10})
  }
}