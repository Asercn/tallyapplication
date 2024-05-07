import DateUtil from '../../common/utils/DateUtil';
import BillService from '../../services/BillService';
import Bill from '../../viewmodel/Bill';


@Extend(Text)
function grayText() {
  .fontSize(12)
  .fontColor(Color.Gray)
}

@Component
export default struct BudgetList {
  @Consume @Watch('updateFilteredArr') currentIndex:number
  updateFilteredArr() {
    //console.log('updateFilteredArr','Budget')
    this.filteredArr = this.filterData(); // 在组件外部过滤数据
    console.log('testTag','BudgetList','filteredArr',JSON.stringify(this.filteredArr))
  }
  filterData:()=>Bill[]
  // 共享状态，用于判断过滤的类型
  @Consume @Watch('updateFilteredArr') selectedType:string ; // 默认显示全部
  @Consume sumIncome:number
  @Consume sumExpenditure:number
  @Consume @Watch('getTotalAmount') counter:number
  // @Consume newMonth:string

  @State filteredArr: Array<any> = [];

  //从数据库中获取到所有的bill
  @Consume bills:Bill[]


  // 删除按钮构建器
  @Builder DeleteButton(id: number) {
    Button({ type: ButtonType.Normal }) {
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.Red)
        .margin(5)
    }
    .height(80)
    .onClick(() => {
      this.deleteItem(id)
      this.counter++
    })
    .backgroundColor(Color.Transparent)
  }

  // 删除列表项
  deleteItem(id: number) {
    this.filteredArr = this.filteredArr.filter((item) => item.id !== id); // 过滤掉要删除的项
    //删除数据库里的数据
    this.bills = this.bills.filter((item) => item.id !== id);
    // 假设有一个服务方法用于从数据库中删除数据
    BillService.delete(id)
      .then(() => {
        console.log('BudgetList', 'Deleted item with ID:', id);
      })
      .catch((error) => {
        console.error('BudgetList', 'Error deleting item:', error);
      });

    // 打印删除后的 filteredArr
    console.log('BudgetList', 'filteredArr after deletion:', JSON.stringify(this.filteredArr));
    this.counter++;
    this.getTotalAmount()
    // 确保 BudgetList 页面刷新
    this.updateFilteredArr(); // 或者其他刷新页面的方法
    console.log('BudgetList','filteredArr',JSON.stringify(this.filteredArr));
  }

  getTotalAmount() {
    // BillService.list().then(bills=>{
    //   this.bills = bills.map(bill=>{
    //     if (this.selectedType == '收入' && !bill.isExpend) {
    //       return bill
    //     }else if (this.selectedType == '支出' && bill.isExpend) {
    //       return bill
    //     } else {
    //       return
    //     }
    //   })
    // })

    let income = 0;
    let expenditure = 0;
    // 计算支出和收入
    this.filteredArr.forEach((item) => {
      if (item.isExpend) {
        expenditure += item.amount; // 支出
      } else {
        income += item.amount; // 收入
      }
    });
    this.sumExpenditure = expenditure
    this.sumIncome = income
  }

  aboutToAppear(){
    // this.updateFilteredArr()
  }

  build() {
    Stack(){
      Column() {
        // 列表显示部分
        List({ initialIndex: 0 }) {
          ForEach(this.filteredArr, (item:Bill) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.label).fontSize(20)
                  Text(` ${DateUtil.formatDateMore(item.date)}`).grayText() // 显示月份
                }
                Blank()
                Text(`${item.amount}元`).fontSize(18)
              }
              .padding(10)
              .width('100%')
              .height(80)
            }
            .swipeAction({end: this.DeleteButton(item.id)}) // 右划删除
          }, (item) => item.id) // 确保ForEach的键是唯一的
        }.divider({strokeWidth:1,startMargin:20,endMargin:20,color:'#ffe9f0f0'})
        .height(600)
      }
    }
  }
}


// 预先填充一些初始数据
// @State arr: { id: number, name: string, amount: number, month: number }[] = [
//   { id: 1, name: '食品', amount: -150, month: 5 }, // 1 表示一月
// ];

// 添加新项的对话框
// 如果对话框可见，显示覆盖层
// if (this.isDialogVisible) {
//   Column() {
//     // 背景半透明遮罩
//     Blank()
//       .backgroundColor('#000000')
//       .opacity(0.5) // 半透明背景
//       .width('100%')
//       .height('100%')
//       .position({ x: 0, y: 0 }) // 覆盖整个布局
//       .onClick(() => this.isDialogVisible = false) // 点击背景关闭对话框
//
//     // 对话框内容
//     Column() {
//       Text("添加新项").fontSize(18)
//       TextInput({ placeholder: '名称' })
//         .onChange((value) => this.newName = value)
//       TextInput({ placeholder: '金额' })
//         .onChange((value) => this.newAmount = parseFloat(value))
//       TextInput({ placeholder: '月份' })
//         .onChange((value) => this.newMonth = parseInt(value, 10))
//
//       Row() {
//         Button("取消")
//           .onClick(() => this.isDialogVisible = false) // 关闭对话框
//         Button("添加")
//           .onClick(() => {
//             if (this.newName && this.newAmount &&this.newMonth) {
//               this.addItem(this.newName, this.newAmount, this.newMonth);
//               this.isDialogVisible = false; // 关闭对话框
//             }
//           })
//       }
//     }
//     .padding(20)
//     .backgroundColor('#ffffff') // 对话框的背景色
//     .border({ color: '#cccccc', width: 1 }) // 对话框的边框
//     .position({ x: 'center', y: 'center' }) // 对话框居中
//   }
//   .position({ x: 0, y: 0 }) // 将整个覆盖层放在整个布局的顶部
//   .zIndex(10) // 确保它在最前面
// }

// Row() {
//   Blank()
//   Button("＋") // 这是加号按钮
//     .onClick(() => {
//       this.isDialogVisible = true
//     }) // 点击后显示对话框
// }.padding(10).height(50).position({x:'50%',y:'88%'}).zIndex(10)
// .translate({x:'-50%',y:'-100%'})

// 添加新项
// addItem(name: string, amount: number, month: number) {
//   const newId = this.arr.length > 0 ? this.arr[this.arr.length - 1].id + 1 : 1;
//   this.arr.push({ id: newId, name, amount, month });
// }

// @State newName: string = '';
// @State newAmount: number = 0;
// @State newMonth: number = 1; // 用于存储输入的月份
// @State isDialogVisible: boolean = false; // 用于显示/隐藏对话框

