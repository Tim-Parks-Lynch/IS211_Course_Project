# Petazon

## Tier 1: MVP

- [x] Able to go to http://127.0.0.1:/5000 and access Petazon an ecommerce website for all pet products
- [x] View all available products from main page
- [x] View a single product with product details
- [x] View Login Page
- [x] View Signup Page
- [x] View Cart Page
- [] Search Page for Search Bar
- [] Add a product to a cart
- [] Edit the cart
  - [] Change the quantity of a product from the cart
  - [] Remove a product from the cart
- [] Checkout the items in the cart
  - [] Simulated by updating stock in database and sending to a confirmation page
  - [] Stripe integration if possible
- [] Allow the use to create an account
- [] Allow the user to sign in
- [] Users should not be able to set themselves as admins

# Tier 2: Logged In Users

- [] Logged in accounts should be able to see past orders
- [] Logged in accounts should be able to see last thing stored in their carts since last sign out

# Tier 3: Admin Access

- [] Able to create new users
- [] Able to create new admins
- [] Admins can create new products


# Helper Functions

- [] Helper Function to salt and hash password for safe keeping in database
- [] Possibly create a JWT although this can be handled with flask and might not even be an issue
- [] Find a way to set default values for certain SQL items as well as deal with some of the constraints, like image_url defaults or not empty strings

# Major Issues

- [] issue with any id over 10 causing a render error with viewing single products.


# If Time

- [] Go back and resize the photos to be similar size


# Screen Resolutions to Check

- [] 1600x900
- [] 1920x1080
- [] 1920x1200