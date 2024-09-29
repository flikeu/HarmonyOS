import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

interface PageParams {
  url: string
}

@Entry
@Component
struct NewsDetailPage {
  @State message: string = 'Hello World';
  controller: WebviewController = new webview.WebviewController()

  aboutToAppear(): void {
    this.url = (router.getParams() as PageParams).url
  }

  @State url: string = ""

  build() {
    Column() {
      Web({ src: this.url, controller: this.controller })
    }.height('100%').width('100%')
  }
}