let priceList = {
  milk: {
    price: 397,
    saleQty: 2,
    salePrice: 500
  },
  bread: {
    price: 217,
    saleQty: 3,
    salePrice: 600
  },
  banana: {price: 99},
  apple: {price: 89}
}
Object.freeze(priceList);

function row() { return document.createElement("tr"); }
function header() { return document.createElement("th"); }
function cell() { return document.createElement("td"); }
function get(ele) { return document.getElementById(ele); }

let tableHead = get("grocery-table-head");
let headTr = row();
const receiptHeaders = ['Item', 'Quantity', 'Price'];
receiptHeaders.forEach(function(label) {
  let th = header();
  th.innerHTML = label;
  headTr.appendChild(th);
})
tableHead.appendChild(headTr);

let textArea = get("grocery-items");
textArea.addEventListener('input', (ev) => {
  let values = sanitizeValues(ev.target.value);
  let result = calculateTotals(values);
  renderTotal(result.total);
  renderSaved(result.regularPriceTotal, result.total);
})

function sanitizeValues(values) {
  let items = values.split(',');
  let grouped = _.groupBy(items, (value) => value.toLowerCase().trim());
  let filtered = _.pick(grouped, (value, key, obj) => priceList[key])
  return _.mapObject(filtered, (value) => value.length);
}

let tableBody = get("grocery-table-body");
function calculateTotals(values) {
  let total = 0;
  let regularPriceTotal = 0;

  let fragment = document.createDocumentFragment();
  Object.keys(values).forEach((key) => {
    let val = values[key];
    regularPriceTotal += val * priceList[key]["price"];

    let item = cell();
    item.innerHTML = key;
    let quantity = cell();
    quantity.innerHTML = val;

    let amount = calculatePrice(priceList[key], val);
    total += amount;

    let price = cell();
    price.innerHTML = toCurrency(amount);

    fragment.appendChild(appendCellsToRow(item, quantity, price));
  })

  tableBody.innerHTML = '';
  tableBody.appendChild(fragment);

  return {
    total: total,
    regularPriceTotal: regularPriceTotal
  }
}

function appendCellsToRow(item, quantity, price) {
  let tr = row();
  tr.appendChild(item);
  tr.appendChild(quantity);
  tr.appendChild(price);
  return tr;
}

function toCurrency(amount) {
  return `$${amount/100}`
}

function calculatePrice(item, quantity) {
  if(!onSale(item, quantity)) { return quantity * item["price"] }

  let sum = 0;
  let remainder = quantity % item["saleQty"];
  let qtyOnSale = quantity - remainder;
  sum += remainder * item["price"];
  sum += (qtyOnSale/item["saleQty"]) * item["salePrice"];
  return sum;
}

function onSale(item, quantity) {
  return quantity >= item["saleQty"];
}

let totalElement = get('total-price');
function renderTotal(total) {
  totalElement.innerHTML = `Total price : ${toCurrency(total)}`;
}

let amountSaved = get('amount-saved');
function renderSaved(regularPriceTotal, total) {
  let difference = toCurrency(regularPriceTotal - total);
  amountSaved.innerHTML = `You saved ${difference} today`
}