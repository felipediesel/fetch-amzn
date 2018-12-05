import React from 'react';
import ProductData from '../services/product_data';

export default class App extends React.Component {
  nameRef = React.createRef();

  submitForm = async (event) => {
    const search = this.nameRef.current.value;

    event.preventDefault();

    let data = await ProductData.fetchAll(search);

    if (data.length > 0 ) {
      data = data[0];
    } else {
      data = await ProductData.post({asin: search});
    }
    this.props.setProduct(data);
    if (data.state === 'progress') {
      this.poolProduct(search)
    }
  };

  poolProduct = (search) => {
    setTimeout(async () => {
      let data = await ProductData.fetchAll(search);
      if (data.length > 0) {
        this.props.setProduct(data[0]);
      }

      if (data[0].state === 'progress') {
        this.poolProduct(search)
      }
    }, 1500);
  };

  render() {
    return (
      <form id="searchFrom" onSubmit={this.submitForm}>
        <input type="text" ref={this.nameRef} name="asin" placeholder="ASIN" />
        <button type="submit">Search</button>
      </form>
    );
  }
}
