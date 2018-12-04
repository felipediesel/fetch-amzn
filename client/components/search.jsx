import React from 'react';

export default class App extends React.Component {
  nameRef = React.createRef();

  submitForm = (event) => {
    const { setProduct } = this.props;
    const search = this.nameRef.current.value;

    event.preventDefault();

    fetch(`/products?asin=${search}`)
      .then(response => response.json())
      .then(data => setProduct(data[0]));
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
