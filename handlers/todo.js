import { todo } from '../index.js'

export default async () => ({
  statusCode: 200,
  body: JSON.stringify({
    data: todo('TODO')
  })
})
