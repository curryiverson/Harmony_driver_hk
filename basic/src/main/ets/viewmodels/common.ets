export class ResponseData<T> {
  code:number = 0
  msg: string = ''
  data: T | null = null
}