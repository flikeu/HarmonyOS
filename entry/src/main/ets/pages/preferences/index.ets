import {preferences} from "@kit.ArkData"
import { common } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";
type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array | object | bigint
export class PreferenceStore{
  static preferenceStore:preferences.Preferences|null=null
  /**
   * 初始化用户首选项
   * @param context
   */
  static initPreferences(context:common.UIAbilityContext){
    let options:preferences.Options={name:'myStore'}
    PreferenceStore.preferenceStore=preferences.getPreferencesSync(context,options)
    console.log('初始化了存储')
  }
  /**
   * 设置本地存储并做持久化
   * @param name
   * @param value
   */
  static set(name:string,value:ValueType){
    PreferenceStore.preferenceStore?.putSync(name,value)
    console.log('做了存储')
    //做本地存储持久化
    PreferenceStore.preferenceStore?.flush((err: BusinessError) => {
      if (err) {
        console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('成功持久化.');
    })
  }
  /**
   * 读取本地存储
   * @param name
   * @returns
   */
  static get(name:string){
   return PreferenceStore.preferenceStore?.getSync(name,"")
  }
  /**
   * 删除本地存储
   * @param name
   */
  static remove(name:string){
    PreferenceStore.preferenceStore?.deleteSync(name)
  }
}
@Entry
@Component
struct PreferencesPractice{
  @State text:string=''
  build() {
      Column(){
        Text(this.text?this.text:'暂无数据')
        Button('存本地').onClick((event: ClickEvent) => {
          PreferenceStore.set('token',"11122223344")
          console.log(PreferenceStore.get('token')+"")
        })
        Button('获取').onClick((event: ClickEvent) => {
          this.text=PreferenceStore.get('token') as string
          console.log(PreferenceStore.get('token')+"")
        })
        // Button('移除').onClick((event: ClickEvent) => {
        //   PreferenceStore.remove('token')
        //   this.text=PreferenceStore.get('token') as string
        // })
      }.height('100%').width('100%').justifyContent(FlexAlign.Center)
  }
}