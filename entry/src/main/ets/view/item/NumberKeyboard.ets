
// @Preview
@Component
export default struct NumberKeyboard {
  numbers:string[] = ['1','2','3','4','5','6','7','8','9','0','.']

  @Link amount: number
  @Link value: string

  // amount: number = 0
  // value: string = ''

  @Styles keyBoxStyle(){
    .backgroundColor(Color.White)
    .borderRadius(8)
    .height(60)
  }

  build() {
    Grid(){
      ForEach(this.numbers,num=>{
        GridItem(){
          Text(num)
            .fontSize(20)
            .fontWeight(900)
        }
        .keyBoxStyle()
        .onClick(()=>this.clickNumber(num))

      })

      GridItem(){
        Text('删除')
          .fontSize(20)
          .fontWeight(900)
      }
      .keyBoxStyle()
      .onClick(()=>this.clickDelete())
    }
    .width('100%')
    .height(280)
    .backgroundColor('#F6F7Fb')
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .padding(8)
    .margin({top:10})
  }

  //定义输入数字的方法
  clickNumber(num:string){
    //1.拼接用户输入的内容
    let val = this.value + num
    //2.校验输入格式是否正确
    let firstIndex = val.indexOf('.')
    let lastIndex = val.lastIndexOf('.')
    if (firstIndex !== lastIndex || (lastIndex != -1 && lastIndex < val.length - 2)) {
      //非法输入
      return
    }
    //3.将字符串转为数值
    let amount = this.parseFloat(val)

    //4.保存
    if (amount >= 100000.00) {
      this.amount = 100000.00
      this.value = val
    }else {
      this.amount = amount
      this.value = val
    }

  }

  //删除数字
  clickDelete(){
    if (this.value.length <= 0) {
      this.value=''
      this.amount=0
      return
    }
    this.value = this.value.substring(0,this.value.length-1)
    this.amount = this.parseFloat(this.value)
  }

  //转换字符串为数字的方法
  parseFloat(str:string){
    if (!str) { //判断输入数值是否存在
      return 0
    }
    if (str.endsWith('.')) { //判断输入最后是否为小数点
      str = str.substring(0,str.length-1)
    }
    return parseFloat(str)
  }

}