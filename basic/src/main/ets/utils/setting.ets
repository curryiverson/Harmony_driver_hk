import { preferences } from '@kit.ArkData'
import { USER_SETTING, USER_SETTING_AD } from '../constants'
import { AdvertClass } from '../viewmodels'

const defaultAd:AdvertClass = {
  showAd:false,
  adTime:5,
  adUrl:'',
  adImg:''
}

//负责首选项读取
export class UserSetting  {
  context?: Context
  //获取仓库
  getStore(){
    return preferences.getPreferencesSync(this.context || getContext(),{
      name: USER_SETTING
    })
  }
  //获取用户广告
  getUserAd(){
    const store = this.getStore()
    return store.getSync(USER_SETTING_AD, defaultAd) as AdvertClass
  }

  //设置用户广告
  async setUserAd(ad:AdvertClass){
    const store = this.getStore()
    store.putSync(USER_SETTING_AD,ad)
    await store.flush()
  }
}
export const userSetting = new UserSetting()