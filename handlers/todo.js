const index = import('../index.js')

exports.handler = async () => {
  const { todo } = await index
  return {
    statusCode: 200,
    body: JSON.stringify({
      data: todo('TODO')
    })
  }
}
