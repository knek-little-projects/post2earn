import Loader from "./Loader"

export default function ({
  loaders,
  children
}) {
  const loading = loaders.some(l => l.loading)
  const error = loaders.some(l => l.error)
  const data = loaders.every(l => l.data)
  return (
    <Loader loading={loading} error={error} data={data}>
      {children}
    </Loader>
  )
}