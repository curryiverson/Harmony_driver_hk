import { TabClass } from 'basic'
import Mine from './mine'

@Entry
@Component
struct Index {
  @State currentIndex: number = 2
  @State currentName:string = ''
  @State
  tabsData: TabClass[] = [
    {
      name: 'task',
      title: '任务',
      icon: $r("app.media.ic_tab_btn_task")
    },
    {
      name: 'message',
      title: '消息',
      icon: $r("app.media.ic_tab_btn_mess_nor")
    },
    {
      name: 'mine',
      title: '我的',
      icon: $r("app.media.ic_tab_btn_mine_nor")
    }
  ]
  @Builder
  getTabBar(item:TabClass, index:number){
    Column({space:6}){
      Image(item.icon)
        .width(20)
        .height(20)
        .fillColor(index === this.currentIndex ? $r('app.color.primary') : $r('app.color.text_secondary'))
      Text(item.title)
        .fontColor(index === this.currentIndex ? $r('app.color.primary') : $r('app.color.text_secondary'))
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End, index: $$this.currentIndex }){
      ForEach(this.tabsData, (item:TabClass, index:number) => {
        TabContent(){
          if(item.name === 'mine'){
            Mine({currentName: this.currentName})
          }else {
            Text(item.name)
          }
        }.tabBar(this.getTabBar(item, index))
      })
    }
    .onChange(() => {
      this.currentName = this.tabsData[this.currentIndex].name
    })
    .height('100%')
    .width('100%')
  }
}