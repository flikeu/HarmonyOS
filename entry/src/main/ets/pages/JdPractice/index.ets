import { rcp } from '@kit.RemoteCommunicationKit'
import { JSON } from '@kit.ArkTS'

class MyIntercept implements rcp.Interceptor {
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    context.request.headers!["origin"] = "https://minicaty-pro.pf.jd.com"
    return await next.handle(context)
  }
}

class HttpRequest {
  private session: rcp.Session

  constructor() {
    this.session = rcp.createSession({
      baseAddress: 'https://api.m.jd.com',
      interceptors: [new MyIntercept()],
      requestConfiguration: {
        transfer: {
          timeout: {
            connectMs: 5000, // 连接时间
            transferMs: 5000 // 传输时间
          }
        }
      },
    })
  }

  get(url: string) {
    return this.session.get(url).then(res => {
      return res
    })
  }
}

interface Type {
  title: string
  paneKey: string
}

interface ProductKeyword {
  keywordId: string; // 唯一标识关键词的 ID，类型为 string
  catId: string; // 类别 ID，类型为 string
  keyword: string; // 关键词（商品名称或搜索词），类型为 string
  url: string; // 跳转的 URL，类型为 string
  imageUrl: string; // 图片的 URL，类型为 string
}

interface ProductKeywordGroup<T> {
  keywordid: string
  secCateName: string
  keyword: string
  adGroupId: string
  level2words: Array<T>
}

interface aaa {
  level2words: Array<ProductKeyword>
}


@Entry
@Component
struct Jd_practice {
  @State firstCate: Array<Type> = []
  @State goodsArray: Array<ProductKeywordGroup<ProductKeyword>> = []
  @State firstCateKey: string = "2094"

  getFirstCateData(goodsGroupId: string) {
    new HttpRequest().get(`/api?functionId=mbf_queryCategory&appid=jd-cphdeveloper-m&body=%7B%22tenantCode%22%3A%22jgm%22%2C%22bizModelCode%22%3A%225%22%2C%22loginWQBiz%22%3A%22golden-trade%22%2C%22bizModeFramework%22%3A%22h5%22%2C%22bizModeClientType%22%3A%22M%22%2C%22uuid%22%3Anull%2C%22externalLoginType%22%3A%221%22%2C%22categoryId%22%3A%22` +
      goodsGroupId + `%22%7D&loginType=2`).then(res => {
      this.firstCate = res.toJSON()!["data"]["firstCate"]
    })
  }

  getGoodsArrayData(goodsGroupId: string) {
    new HttpRequest().get(`/api?functionId=mbf_queryCategory&appid=jd-cphdeveloper-m&body=%7B%22tenantCode%22%3A%22jgm%22%2C%22bizModelCode%22%3A%225%22%2C%22loginWQBiz%22%3A%22golden-trade%22%2C%22bizModeFramework%22%3A%22h5%22%2C%22bizModeClientType%22%3A%22M%22%2C%22uuid%22%3Anull%2C%22externalLoginType%22%3A%221%22%2C%22categoryId%22%3A%22` +
      goodsGroupId + `%22%7D&loginType=2`).then(res => {
      this.goodsArray = res.toJSON()!["data"]["secondCate"]['level1words']
    })
  }

  aboutToAppear(): void {
    this.getFirstCateData("2094")
    this.getGoodsArrayData("2094")
  }

  @Builder
  Header(title: string) {
    Text(title).fontSize(18).fontWeight(FontWeight.Bold).padding(10)
  }

  build() {
    Row() {
      Scroll() {
        Column() {
          ForEach(this.firstCate.splice(1), (type: Type, index) => {
            Text(type.title)
              .padding({
                top: 10,
                left: 20,
                bottom: 10,
                right: 20
              })
              .backgroundColor(this.firstCateKey === type.paneKey ? Color.White : "")
              .onClick(() => {
                this.firstCateKey = type.paneKey
                this.getGoodsArrayData(type.paneKey)
              })
          }, (item: Type) => item.paneKey)
        }.justifyContent(FlexAlign.SpaceAround)
      }.height('100%').scrollBar(BarState.Off)

      List({ space: 10 }) {
        ForEach(this.goodsArray.splice(1), (product: ProductKeywordGroup<ProductKeyword>, index) => {
          ListItemGroup({ header: this.Header(product.keyword), space: 10 }) {
            ForEach(product.level2words, (productItem: ProductKeyword) => {
              ListItem() {
                Column({ space: 8 }) {
                  Image(productItem.imageUrl).height(70).width(70)
                  Text(productItem.keyword)
                }.alignItems(HorizontalAlign.Center)
              }.width('100%')
            }, (productItem: ProductKeyword) => productItem.keywordId)
          }
        }, (item: ProductKeywordGroup<ProductKeyword>) => item.keyword)
      }
      .lanes(3)
      .height('100%')
      .layoutWeight(1)
      .backgroundColor(Color.White)
      .scrollBar(BarState.Off)
      .cachedCount(6).edgeEffect(EdgeEffect.None)
    }.height('100%').width('100%').backgroundColor("#ffe9e8e8")
  }
}