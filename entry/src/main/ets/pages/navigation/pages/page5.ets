@Component
export struct Page5{
  build() {
    NavDestination(){
      Column(){
        Text("Page5").fontColor(Color.Red).fontSize(30)
      }.height('100%').width('100%')
    }
  }
}