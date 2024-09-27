import picker from '@ohos.file.picker';
import { common } from '@kit.AbilityKit';
import { request } from '@kit.BasicServicesKit';
import { fileIo as fs } from '@kit.CoreFileKit';
import { http } from '@kit.NetworkKit';

interface  aaa{
  filename: string
  type: string
  name:string
  uri:string
}
@Component
@Entry
struct Type2 {
  @State message: string = 'Hello World';
  @State url:string="https://img1.baidu.com/it/u=1653751609,236581088&fm=253&app=120&size=w931&n=0&f=JPEG&fmt=auto?sec=1727542800&t=65fe0c568a04d4bcd052ded0eb54cd77"
   context = getContext(this) as common.Context;
  build() {
    Column() {
      Image(this.url).borderRadius(35).width(70).height(70)
      Button("选择文件").onClick((event: ClickEvent) => {

        let myPicker=new picker.DocumentViewPicker(this.context)
        myPicker.select({
          maxSelectNumber:1,
          selectMode:picker.DocumentSelectMode.FILE,
        }).then(res=>{
          this.url=res[0]
          console.log(res+"")
        })
      })
      Button("打开文件").onClick((event: ClickEvent) => {
        // 使用文件管理模块打开,拿到源文件
        const avatarFile=fs.openSync(this.url)
        console.log(avatarFile.fd+"")
        // 设置一下需要拷贝到缓存目录的图片名字
        const filename = `${Date.now()}_${Math.floor(Math.random() * 1000)}`
        // 动态取到文件名的格式后缀, 一般是jpg/png格式
        const extension = this.url.slice(this.url.lastIndexOf(".") + 1)
        // 把路径和文件名组合
        const copyThePath = `${getContext().cacheDir}/${filename}.${extension}`
        // 打印一下准备复制的路径做确认
        console.log(copyThePath)
        // 拿到源文件的唯一表示,和准备复制的路径,把相册中的图片复制到应用自身的沙箱中
        // 拿到源文件的唯一表示,和准备复制的路径,把相册中的图片复制到应用自身的沙箱中
        const fileData=fs.copyFileSync(avatarFile.fd, copyThePath)
        const fileObject:aaa={
          filename: `${filename}.${extension}`,
          type: extension,
          name: "avatar",
          uri: `internal://cache/${filename}.${extension}`
        }
        const res:Promise<number> = new Promise((resolve: Function, reject: Function) => {
          const  resData=request.uploadFile(this.context, {
            url: "http://192.168.14.71:1337:/api/v1/common/upload_file",
            method: http.RequestMethod.POST,
            header: {
              "Content-Type": 'multipart/form-data',
              // "Authorization": `Bearer ${"token"}`  看需求,是否需要携带token
            },
            files:[fileObject],
            data: []
          })
          resolve(resData)
        })
      })
    }.height('100%').width('100%')
  }
}