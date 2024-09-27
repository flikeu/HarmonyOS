import {PreferenceStore} from './preferences/index'

@Entry
@Component
struct UploadFile {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text(this.message)
        .id('UploadFileHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Button("存储").onClick(()=>{
        PreferenceStore.set("aaa","aaaaaa")
      })
      Button('显示出来').onClick((event: ClickEvent) => {
        this.message=PreferenceStore.get('aaa') as string
      })
    }
    .height('100%')
    .width('100%')
  }
}