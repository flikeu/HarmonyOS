import picker from '@ohos.file.picker';
import http from '@ohos.net.http';
import { JSON } from '@kit.ArkTS';
import {imageUploadModule} from './utils'
@Entry
@Component
struct FileSelect {
  @State message: string = 'Hello World';
  @State url:string=""
  build() {
    Column() {
      Image(this.url).borderRadius(35).width(70).height(70)
      Button("选择文件").onClick((event: ClickEvent) => {
        let myPicker=new picker.DocumentViewPicker()
        myPicker.select({
          maxSelectNumber:1,
          selectMode:picker.DocumentSelectMode.FILE,
        }).then(res=>{
          this.url=res[0]
          console.log(res+"")
        })
      })
      Button("上传").onClick((event: ClickEvent) => {
        imageUploadModule.imageUpload("http://192.168.14.71:1337/api/v1/common/upload_file","file")
      })
    }.height('100%').width('100%')
  }
}