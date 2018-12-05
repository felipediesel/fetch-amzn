import React from 'react';
import Rank from './rank';
import Categories from './categories';

export default class Product extends React.Component {
  renderTable(product) {
    if (product.state && product.state === 'progress') {
      return (
        <div id="fetching-product">Fetching data from amazon, please wait...</div>
      )
    } else {
      return (
      <table>
        <tbody>
          {this.renderDimensions(product.dimensions)}
          {this.renderCategories(product.categories)}
          {this.renderRanks(product.ranks)}
        </tbody>
      </table>
      );
    }
  }

  renderCategories(categories) {
    if (!categories || categories.length == 0) {
      return "";
    }

    return (
      <tr>
        <td>Category</td>
        <td>
          <Categories categories={categories} />
        </td>
      </tr>
    )
  }

  renderDimensions(dimensions) {
    if (!dimensions) {
      return "";
    }

    return (
      <tr>
        <td>Dimensions</td>
        <td>{dimensions}</td>
      </tr>
    )
  }

  renderRanks(ranks) {
    if (!ranks || ranks.length == 0) {
      return "";
    }

    return (
      <tr>
        <td>Ranking</td>
        <td>
          {ranks.map(rank => (
            <Rank key={rank.id} rank={rank} />
          ))}
        </td>
      </tr>
    )
  }

  render() {
    const { product } = this.props;

    if (!product.asin) {
      return "";
    }

    return (
      <div>
        <h2>{product.asin}</h2>
        {this.renderTable(product)}
      </div>
    );
  }
}
