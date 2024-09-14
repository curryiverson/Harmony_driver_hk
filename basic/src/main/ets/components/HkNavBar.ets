import { router } from '@kit.ArkUI'

@Preview
@Component
struct HkNavBar {
  showBackIcon:boolean = true
  navTitle:string = ''
  build() {
    RelativeContainer(){
      if(this.showBackIcon){
        Image($r("app.media.ic_btn_nav_back"))
          .width(44)
          .aspectRatio(1)
          .alignRules({
            left:{
              anchor:'__container__',
              align:HorizontalAlign.Start
            },
            center:{
              anchor:'__container__',
              align:VerticalAlign.Center
            }
          })
          .onClick(() => {
            router.back()
          })
      }
      Text(this.navTitle)
        .alignRules({
          middle:{
            anchor:'__container__',
            align:HorizontalAlign.Center
          },
          center:{
            anchor:'__container__',
            align:VerticalAlign.Center
          }
        })
    }
    .height(50)
    .backgroundColor($r("app.color.white"))
    .width("100%")
  }
}
export {HkNavBar}