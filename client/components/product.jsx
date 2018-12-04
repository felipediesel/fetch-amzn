import React from 'react';
import Rank from './rank';
import Categories from './categories';

export default class Product extends React.Component {
  render() {
    const { product } = this.props;

    if (!product.asin) {
      return "";
    }

    return (
      <div>
        <h2>{product.asin}</h2>
        <dl>
          <dt>Dimensions</dt>
          <dd>{product.dimensions}</dd>
          <dt>Category</dt>
          <dd>
            <Categories categories={product.categories} />
          </dd>
          <dt>Ranking</dt>
          <dd>
            {product.ranks.map(rank => (
              <Rank key={rank.id} rank={rank} />
            ))}
          </dd>
        </dl>
      </div>
    );
  }
}
