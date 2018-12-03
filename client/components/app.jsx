import React from 'react';
import './app.css.scss';

export default class App extends React.Component {
  render() {
    return <div>Hello {this.props.name}!</div>
  }
}
