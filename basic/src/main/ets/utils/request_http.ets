import http from '@ohos.net.http';
import {BASE_URL, USER_SETTING_TOKEN} from '../constants'
import { ResponseData } from '../viewmodels';
import { promptAction, router } from '@kit.ArkUI';
import { userSetting } from './setting';

async function requestByHttp<T>(url:string, method:http.RequestMethod = http.RequestMethod.GET, data?: object) {
  //创建请求对象
  const httpRequest = http.createHttp()
  let myUrl = BASE_URL + url
  //get请求需要拼接参数
  if(method === http.RequestMethod.GET && data){
    myUrl += '?' + Object.keys(data).map(key => {
      return `${key}=${data[key]}`
    }).join('&')
  }
  //请求头
  const config: http.HttpRequestOptions = {
    method,
    header:{
      'Content-Type': 'application/json',
      'Authorization': AppStorage.get(USER_SETTING_TOKEN)   || '',
    },
    extraData: method !== http.RequestMethod.GET ? data : "", // 当请求类型不等于get时 复制
    readTimeout: 10000 // 超时时间
  }
  try {
    const result = await httpRequest.request(myUrl,config)
    promptAction.showToast({message:JSON.stringify(result)})
    //状态码判断
    if(result.responseCode === 401){
      //登录失效
      // promptAction.showToast({message:'登录失效'})
      router.replaceUrl({url:'pages/Login/login'})
      AppStorage.setOrCreate(USER_SETTING_TOKEN, '')
      return Promise.reject(new Error("登录失效"))
    }else{
      const res = JSON.parse(result.result as string) as ResponseData<T>
      return res.data as T
    }
  }catch(error){
    promptAction.showToast({message:error})
    return Promise.reject(new Error(error)) // 业务错误 请求终止
  }

}

//请求类
export class RequestHttp {
  static get<T>(url:string, data?:object):Promise<T>{
    return requestByHttp<T>(url, http.RequestMethod.GET, data)
  }
  static post<T>(url:string, data?:object):Promise<T>{
    return requestByHttp<T>(url, http.RequestMethod.POST, data)
  }
  static delete<T>(url:string, data?:object):Promise<T>{
    return requestByHttp<T>(url, http.RequestMethod.DELETE, data)
  }
  static put<T>(url:string, data?:object):Promise<T>{
    return requestByHttp<T>(url, http.RequestMethod.PUT, data)
  }
}