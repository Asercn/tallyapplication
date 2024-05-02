class ColorUtil{
  //生成随机颜色的rgb
  getRandomColor(){
    let r = Math.floor(Math.random()*256)
    let g = Math.floor(Math.random()*256)
    let b = Math.floor(Math.random()*256)
    return {r:r,g:g,b:b}
  }

  getRandomColorHex(){
    let r = Math.floor(Math.random()*256)
    let g = Math.floor(Math.random()*256)
    let b = Math.floor(Math.random()*256)
    let hex:string = this.rgbToHex(r,g,b)
    return hex
  }

  /**
   * 获取互补色
   * @param color 传入16位颜色值
   * @returns
   */
  getComplementaryColor(color:string):string {
  // 解析颜色值
  var hex = color.replace('#', '');
  var r = parseInt(hex.substring(0, 2), 16);
  var g = parseInt(hex.substring(2, 4), 16);
  var b = parseInt(hex.substring(4, 6), 16);

  // 计算互补色
  var compR = (255 - r).toString(16);
  var compG = (255 - g).toString(16);
  var compB = (255 - b).toString(16);

  // 确保十六进制字符串始终是两位
  compR = compR.length === 1 ? '0' + compR : compR;
  compG = compG.length === 1 ? '0' + compG : compG;
  compB = compB.length === 1 ? '0' + compB : compB;

  // 返回互补色
  return '#' + compR + compG + compB;
}

  // 将RGB颜色转换为十六进制颜色代码
  rgbToHex(r, g, b) {
    return '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
  }
}

let colorUtil = new ColorUtil()
export default colorUtil as ColorUtil