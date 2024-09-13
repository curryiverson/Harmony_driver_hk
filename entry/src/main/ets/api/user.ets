import { RequestHttp } from 'basic'
import { loginModel } from '../viewmodels'

//登录接口
export const login = (data:loginModel) => RequestHttp.post<string>('/login/account', data)