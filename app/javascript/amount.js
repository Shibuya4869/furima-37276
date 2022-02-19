function amount() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input", () => {
    const price = document.getElementById("item-price").value;
    var taxPrice = document.getElementById("add-tax-price");
    var profitPrice = document.getElementById("profit");
    var tax = Math.floor(price * 0.1);
    var profit = Math.floor(price - tax);
    taxPrice.innerHTML = tax.toLocaleString();
    profitPrice.innerHTML = profit.toLocaleString();
  });
}

window.addEventListener("load", amount);
