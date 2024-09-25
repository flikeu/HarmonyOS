import {Person} from './dataChangeResponsive'


@Entry
@Component
struct Home2{
  @State skillItem:string=''
  @State xiaoMing:Person=new Person('小明',4500,23)
  build() {
    Column({space:20}){
      Row({space:10}){
        Text("name："+this.xiaoMing.name)
        Text("年龄："+this.xiaoMing.age)
        Text("存款："+this.xiaoMing.salary)
      }.width('100%').backgroundColor(Color.Pink).justifyContent(FlexAlign.Center)
      Column({space:10}){
        ForEach(this.xiaoMing.skill,(item:string)=>{
          Text(item).backgroundColor(Color.Green)
        },(item:string)=>item)
      }.width('100%')
      TextInput({placeholder:'请输入技能',text:$$this.skillItem}).border({width:1,color:Color.Gray,style:BorderStyle.Solid}).width('90%')
      Button("发薪水").onClick(()=>{
       this.xiaoMing.setMoney(500)
      })
      Button('新增技能').onClick((event: ClickEvent) => {
        this.xiaoMing.studySkill(this.skillItem)
        this.skillItem=''

      })
    }.width('100%')
  }
}export {}