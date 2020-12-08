import { todo } from '@makenew/jsmodule'

export default async () => ({
  statusCode: 200,
  body: JSON.stringify({
    data: todo('foo')
  })
})
