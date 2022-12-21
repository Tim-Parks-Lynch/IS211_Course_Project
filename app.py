from flask import Flask
from flask import render_template
from flask import redirect
from flask import url_for
from flask import flash
import sqlite3

app = Flask(__name__)

app.secret_key = (
    "192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf"
)

SINGLE_PRODUCT_QUERY = "SELECT * FROM products WHERE id=?"
ALL_PRODUCT_QUERY = "SELECT * FROM products"
ALL_CARTS = "SELECT * FROM cart"
ALL_CART_ITEMS = "SELECT * FROM cart_items ci JOIN products pt ON pt.id = ci.product_id ORDER BY id DESC LIMIT 1"
# ci JOIN cart ct ON ci.cart_id = ct.id JOIN products pt ON pt.id = ci.cart_id"
ADD_TO_CART_NEW_QUERY = "INSERT INTO cart_items(product_id, price_at_purchase, quantity, image_url, name)VALUES(?, ?, 1, ?, ?)"
ADD_TO_CART_ITEM_ALREADY_QUERY = "UPDATE cart_items SET quantity=? WHERE id=?"
USER_CART = [
    {
        "name": "Victor Super Premium Dog Food",
        "image_url": "https://m.media-amazon.com/images/I/81QKEvc49KL._AC_SS450_.jpg",
        "price": 5399,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 2,
    },
    {
        "name": "Purina Pro Plan Large/Giant breed (34 lbs)",
        "image_url": "https://assets.petco.com/petco/image/upload/f_auto,q_auto/2986205-center-1",
        "price": 5248,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
    {
        "name": "Cat Toy Rotating Butterfly",
        "image_url": "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg",
        "price": 2199,
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "quantity": 1,
    },
]


def get_db_connection():
    conn = sqlite3.connect("petazon.db")
    conn.row_factory = sqlite3.Row
    return conn


# NAVBAR LOGIC #
# The navbar will have the following three states and only these states
# 1.isAdmin=False, isLoggedIn=False,
# 2. isAdmin=False, isLoggedIn=True,
# 3. isAdmin=True, isLoggedIn=True,
# You should never has isAdmin=True if isLoggedIn=False


@app.route("/")
@app.route("/home")
def home():
    conn = get_db_connection()
    products = conn.execute(ALL_PRODUCT_QUERY)
    return render_template(
        "all_products.html", isAdmin=False, isLoggedIn=False, Products=products
    )


@app.route("/products/<product_num>", methods=["GET", "POST"])
def view_single_product(product_num):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(SINGLE_PRODUCT_QUERY, product_num)
    row = cur.fetchone()
    return render_template(
        "single_product.html", isAdmin=True, isLoggedIn=True, product=row
    )


@app.route("/add_to_cart/<product_id>")
def add_to_cart(product_id):
    # conn = get_db_connection()
    # cur = conn.cursor()
    # cur.execute(SINGLE_PRODUCT_QUERY, product_id)
    # # cur.execute(ALL_CART_ITEMS)
    # row = cur.fetchall()
    # USER_CART.append(row)
    # print(USER_CART)
    flash("Product added to Cart")
    return redirect(url_for("home"))


@app.route("/cart")
def view_cart():
    # cart = []
    # conn = get_db_connection()
    # cur = conn.cursor()
    # data = cur.execute(ALL_CART_ITEMS)
    # print(data.description)
    # row = cur.fetchone()
    # result = list(row)
    # print(result)
    # cart.append(row)
    # print(cart[0])
    return render_template(
        "cart.html", isAdmin=True, isLoggedIn=True, cart=USER_CART
    )


@app.route("/checkout")
def view_checkout():
    return render_template(
        "checkout.html", isAdmin=True, isLoggedIn=True, cart=USER_CART
    )


@app.route("/admin")
def view_admin():
    return render_template(
        "admin_add_product.html", isAdmin=True, isLoggedIn=True
    )


@app.route("/logout")
def view_logout():
    flash("You have been logged out")
    return redirect(url_for("home"))


@app.route("/signup")
def view_signup():
    return render_template("signup.html", isAdmin=False, isLoggedIn=False)


@app.route("/login")
def view_login():
    return render_template("login.html", isAdmin=False, isLoggedIn=False)


app.run(debug=True)
