import { Link } from "react-router-dom";
import { ConnectButton } from "./components/ConnectButton"

export default function ({ children }) {
  return (
    <div>
      <ConnectButton />
      <div>
        <ul>
          <li><Link to="/campaigns/">All Campaigns</Link></li>
          <li><Link to="/u/addr/campaigns">Your Campaigns</Link></li>
          <li><Link to="/u/addr/posts">Your Posts</Link></li>
        </ul>
      </div>
      {children}
    </div>
  )
}