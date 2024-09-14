/*
 * 封装的cardItem组件，配合Card组件使用
 *
 * */
@Preview
@Component
struct HkCardItem {
  leftTile:string = '123' //左侧标题
  isShowRightIcon:boolean = true //是否显示右边箭头
  isShowBottomBorder: boolean = true //是否显示下边框
  onRightClick:() => void = () => {} //右边点击的方法
  @Prop
  rightTitle:string = '' //右侧内容

  build() {
    Row(){
      //左侧标题
      Text(this.leftTile).fontSize(16).fontWeight(400).fontColor($r('app.color.text_primary'))
      //右侧内容
      Row(){
        if(this.rightTitle){
          Text(this.rightTitle).fontSize(16).fontWeight(400).fontColor($r('app.color.text_primary'))
        }
        if(this.isShowRightIcon){
          Image($r("app.media.ic_btn_more")).width(24).height(24)
        }
      }.onClick(() => {
        this.onRightClick()
      })
    }
    .height(60)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .border({
      width:{
        bottom: this.isShowBottomBorder ? 1 : 0
      },
      color:$r('app.color.background_divider')
    })
  }
}
export { HkCardItem }