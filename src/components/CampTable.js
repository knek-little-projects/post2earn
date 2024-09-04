function Camp({ data }) {
  return (
    <div>
      {data.title}
    </div>
  )
}

export default function ({ data }) {
  return (
    <div>
      {
        data.map(camp => <Camp key={camp.id} data={camp} />)
      }
    </div>
  )
}