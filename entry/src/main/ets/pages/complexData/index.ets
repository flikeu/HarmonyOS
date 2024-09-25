import { prompt } from '@kit.ArkUI'

@Observed
class myPerson {
  id:string
  name: string
  age: number

  constructor(name: string, age: number) {
    this.id=Date.now()+""+Math.random()*9999
    this.name = name
    this.age = age
  }
}


@Component
struct Goods {
  @Prop title: string
  @Prop price: number
  @Link pp: number
  add: () => void = () => {
  }

  build() {
    Column() {
      Text(this.title)
      Text(this.pp + "").onClick(() => {
        this.add()
      })
      Text(this.price + "元")
      Button('增加').onClick((event: ClickEvent) => {
        this.pp++
        prompt.showToast({
          message: 'jjjj'
        })
      })

    }
  }
}

@Component
struct PeopleView{
  @ObjectLink person:myPerson
  del:(id:string)=>void=(id:string)=>{}
  build() {
    Column(){
      Text(this.person.name)
      Button(this.person.age+"").onClick(()=>{
        this.person.age++
      }).type(ButtonType.Normal)
      Button("删除").onClick((event: ClickEvent) => {
        this.del(this.person.id)
      })
    }.backgroundColor(Color.Pink)
  }
}



@Entry
@Component
struct ComplexData {
  @State pp: number = 99
  @State people:myPerson[]=[new myPerson('fs',24),new myPerson('zhangsan',34)]
  addPrice() {
    return () => {
      console.log("11111")
    }
  }
  build() {
   Scroll(){
     Column({ space: 20 }) {
       Goods({
         title: "衣服1",
         price: 23,
         pp: this.pp,
         add: this.addPrice()
       })
       Goods({ title: "衣服1", price: 23, pp: this.pp })
       Goods({ title: "衣服1", price: 23, pp: this.pp })
       ForEach(this.people,(person:myPerson,index)=>{
         PeopleView({person:person,del:(id)=>{
           this.people.splice(this.people.findIndex(item=>item.id===id),1)
         }})
       },(item:myPerson)=>item.id)
       Button('新增认员').onClick(()=>{
         this.people.push(new myPerson("人"+this.people.length,Math.ceil(Math.random()*100)))
       })
     }.width('100%')
   }.height('100%')
  }
}