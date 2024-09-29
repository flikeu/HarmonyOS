import { KVStoreTools } from "./utils"
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct KVStorePage {
  @State message: string = 'Hello World';
  @State token: string = ""
  @State inputToken: string = ""


  build() {
    Column({ space: 10 }) {
      TextInput({ text:this.token?this.token:"暂无",placeholder:'展示数据' })
      TextInput({text:$$this.inputToken})
      Button('存储数据').onClick((event: ClickEvent) => {
       if(this.inputToken){
         KVStoreTools.set("token", this.inputToken)
         this.inputToken=""
       }else {
         promptAction.showToast({
           message:"请输入后再次尝试"
         })
       }
      })
      Button(`获取数据---${this.token}`).onClick((event: ClickEvent) => {
        KVStoreTools.get('token',(data)=>{this.token=data as string})
      })
      Button('删除数据').onClick((event: ClickEvent) => {
        KVStoreTools.remove('token')
      })
    }.height('100%').width('100%')
  }
}