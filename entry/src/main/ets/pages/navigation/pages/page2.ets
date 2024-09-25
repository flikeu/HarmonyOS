@Component
export struct Page2{
  build() {
   NavDestination(){
     Column(){
       Text("Page3").fontColor(Color.Red).fontSize(30).onClick(()=>{
       })
     }.height('100%').width('100%')
   }.onReady((context)=>{
     context.pathStack.getParamByName('Page2')
   })
  }
}