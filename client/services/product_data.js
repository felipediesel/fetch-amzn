export default class ProductData {
  static async fetchAll(search) {
    return await fetch(`/products?asin=${search}`).then(response => response.json());
  }

  static async post(params) {
    return await fetch(`/products`, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(params),
    })
    .then(response => response.json());
  }
}
