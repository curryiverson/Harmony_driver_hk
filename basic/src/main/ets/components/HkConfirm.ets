/*
 * 封装确认弹窗
 * */
@CustomDialog
struct HkConfirm {
  controller: CustomDialogController //定义控制器
  message: string = ''
  buttons: HkConfirmButton[] = [
    {
      text: '确定',
      fontSize: 14,
      fontColor: $r("app.color.primary")
    }
  ]
  build() {
    Column(){
      Row(){
        Text(this.message)
          .fontSize(16)
          .fontColor($r("app.color.text_primary"))
      }
      .height(88)
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .border({
        color: $r("app.color.background_divider"),
        width: {
          bottom: this.buttons.length ? 1 : 0
        }
      })
      Row(){
        ForEach(this.buttons, (item:HkConfirmButton, index:number) => {
          Text(item.text)
            .fontColor(item.fontColor || $r("app.color.text_secondary"))
            .fontSize(item.fontSize || 16)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .height("100%")
            .border({
              color: $r("app.color.background_divider"),
              width: {
                right: (index === this.buttons.length - 1) ? 0 : 1  // 只有一个按钮时不加 如果是最后一个不佳
              }
            })
            .onClick(() => {
              if(item.action){
                item.action()
              }
              this.controller.close()
            })
        })
      }
      .height(50)
    }
    .backgroundColor($r("app.color.white"))
    .borderRadius(12)
    .width(280)
  }
}

class HkConfirmButton {
  text: string = ""
  fontColor?: ResourceStr = $r("app.color.text_secondary")
  fontSize?: number = 16
  action?: () => void
}

export {HkConfirm, HkConfirmButton}