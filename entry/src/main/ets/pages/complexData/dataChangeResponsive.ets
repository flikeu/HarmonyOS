import {ObservedArray} from './homePage'
export class Person {
  name: string
  salary: number
  age: number
  skill: ObservedArray<string>

  constructor(name: string, salary: number, age: number) {
    this.name = name;
    this.age = age;
    this.salary = salary;
    this.skill = new ObservedArray<string>(['吃饭', "睡觉", "打豆豆"])
  }

  setMoney(money: number) {
    this.salary = this.salary + money
  }

  studySkill(skill: string) {
    this.skill.push(skill)
  }
}

@Component
struct SkillItem {
  @ObjectLink skillArray:ObservedArray<string>
  build() {
    Column({ space: 10 }) {
      ForEach(this.skillArray,(skill:string)=>{
        Text(skill).backgroundColor(Color.Green)
      },(item:string)=>item)
    }
  }
}

@Entry
@Component
struct DataChangeResponsive {
  @State skillItem: string = ''
  @State xiaoMing: Person = new Person('小明', 4500, 23)

  build() {
Scroll(){
  Column({ space: 20 }) {
    Text("存款：" + this.xiaoMing.salary).backgroundColor(Color.Green).fontColor(Color.Orange).fontSize(50)
    Row({ space: 10 }) {
      Text("姓名：" + this.xiaoMing.name)
      Text("年龄：" + this.xiaoMing.age)

    }.width('100%').backgroundColor(Color.Pink).justifyContent(FlexAlign.Center)

    SkillItem({skillArray:this.xiaoMing.skill})

    TextInput({ placeholder: '请输入技能', text: $$this.skillItem })
      .border({ width: 1, color: Color.Gray, style: BorderStyle.Solid })
      .width('90%')
    Button("发薪水").onClick(() => {
      this.xiaoMing.setMoney(500)
    })
    Button('新增技能').onClick((event: ClickEvent) => {
      this.xiaoMing.studySkill(this.skillItem)
      this.skillItem = ''
    })
  }.justifyContent(FlexAlign.Start)
}.height('100%')
  }
}export {}