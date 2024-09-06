import "./CampView.scss"

export default function ({ item }) {
  return (
    <div>

      <div className="camp-view">
        <div className="camp-field">
          <strong>ID:</strong> <span>{item.id}</span>
        </div>
        <div className="camp-field">
          <strong>Title:</strong> <span>{item.title}</span>
        </div>
        <div className="camp-field">
          <strong>Owner:</strong> <span>{item.owner}</span>
        </div>
        <div className="camp-field">
          <strong>Post Requirement Text:</strong> <span>{item.postRequirements.text}</span>
        </div>
        <div className="camp-field">
          <strong>Post Requirement Link:</strong> <span>{item.postRequirements.link}</span>
        </div>
        <div className="camp-field">
          <strong>Post Requirement Tag:</strong> <span>{item.postRequirements.tag}</span>
        </div>
        <div className="camp-field">
          <strong>Min Followers:</strong> <span>{item.bloggerRequirements.minFollowers}</span>
        </div>
        <div className="camp-field">
          <strong>Favorite Topic:</strong> <span>{item.bloggerRequirements.favoriteTopic}</span>
        </div>
        <div className="camp-field">
          <strong>Post Min Time To Live:</strong> <span>{item.bloggerRequirements.postMinTimeToLive}</span>
        </div>
        <div className="camp-field">
          <strong>Payment Token:</strong> <span>{item.paymentDetails.paymentToken}</span>
        </div>
        <div className="camp-field">
          <strong>Payment Per Post:</strong> <span>{item.paymentDetails.paymentPerPost} {item.paymentDetails.symbol}</span>
        </div>
        <div className="camp-field">
          <strong>Total Supply:</strong> <span>{item.paymentDetails.totalSupply} {item.paymentDetails.symbol}</span>
        </div>
        <div className="camp-field">
          <strong>Locked Supply:</strong> <span>{item.paymentDetails.lockedSupply} {item.paymentDetails.symbol}</span>
        </div>
        <div className="camp-field">
          <strong>Claimed Supply:</strong> <span>{item.paymentDetails.claimedSupply} {item.paymentDetails.symbol}</span>
        </div>
      </div>

    </div>

  )
}
