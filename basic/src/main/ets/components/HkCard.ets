/*
 * 封装的Card组件，配合cardItem组件使用
 *
 * */
@Component
struct HkCard {
  @BuilderParam
  HkCardFn: ()=> void
  build() {
    Column() {
      Column(){
        //插槽
        if(this.HkCardFn){
          this.HkCardFn()
        }
      }
      .backgroundColor($r('app.color.white'))
      .width('100%')
      .backgroundColor($r('app.color.white'))
      .padding({
        left:10,
        right:10
      })
    }
    .width('100%')
  }
}
export { HkCard }