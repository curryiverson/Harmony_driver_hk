import axios,{AxiosError, AxiosResponse,InternalAxiosRequestConfig} from '@ohos/axios'
import { BASE_URL, USER_SETTING_TOKEN } from '../constants'
import { promptAction, router } from '@kit.ArkUI'

const instance = axios.create({
  baseURL: BASE_URL,
  timeout: 10000,
})
//请求拦截
instance.interceptors.request.use((config:InternalAxiosRequestConfig) => {
  if(AppStorage.get(USER_SETTING_TOKEN)){
    config.headers.Authorization = AppStorage.get(USER_SETTING_TOKEN)
  }
  return config;
},(error:AxiosError) => {
  return Promise.reject(error)
})
//响应拦截
instance.interceptors.response.use(
  (response:AxiosResponse) => {
  if(response.data && response.data.code === 200){
    return response.data.data
  }
  promptAction.showToast({message:response.data.msg})
  return Promise.reject(new Error(response.data.msg))
},
  (error: AxiosError) => {
  if(error.response?.status == 401){
    //登录失效
    router.replaceUrl({url:'pages/Login/login'})
    AppStorage.setOrCreate(USER_SETTING_TOKEN, '')
    return Promise.reject(new Error("登录失效"))
  }
  return Promise.reject(error)
})

export class RequestAxios {
  static get<T>(url: string, params?: object):Promise<T> {
    return instance.get<null, T>(url, { params })
  }

  static post<T>(url: string, data?: object):Promise<T> {
    return instance.post<null, T>(url, data)
  }

  static delete<T>(url: string, params?: object):Promise<T> {
    return instance.delete<null, T>(url, { params })
  }

  static put<T>(url: string, data?: object, params?: object):Promise<T> {
    return instance.put<null, T>(url, data, { params })
  }
}