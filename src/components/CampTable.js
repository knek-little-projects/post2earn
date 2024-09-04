import React from 'react';
import './CampTable.scss'; // Optional: CSS for layout and responsiveness

// The Camp component displays campaign details in a row using divs
const Camp = ({ item }) => {
  return (
    <div className="camp-row">
      <div className="camp-cell">{item.id}</div>
      <div className="camp-cell">{item.title}</div>
      <div className="camp-cell">{item.owner}</div>
      <div className="camp-cell">{item.postRequirements.link}</div>
      <div className="camp-cell">{item.paymentDetails.totalSupply} {item.paymentDetails.symbol}</div>
    </div>
  );
};

// The CampTable component maps over the array of campaigns and renders each as a Camp
const CampTable = ({ data }) => {
  return (
    <div className="camp-table">
      <div className="camp-header">
        <div className="camp-cell">ID</div>
        <div className="camp-cell">Title</div>
        <div className="camp-cell">Owner</div>
        <div className="camp-cell">Link</div>
        <div className="camp-cell">Total Supply</div>
      </div>
      {data.map((item) => (
        <Camp key={item.id} item={item} />
      ))}
    </div>
  );
};

export default CampTable;
