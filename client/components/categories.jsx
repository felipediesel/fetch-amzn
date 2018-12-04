import React from 'react';

export default class Categories extends React.Component {
  render() {
    const { categories } = this.props;

    return (
      <span>
        {categories.map(category => category.name).join(" > ")}
      </span>
    );
  }
}
