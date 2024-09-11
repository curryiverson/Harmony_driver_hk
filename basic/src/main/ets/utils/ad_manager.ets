import { AdvertClass } from '../viewmodels'
import { ComponentContent, promptAction, window } from '@kit.ArkUI'
import { util } from '@kit.ArkTS'

// 展示广告的结构最重要写的代码
@Builder
function AdBuilder(ad: AdvertClass) {
  Column() {
    Image(ad.adImg)
      .width("100%")
      .height("100%")
      .objectFit(ImageFit.Cover)
      .borderRadius(10)

    Row() {
      Image($r("app.media.ic_btn_close"))
        .width(14)
        .aspectRatio(1)
        .fillColor("#ccc")
    }
    .width(30)
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .borderRadius(15)
    .border({
      color: '#ff343232',
      width: 2
    })
    .margin({
      top: 40
    })
    .onClick(() => {
      if (ad.dialogName) {
        adManagerFinal.closeAd(ad.dialogName) //  ? name从哪里进来
      }

    })

  }
  .width(ad.isFull ? "100%" : "80%")
  .height(ad.isFull ? "100%" : "50%")
}

export class AdManagerFinal {
  context?: Context
  // 所有的弹窗都放到这个map中 通过name来标识
  private map: Map<string, ComponentContent<AdvertClass>> = new Map()

  // 实际上需要广告
  async showAd(ad: AdvertClass) {
    // 按照文档实现
    // UIContext上下文必须得等到页面初始化之后才可以进行获取
    // 生成一个name
    let name = `dialog_${util.generateRandomUUID()}`
    // 通过当前的主窗口来获取
    const mainWin = await window.getLastWindow(this.context || getContext())
    let uiContext = mainWin.getUIContext() // 拿到UIContext
    let promptAction = uiContext.getPromptAction();
    ad.dialogName = name // 目的是将dialog的弹窗名称传递到builder中
    let contentNode = new ComponentContent(uiContext, wrapBuilder(AdBuilder), ad);
    let options: promptAction.BaseDialogOptions = {
      alignment: DialogAlignment.Center,
      autoCancel: false
    };
    this.map.set(name, contentNode) // 将key/value写入到map中
    promptAction.openCustomDialog(contentNode, options);

    if (ad.isFull) {
      // 如果是全屏 那么自动倒计时自动关闭
      // 一般半屏广告 是得用户手动点击才能关闭的 一般不会自动关闭
      setTimeout(() => {
        promptAction.closeCustomDialog(contentNode)
      }, ad.adTime * 1000)
    }


  }

  async closeAd(name: string) {
    if (name) {
      const mainWin = await window.getLastWindow(this.context || getContext())
      let uiContext = mainWin.getUIContext() // 拿到UIContext
      let promptAction = uiContext.getPromptAction();
      promptAction.closeCustomDialog(this.map.get(name))
      // 清理map
      this.map.delete(name) // 删除已经关闭的弹窗
    }
  }
}

export const adManagerFinal = new AdManagerFinal()