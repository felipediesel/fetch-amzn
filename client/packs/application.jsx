import "@babel/polyfill";

import React from 'react';
import ReactDOM from 'react-dom';

import App from 'components/app';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App name="fetch-amz" />,
    document.body.appendChild(document.createElement('div')),
  );
});
