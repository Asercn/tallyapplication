
import Bill from '../../viewmodel/Bill';

@Extend(Text)
function grayText() {
  .fontSize(14)
  .fontColor($r('app.color.dark_primary_color'))
}


@Component
export default struct BudgetList {
  // 共享状态，用于判断过滤的类型
  @Consume @Watch('updateFilteredArr') selectedType:string ; // 默认显示全部
  @State filteredArr: Array<any> = [];
  updateFilteredArr() {
    //console.log('updateFilteredArr','Budget')
    this.filteredArr = this.filterData(); // 在组件外部过滤数据
    console.log('testTag','BudgetList','filteredArr',JSON.stringify(this.filteredArr))
  }
  filterData:()=>Bill[]
  //从数据库中获取到所有的bill
  @Consume bills:Bill[]
  // 预先填充一些初始数据
  @State arr: { id: number, name: string, amount: number, month: number }[] = [
    { id: 1, name: '食品', amount: -150, month: 5 }, // 1 表示一月
    { id: 2, name: '租金', amount: -800, month: 5 },
    { id: 3, name: '交通', amount: -60, month: 4 },
    { id: 4, name: '红包', amount: 60, month: 5 },
    { id: 5, name: '红包', amount: 130, month: 5 },
    { id: 6, name: '红包', amount: 140, month: 5 },
    { id: 7, name: '红包', amount: 150, month: 5 },
    { id: 8, name: '红包', amount: 160, month: 5 },
    { id: 9, name: '红包', amount: 170, month: 5 },
    { id: 10, name: '红包', amount: 180, month: 5 },

  ];

  @State newName: string = '';
  @State newAmount: number = 0;
  @State newMonth: number = 1; // 用于存储输入的月份
  @State isDialogVisible: boolean = false; // 用于显示/隐藏对话框

  // 删除按钮构建器
  @Builder DeleteButton(id: number) {
    Button({ type: ButtonType.Normal }) {
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.Red)
        .margin(5)
    }
    .height(80)
    .onClick(() => this.deleteItem(id))
    .backgroundColor(Color.Transparent)
  }



  // 添加新项
  addItem(name: string, amount: number, month: number) {
    const newId = this.arr.length > 0 ? this.arr[this.arr.length - 1].id + 1 : 1;
    this.arr.push({ id: newId, name, amount, month });
  }
  // 删除列表项
  deleteItem(id: number) {
    this.filteredArr = this.filteredArr.filter((item) => item.id !== id); // 过滤掉要删除的项
  }


  aboutToAppear(){
  }


  build() {
    Stack(){
      Row() {
        Blank()
        Button("＋") // 这是加号按钮
          .onClick(() => {
            this.isDialogVisible = true
          }) // 点击后显示对话框
      }.padding(10).height(50).position({x:'50%',y:'88%'}).zIndex(10)
      .translate({x:'-50%',y:'-100%'})
      Column() {
        // 列表显示部分
        List({ initialIndex: 0 }) {
          ForEach(this.filteredArr, (item:Bill) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.label).fontSize(20)
                  Text(`月份: ${new Date(item.date).getMonth()+1}`).fontSize(14).grayText() // 显示月份
                }
                Blank()
                Text(`${item.amount}元`).fontSize(18)
              }
              .padding(10)
              .width('100%')
              .height(80)
            }
            .swipeAction({ end: this.DeleteButton(item.id) }) // 右划删除
          }, (item) => item.id) // 确保ForEach的键是唯一的
        }.divider({ strokeWidth: 1, startMargin: 20, endMargin: 20, color: '#ffe9f0f0' })
        .height(600)


        // 添加新项的对话框
        // 如果对话框可见，显示覆盖层
        if (this.isDialogVisible) {
          Column() {
            // 背景半透明遮罩
            Blank()
              .backgroundColor('#000000')
              .opacity(0.5) // 半透明背景
              .width('100%')
              .height('100%')
              .position({ x: 0, y: 0 }) // 覆盖整个布局
              .onClick(() => this.isDialogVisible = false) // 点击背景关闭对话框

            // 对话框内容
            Column() {
              Text("添加新项").fontSize(18)
              TextInput({ placeholder: '名称' })
                .onChange((value) => this.newName = value)
              TextInput({ placeholder: '金额' })
                .onChange((value) => this.newAmount = parseFloat(value))
              TextInput({ placeholder: '月份' })
                .onChange((value) => this.newMonth = parseInt(value, 10))

              Row() {
                Button("取消")
                  .onClick(() => this.isDialogVisible = false) // 关闭对话框
                Button("添加")
                  .onClick(() => {
                    if (this.newName && this.newAmount &&this.newMonth) {
                      this.addItem(this.newName, this.newAmount, this.newMonth);
                      this.isDialogVisible = false; // 关闭对话框
                    }
                  })
              }
            }
            .padding(20)
            .backgroundColor('#ffffff') // 对话框的背景色
            .border({ color: '#cccccc', width: 1 }) // 对话框的边框
            .position({ x: 'center', y: 'center' }) // 对话框居中
          }
          .position({ x: 0, y: 0 }) // 将整个覆盖层放在整个布局的顶部
          .zIndex(10) // 确保它在最前面
        }
      }
    }
  }
}



