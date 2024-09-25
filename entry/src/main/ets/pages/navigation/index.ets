import { Page1 } from './pages/page1'
import { Page2 } from './pages/page2'
import { Page3 } from './pages/page3'
import { Page4 } from './pages/page4'
import { Page5 } from './pages/page5'
@Entry
@Component
struct NavigationBar {
  @State tabBarIndex: number = 0
  @State message: string = 'Hello World';
  pathStack:NavPathStack=new NavPathStack()
  @Builder
  pageMap(name: string) {
     if (name === "Page1") {
      Page1()
    }else if (name === "Page2") {
       Page2()
     }
  }
  controller: TabsController = new TabsController()
  build() {
    Navigation(this.pathStack) {
      Column(){
        Text('我是Navigation')
        Button('去Page1').onClick((event: ClickEvent) => {
          this.pathStack.pushPath({
            name:'Page1'
          })
        })
      }.height('100%').width('100%')
    }.title('哈哈哈').toolbarConfiguration([
      {
        value:'页面1'
      },
      {
        value:'页面2'
      },
      {
        value:'页面3'
      },

    ]).navDestination(this.pageMap)
    // .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM],[LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
  }
}