import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

class JSBridgeMethods {
  loadUrl(url: string) {
    router.pushUrl({
      url: 'pages/atips/newsDetailPage',
      params: { url }
    })
  }
}

@Entry
@Component
struct ATipsPage {
  @State message: string = 'Hello World';
  controller: WebviewController = new webview.WebviewController()

  build() {
    Column() {
      Web({
        src: "https://sjjwapi.eyesnews.cn/appAPI/news-detail-news_id-11515115852230.html",
        controller: this.controller
      }).javaScriptProxy({
        methodList: ["loadUrl"], //表示
        controller: this.controller,
        name: "app",
        object: new JSBridgeMethods()
      })
    }.height('100%').width('100%')
  }
}