import {  HkCard, HkCardItem, HkNavBar } from 'basic'

@Entry
@Component
struct Setting {
  @State message: string = 'Hello World';

  build() {
    Column() {
      HkNavBar({navTitle:'系统设置'})
      Column(){
        HkCard(){
          HkCardItem({leftTile:'换绑手机'})
          HkCardItem({leftTile:'修改密码'})
          HkCardItem({leftTile:'消息通知设置'})
          HkCardItem({leftTile:'清理缓存'})
        }
      }
      .padding({ left: 10, right: 10 })
      .backgroundColor($r('app.color.white'))
      .margin({ left: 14.5, right: 14.5, top: 15 })
      .borderRadius(8)
      Row(){
        Button('退出')
          .width('100%')
          .margin({
            top:50
          })
          .type(ButtonType.Normal)
          .fontColor($r("app.color.text_primary"))
          .backgroundColor($r("app.color.white"))
          .borderRadius(6)
          .height(60)
      }
      .padding({
        left:15,
        right:15
      })
    }
    .backgroundColor($r('app.color.background_page'))
    .height('100%')
    .width('100%')

  }
}