interface Banner {
  id: string,
  url: string
}

@Observed
class Goods {
  id: string
  name: string
  img: string

  constructor(id: string, name: string, img: string) {
    this.id = id
    this.name = name
    this.img = img

  }
}
@Observed
class ObservedArray<T> extends Array<T>{
  constructor(arr?:T[]) {
    if(arr instanceof Array){
      super(...arr)
    }else {
      super()
    }
  }
}
class HomePageModel {
  banners: Banner[]
  goods: ObservedArray<Goods>
  count: number

  constructor() {
    this.banners = []
    this.goods = new ObservedArray()
    this.count = 1
  }

  init() {
    this.banners = [
      { id: '1', url: 'https://img1.baidu.com/it/u=2769931709,4101271706&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500' },
      { id: '2', url: 'https://img1.baidu.com/it/u=2769931709,4101271706&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500' },
      { id: '3', url: 'https://img1.baidu.com/it/u=2769931709,4101271706&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500' },
    ]
    this.goods.push(new Goods( "1",'商品1',""),new Goods( "2",'商品2',""),new Goods( "3",'商品3',""))
  }

  loadMoreGoods() {
    this.goods.push(new Goods(this.goods.length+1+"","商品"+(this.goods.length+1),""))
  }

  countAdd() {
    this.count++
  }
}

@Component
struct GoodsListView {
  @ObjectLink goodsInfo: ObservedArray<Goods>
  del:()=>void=()=>{}
  build() {
    List() {
      ForEach(this.goodsInfo, (goodsItem: Goods, index) => {
      ListItem(){
        Column(){
          Text(goodsItem.name).width('100%').backgroundColor("#ccc").textAlign(TextAlign.Center).padding(16)
          Button('删除').onClick(()=>{
            this.goodsInfo.splice(this.goodsInfo.findIndex(item=>goodsItem.id===item.id),1)
          })
        }
      }
      }, (item: Goods) => item.id)
    }
  }
}


@Entry
@Component
struct HomePage {
  @State pm: HomePageModel = new HomePageModel()

  aboutToAppear(): void {
    this.pm.init()
  }

  build() {
    Scroll() {
      Column() {
        Swiper() {
          ForEach(this.pm.banners, (bannerItem: Banner, index) => {
            Image(bannerItem.url)
          }, (item: Banner) => item.id)
        }.onChange((index: number) => {

        })

        List() {
          ListItem() {
            Column() {
              Text("公告")
            }
          }

          ListItem() {
            Column() {
              Text("通知")
            }
          }

          ListItem() {
            Column() {
              Text("新闻")
            }
          }

          ListItem() {
            Column() {
              Text("发布")
            }
          }

          ListItem() {
            Column() {
              Text("米家")
            }
          }

        }.lanes(4)

        Text(this.pm.count + "")
        GoodsListView({goodsInfo:this.pm.goods})

        Button('增加商品').onClick((event: ClickEvent) => {
          this.pm.loadMoreGoods()
        })
        Button("增加数字").onClick(() => {
          this.pm.countAdd()
        })
      }.width('100%')
    }.height('100%')
  }
}