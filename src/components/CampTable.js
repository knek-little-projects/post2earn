import React from 'react';
import './CampTable.scss'; // Optional: CSS for layout and responsiveness
import { Link } from 'react-router-dom';

// The Camp component displays campaign details in a row using divs
const Camp = ({ item }) => {
  return (
    <div className="camp-row">
      <div className="camp-cell">{item.paymentDetails.paymentPerPost} {item.paymentDetails.token.symbol}</div>
      <div className="camp-cell">{item.title}</div>
    </div>
  );
};

// The CampTable component maps over the array of campaigns and renders each as a Camp
const CampTable = ({ data }) => {
  return (
    <div className="camp-table">
      <div className="camp-header">
        <div className="camp-cell">Payment Per Post</div>
        <div className="camp-cell">Title</div>
      </div>
      {data.map((item) => (
        <Link to={`/campaigns/${item.id}`}>
          <Camp key={item.id} item={item} />
        </Link>
      ))}
    </div>
  );
};

export default CampTable;
