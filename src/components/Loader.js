export default function ({
  loading,
  error,
  data,
  children,
}) {
  return (
    <>
      {
        loading
        &&
        <div>Loading...</div>
        ||
        (
          error
          &&
          <div>Error: {"" + error}</div>
          ||
          (
            data
            &&
            <>
              {children}
            </>
          )
        )
      }
    </>
  )
}