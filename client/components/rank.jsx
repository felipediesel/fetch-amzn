import React from 'react';
import Categories from './categories';

export default class Rank extends React.Component {
  render() {
    const { rank } = this.props;

    return (
      <div>
        <span>#{rank.position} in </span>
        <Categories categories={rank.categories} />
      </div>
    );
  }
}
