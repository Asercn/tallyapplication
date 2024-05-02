class DateUtil{


  formatDate(num: number): string{
    let date = new Date(num)
    let year = date.getFullYear()
    let month = date.getMonth()+1
    let day = date.getDate()
    let m = month < 10 ? '0' + month : month
    let d = day < 10 ? '0' + day : day
    return `${year}/${m}/${d}`
  }

  beginTimeOfDay(date: Date){
    let d = new Date(date.getFullYear(), date.getMonth(), date.getDate())
    return d.getTime()
  }


  getWeek(date:Date):number{
    let today:any = new Date(date)
    // 获取到本月的第一天
    let firstDayOfMonth:any = new Date(today.getFullYear(), today.getMonth(), 1);
    // 获取本月的第一周的第一天（如果本月的第一天不是周一，则向前推移直到找到周一）
    while (firstDayOfMonth.getDay() !== 1) {
      firstDayOfMonth.setDate(firstDayOfMonth.getDate() - 1);
    }

    // 计算今天距离本月第一周的天数
    let daysSinceFirstWeek:number = Math.floor((today - firstDayOfMonth) / (1000 * 60 * 60 * 24));
    // 计算今天是本月的第几周
    var weekNumber:number = Math.ceil((daysSinceFirstWeek + 1) / 7);
    return weekNumber;

  }
}

let dateUtil = new DateUtil()

export default dateUtil as DateUtil