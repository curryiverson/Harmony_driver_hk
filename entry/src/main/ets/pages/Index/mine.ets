import {  HkCard, HkCardItem } from 'basic'
import { getUser } from '../../api'
import { UserInfoModel } from '../../viewmodels'
import { promptAction, router } from '@kit.ArkUI'

@Preview
@Component
struct Mine {
  @Prop
  @Watch('changeName')
  currentName:string = ''
  @State
  userInfo: UserInfoModel = new UserInfoModel({
    avatar: "",
    name: "",
    number: "",
    phone: ""
  })
  async getUserInfo(){
    this.userInfo = await getUser()
    promptAction.showToast({message:JSON.stringify(this.userInfo)})
  }
  changeName(){
    if(this.currentName === 'mine'){
      this.getUserInfo()
    }
  }


  aboutToAppear(): void {
    this.getUserInfo()
  }
  build() {
    Column(){
      // 基本信息
      Column() {
        Image(this.userInfo.avatar || ("app.media.ic_avatar_driver"))
          .width(67)
          .height(67)
          .borderRadius(34.5)
          .backgroundColor($r('app.color.white'))
        Text(this.userInfo.name || "司机")
          .fontSize(18)
          .fontWeight(600)
          .lineHeight(25)
          .margin({
            top: 9,
            bottom: 9
          })
          .fontColor($r('app.color.white'))
        Text(`司机编号: ${this.userInfo.number}`).fontSize(14).fontWeight(400).lineHeight(20).fontColor($r('app.color.white'))
        Text(`手机号: ${this.userInfo.phone}`)
          .fontSize(14)
          .fontWeight(400)
          .lineHeight(20)
          .margin({
            top: 10
          })
          .fontColor($r('app.color.white'))
      }
      .backgroundImage($r("app.media.bg_page_my"))
      .backgroundImageSize(ImageSize.Cover)
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height(292)
      .margin({
        top: -2
      })

      // 本月任务
      Column() {
        Text("- 本月任务 -").fontSize(14).fontColor($r('app.color.text_secondary')).lineHeight(20)
        Row() {
          Column() {
            Text("1000").fontSize(18).fontColor($r('app.color.text_primary')).lineHeight(25).margin({
              bottom: 17
            })
            Text("任务总量").fontSize(12).fontColor($r('app.color.text_primary')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)

          Column() {
            Text("1000")
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })
            Text("完成任务量").fontSize(12).fontColor($r('app.color.text_primary')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)

          Column() {
            Text("1000")
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })
            Text("运输里程(km)").fontSize(12).fontColor($r('app.color.text_primary')).lineHeight(17)
          }.justifyContent(FlexAlign.SpaceAround).layoutWeight(1)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').layoutWeight(1)
      }
      .backgroundColor($r('app.color.white'))
      .borderRadius(8)
      .margin({ left: 14.5, right: 14.5, top: -55, bottom: 15 })
      .height(134)
      .padding({ top: 13.5, bottom: 13.5 })
      .justifyContent(FlexAlign.SpaceBetween)

      // 信息列表
      Column() {
        HkCard(){
          HkCardItem({ leftTile: '车辆信息' })
          HkCardItem({ leftTile: '任务设置'})
          HkCardItem({ leftTile: '系统设置' , isShowBottomBorder: false , onRightClick: () => {
            router.pushUrl({url:'pages/Setting/Setting'})
          }})

        }
      }
      .padding({ left: 10, right: 10 })
      .backgroundColor($r('app.color.white'))
      .margin({ left: 14.5, right: 14.5, bottom: 15 })
      .borderRadius(8)

    }.width('100%').height('100%').backgroundColor($r('app.color.background_page')).borderRadius(8)
  }
}

export default Mine

