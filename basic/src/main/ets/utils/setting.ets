import { preferences } from '@kit.ArkData'
import { USER_SETTING, USER_SETTING_AD, USER_SETTING_TOKEN } from '../constants'
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
  //获取token
  async setUserToken(token:string){
    const store = this.getStore()
    store.putSync(USER_SETTING_TOKEN, token)
    await store.flush()
  }
  getUserToken(){
    const store = this.getStore()
    return store.getSync(USER_SETTING_TOKEN, '')
  }
}
export const userSetting = new UserSetting()