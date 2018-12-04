import React from 'react';

export default class App extends React.Component {
  nameRef = React.createRef();

  submitForm = (event) => {
    const { setProduct } = this.props;
    const search = this.nameRef.current.value;

    event.preventDefault();

    fetch(`/products?asin=${search}`)
      .then(response => response.json())
      .then(data => {
        if (data.length > 0) {
          setProduct(data[0]);
        } else {
          fetch(`/products`, {
            method: 'POST',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ asin: search }),
          })
          .then(response => response.json())
          .then(data => {
            setProduct(data);
          })

        }
      });
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
