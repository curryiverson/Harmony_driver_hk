import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
import { AdvertClass, userSetting, USER_SETTING_TOKEN} from 'basic'
const defaultAd:AdvertClass = {
  showAd:false,
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
    // promptAction.showToast({message:JSON.stringify(ad)})

    const token = userSetting.getUserToken()
    AppStorage.setOrCreate(USER_SETTING_TOKEN, token)

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
    promptAction.showToast({message: JSON.stringify(token)})
    if (token) {
      await windowStage.loadContent('pages/Index/index'); // 跳到主页
    } else {
      await windowStage.loadContent('pages/Login/login'); // 跳到登录页
    }


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
