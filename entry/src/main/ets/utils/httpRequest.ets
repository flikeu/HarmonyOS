import { http } from '@kit.NetworkKit';

export  class HttpRequest{
  private httpRequest: http.HttpRequest
  constructor() {
    this.httpRequest=http.createHttp()
  }
  destroy(){
    this.httpRequest.destroy()
  }
}