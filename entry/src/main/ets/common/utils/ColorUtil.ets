class ColorUtil{
  //生成随机颜色的rgb
  getRandomColor(){
    let r = Math.floor(Math.random()*256)
    let g = Math.floor(Math.random()*256)
    let b = Math.floor(Math.random()*256)
    return {r:r,g:g,b:b}
  }

  // 将RGB颜色转换为十六进制颜色代码
  rgbToHex(r, g, b) {
    return '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
  }
}

let colorUtil = new ColorUtil()
export default colorUtil as ColorUtil