import { abilityAccessCtrl, common } from '@kit.AbilityKit'
import { promptAction } from '@kit.ArkUI';
import { geoLocationManager } from '@kit.LocationKit';
@Entry
@Component
struct LocationPage {
  @State message: string = 'Hello World';

  build() {
    Column(){
      Button('获取位置信息').onClick((event: ClickEvent) => {
        let context: Context = getContext(this) as common.UIAbilityContext;
        const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
        atManager.requestPermissionsFromUser(context,['ohos.permission.APPROXIMATELY_LOCATION']).then(res=>{
          console.log(res.authResults[0]+"")
          console.log(res.dialogShownResults+"")
          if(res.authResults[0]===-1){
            promptAction.showToast({
              message:"无法获取定位，请手动前往应用设置进行设置"
            })
          }else{
            geoLocationManager.getCurrentLocation().then(res=>{
              console.log(res.latitude+"&"+res.longitude)
            })
          }
        })
      })
    }.height('100%').width('100%')

  }
}