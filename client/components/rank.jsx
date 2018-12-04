import React from 'react';
import Categories from './categories';

export default class Rank extends React.Component {
  render() {
    const { rank } = this.props;

    return (
      <p>
        <span>#{rank.position} in </span>
        <span><Categories categories={rank.categories} /></span>
      </p>
    );
  }
}
