import React from 'react';
import ProductData from '../services/product_data';

export default class App extends React.Component {
  nameRef = React.createRef();

  submitForm = async (event) => {
    const { setProduct } = this.props;
    const search = this.nameRef.current.value;

    event.preventDefault();

    let data = await ProductData.fetchAll(search);
    if (data.length > 0) {
      data = data[0];
    } else {
      data = await ProductData.post({asin: search});
    }
    setProduct(data);
    // B07CN1TVHX B002QYW8LW
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
