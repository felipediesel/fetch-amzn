import React from 'react';
import './app.css.scss';

import Search from './search';
import Product from './product';

export default class App extends React.Component {
  state = {
    product: {}
  };

  setProduct = product => {
    if (product === undefined) {
      product = {};
    }
    this.setState({ product });
  };

  render() {
    return (
      <div>
        <Search setProduct={this.setProduct} />
        <Product product={this.state.product} />
      </div>
    );
  }
}
