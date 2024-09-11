import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
import { AdvertClass, userSetting} from 'basic'
const defaultAd:AdvertClass = {
  showAd:true,
  adTime:5,
  adUrl:'',
  adImg:$r('app.media.bg_listen')
}
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    userSetting.context = this.context
    //模拟请求
    const ad = await new Promise<AdvertClass> ((resolve)=> {
      setTimeout(() => {
        resolve(defaultAd)
      },500)
    })
    userSetting.setUserAd(ad)
    promptAction.showToast({message:JSON.stringify(ad)})

    const token = userSetting.getUserToken()
    if(token){

    }

    //朴素写法
    // if(ad.showAd){
    //   windowStage.loadContent('pages/Start/Start')
    // }else{
    //   windowStage.loadContent('pages/Index')
    // }
    //二级窗口写法
    if(ad.showAd){
      const window2 = await windowStage.createSubWindow('ad_window')
      await window2.showWindow()
      window2.setUIContent('pages/Start/Start')
    }
    windowStage.loadContent('pages/Index')


    // windowStage.loadContent('pages/Index', (err) => {
    //   if (err.code) {
    //     hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
    //     return;
    //   }
    //   hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    // });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
