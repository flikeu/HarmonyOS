import { webview } from '@kit.ArkWeb';
import { promptAction } from '@kit.ArkUI';

class JSBridgeMethods{
  say(){
    promptAction.showToast({
      message:'哈哈，方法被调用了'
    })
  }
}
@Entry
@Component
struct webViewPractice {
  @State message: string = 'Hello World';
  controller:WebviewController=new webview.WebviewController()
  build() {
   Column(){
     Text('哈哈哈哈哈哈哈哈哈哈哈哈')
     Button("点一下").onClick(()=>{
       this.controller.runJavaScript("addd('zz')")
     })
      Web({src:"http://192.168.0.109:5500/1.html",controller:this.controller})
        .javaScriptProxy({
          methodList:["say"],//表示
          controller:this.controller,
          name:"twt",
          object:new JSBridgeMethods()
        })

    }.height('100%').width('100%')
  }
}