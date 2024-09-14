import { RequestHttp } from 'basic'
import { loginModel, UserInfoModel } from '../viewmodels'

//登录接口
export const login = (data:loginModel) => RequestHttp.post<string>('/login/account', data)

//获取个人信息
export const getUser = () => RequestHttp.get<UserInfoModel>('/users')