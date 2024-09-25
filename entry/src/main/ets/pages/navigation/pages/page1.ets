@Component
export struct Page1 {
  pathStack:NavPathStack=new NavPathStack()
  build() {
    NavDestination() {
      Column() {
        Text("111111111")
        Text("Page1")
        Button('去Page2').onClick((event: ClickEvent) => {
          this.pathStack.pushPath({
            name:'Page2',
            param:1
          })
        })
      }.height('100%').width('100%').justifyContent(FlexAlign.Start)
    }.onReady((context)=>{
     this.pathStack= context.pathStack
    })
  }
}
