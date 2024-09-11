import { AdvertClass, userSetting } from 'basic';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct Start {
  @State adMessage:AdvertClass = {showAd: false, adTime: 0}
  timer:number = -1
  aboutToAppear(): void {
    this.adMessage = userSetting.getUserAd()
    // promptAction.showToast({message:JSON.stringify(this.adMessage)})

    this.timer = setInterval(() => {
      if(this.adMessage.adTime === 1){
        this.toMain()
      }
      this.adMessage.adTime--
    },1000)
  }
  toMain(){
    clearInterval(this.timer)
    router.replaceUrl({url:'pages/Index/index'})
  }
  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image(this.adMessage.adImg)
        .width('100%')
      Row(){
        Text(`${this.adMessage.adTime}秒`)
        Text('跳过')
          .onClick(() => {
            this.toMain()
          })
      }
      .backgroundColor($r('app.color.background_page'))
      .margin({
        top:60,
        right:20
      })
      .padding({
        top:4,
        bottom:4,
        left:10,
        right:10
      })
    }
    .height('100%')
    .width('100%')
  }
}