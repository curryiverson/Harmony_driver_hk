import { login } from '../../api'
import { loginModel } from '../../viewmodels'
import { promptAction, router } from '@kit.ArkUI'
import { userSetting, USER_SETTING_TOKEN } from 'basic'

@Entry
@Component
struct Login {
  @Styles
  loginStyle() {
    .backgroundColor('#fff')
    .border({ color: $r('app.color.background_divider'), width: { bottom: 1 } })
    .width('100%')
    .height(58)
    .borderRadius(0)
  }
  @State
  showLoading :boolean = false
  @State
  loginForm:loginModel = {
    account:'',
    password:'',
  }

  //校验登录数据
  getFormValidate(){
    if(this.loginForm.account && this.loginForm.password){
      return true
    }
    return false
  }

  async login(){
    try {
      this.showLoading = true
      const token = await login(this.loginForm)
      // 写入首选项
      userSetting.setUserToken(token)
      // 写入内存
      AppStorage.setOrCreate(USER_SETTING_TOKEN, token)
      router.replaceUrl({
        url: "pages/Index/index"
      })

      promptAction.showToast({ message: '登录成功' })
    }catch (error){

    } finally {
      this.showLoading = false
    }
  }

  build() {
    Column() {
      // 顶部标题
      Text("小时达").fontColor($r('app.color.text_primary')).fontSize(18).height(25)
      // 账号登录
      Row() {
        Text('账号登录').fontColor($r('app.color.text_primary')).fontSize(24).fontWeight(FontWeight.Bold)
        Row() {
          Text("手机号登录").fontColor($r('app.color.primary')).fontSize(16).fontWeight(FontWeight.Bold)
          Image($r("app.media.ic_angle")).width(10).height(10).margin({ left: 5 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 50, bottom: 50 })

      // 用户名输入框
      TextInput({ placeholder: '请输入账号', text: this.loginForm.account })
        .loginStyle()
        .onChange((value) => {
          this.loginForm.account = value
        })

      // 密码框
      TextInput({ placeholder: '请输入密码',text: this.loginForm.password })
        .loginStyle()
        .type(InputType.Password) // 密码框
        .showPasswordIcon(true) // 显示密码按钮
        .onChange((value) => {
          this.loginForm.password = value
        })

      // 登录按钮
      Button({ type: ButtonType.Capsule }) {
        Row() {
          if(this.showLoading){
            LoadingProgress().width(20).height(20).margin({ right: 12 }).color($r('app.color.white'))
          }
          Text('登录').fontColor($r('app.color.white'))
        }
      }
      .enabled(this.getFormValidate())
      .backgroundColor($r('app.color.primary'))
      .width('100%')
      .height(50)
      .margin({ top: 50 })
      .onClick(() => {
        this.login()
      })
    }
    .padding({ left: 32, right: 32 })
    .margin({ top: 40 })
  }
}