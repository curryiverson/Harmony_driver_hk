export interface loginModel {
  /** 登录账号 */
  account: string;
  /** 登录密码 */
  password: string;
}
export class loginModelModel implements loginModel {
  account: string = ''
  password: string = ''

  constructor(model: loginModel) {
    this.account = model.account
    this.password = model.password
  }
}
