import DateUtil from '../../common/utils/DateUtil';
import { BillTypeImages } from '../../model/BillTypeModels';
import BillService from '../../services/BillService';
import Bill from '../../viewmodel/Bill';

@Component
export default struct BudgetList {

  @Consume selectedType:string ; // 默认显示全部
  @Consume sumIncome:number
  @Consume sumExpenditure:number
  @Consume counter:number
  @Consume InCome:Bill[]  // 收入数据
  @Consume Expenditure:Bill[]  // 支出数据

  @Consume bills:Bill[]
  // @State filteredArr: Bill[] = this.bills;


  build() {
    Stack(){
      Column() {
        // 列表显示部分
        List() {
          ForEach(this.selectedType=='支出'?this.InCome:this.selectedType=='收入'?this.Expenditure:this.bills, (item:Bill) => {
            ListItem() {
              Row(){
                Row(){
                  Image(BillTypeImages[item.typeId].typeName).width(40)
                }

                Column() {
                  Row(){
                    Column({space:5}) {
                      Text(item.label).fontSize(20)
                      Text(` ${DateUtil.formatDateMore(item.date)}`).grayText() // 显示月份
                    }.alignItems(HorizontalAlign.Start)
                    Blank()
                    Column({space:5}){
                      if (item.isExpend) {
                        Text(`${item.amount}元`).fontSize(18)
                          .fontColor($r('app.color.primary_color'))
                        Text('支出')
                          .fontColor(Color.Gray)
                          .fontSize(12)

                      } else {
                        Text(`${item.amount}元`).fontSize(18)
                          .fontColor($r('app.color.contrast_primary_color'))
                        Text('收入')
                          .fontColor(Color.Gray)
                          .fontSize(12)
                      }
                    }
                  }
                  .padding(5)
                  .width('100%')
                  Divider().color('#cfcfcf').strokeWidth(1)
                }
                .layoutWeight(1)

              }

            }
            .swipeAction({end: this.DeleteButton(item.id)}) // 右划删除
          }, (item) => item.id) // 确保ForEach的键是唯一的
        }
      }
      .height(500)
      // .backgroundColor('green')
    }
  }

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
    this.bills = this.bills.filter((item) => item.id !== id); // 过滤掉要删除的项
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
    console.log('BudgetList', 'filteredArr after deletion:', JSON.stringify(this.bills));
    this.counter++;
    // this.getTotalAmount()
    // 确保 BudgetList 页面刷新
    // this.updateFilteredArr(); // 或者其他刷新页面的方法
    console.log('BudgetList','filteredArr',JSON.stringify(this.bills));
  }
}


@Extend(Text)
function grayText() {
  .fontSize(12)
  .fontColor(Color.Gray)
}