# Mini E-Commerce Cart App

- This is a small Flutter project I built to practice state management with Riverpod and handling local storage.
- The app works like a very simple e-commerce flow: you can browse products, add them to a cart, apply discounts, and check out.
- I also made sure the cart and order history stay saved even after closing the app.

## What’s Inside

# Product List Screen

- Fetches product data from an API.

- Each product shows an image, name, and price.

- You can add items to your cart using the “Add to Cart” button.

- A cart icon at the top takes you to the cart screen.

# Cart Screen

- Shows all the items you’ve added.

- You can increase or decrease quantities, or remove an item completely.

- The total price updates automatically when you change quantities.

- There’s a Checkout button that takes you to the checkout screen.

# Checkout Screen

- Shows an order summary with all selected items and the total cost.

- There’s a box to enter coupon codes.

- DISCOUNT10 → 10% off

- DISCOUNT20 → 20% off

- If the code is valid, the discount gets applied to the total.

- Clicking Place Order saves the order to local storage and clears the cart.

# Order History Screen

- Lists all the past orders you’ve placed.

- Each order shows the items, total amount, and the date it was placed.

- Orders stay saved even if you restart the app.

# Tech I Used

- Flutter

- Riverpod for state management

- Dio/http for API calls

- SharedPreferences for saving cart and orders locally

# How to Run

- Clone the repo
  
- Run flutter pub get

- Start the app with flutter run
