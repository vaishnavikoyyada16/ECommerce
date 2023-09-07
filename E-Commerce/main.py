import psycopg2
from flask import Flask, render_template, request, redirect,session
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
import sqlalchemy
app = Flask(__name__)
app.secret_key = 'Vaishu'
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://postgres:Vaishu%40843@localhost:5432/ECommerce"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
Base = automap_base()
engine = sqlalchemy.create_engine('postgresql://postgres:Vaishu%40843@localhost:5432/ECommerce', pool_pre_ping=True)
curr_session = Session(engine)
Base.prepare(autoload_with = engine)
db = SQLAlchemy(app)
conn = psycopg2.connect( host="localhost",database="ECommerce",user="postgres",password="Vaishu@843")
cur = conn.cursor()
customer_data = Base.classes.customer_data
order_details=Base.classes.order_details
product_details=Base.classes.product_details
promotion_details=Base.classes.promotion_details
login_details=Base.classes.login_details
login_details_adm=Base.classes.login_details_adm

@app.route('/')
def initial():
    return render_template('initial.html')

@app.route('/cus_index')
def cus_index():
    return render_template('cus_index.html')

@app.route('/signup')
def signup():
    return render_template('signup.html')

@app.route('/logins')
def logins():
    return render_template('logins.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/customers')
def customers():
    return render_template('customers.html')

@app.route('/orders')
def orders():
    return render_template('orders.html')

@app.route('/search_products')
def search_products():
    return render_template('search_products.html')

@app.route('/products')
def products():
    return render_template('products.html')

@app.route('/cat_pro')
def cat_pro():
    return render_template('cat_pro.html')

@app.route('/promotions')
def promotions():
    return render_template('promotions.html')

@app.route('/add_cust')
def add_cust():
    return render_template('add_cust.html')

@app.route('/del_cust')
def del_cust():
    return render_template('del_cust.html')

@app.route('/edit_custs')
def edit_custs():
    return render_template('edit_custs.html')

@app.route('/edit_ord')
def edit_ord():
    return render_template('edit_ord.html')

@app.route('/edit_promote')
def edit_promote():
    return render_template('edit_promote.html')

@app.route('/edit_pro')
def edit_pro():
    return render_template('edit_pro.html')

@app.route('/add_pro')
def add_pro():
    return render_template('add_pro.html')

@app.route('/del_pro')
def del_pro():
    return render_template('del_pro.html')

@app.route('/add_ord')
def add_ord():
    return render_template('add_ord.html')

@app.route('/del_ord')
def del_ord():
    return render_template('del_ord.html')

@app.route('/add_promote')
def add_promote():
    return render_template('add_promote.html')

@app.route('/del_promote')
def del_prompte():
    return render_template('del_promote.html')

@app.route('/view_cust')
def view_cust():
    cur.execute("select customer_id,email from customer_data;")
    customers_list = cur.fetchall()
    customers_list = [cus for cus in customers_list]
    print(customers_list)
    return render_template('view_cust.html', customer_data=customers_list)

@app.route('/view_ord')
def view_ord():
    cur.execute("select order_id,customer_id from order_details;")
    orders_list = cur.fetchall()
    orders_list = [ord for ord in orders_list]
    print(orders_list)
    return render_template('view_ord.html', order_details=orders_list)

@app.route('/my_orders')
def my_orders():
    customer_id = session.get('customer_id')
    cur.execute(f"SELECT order_id, customer_id, status, purchase_timestamp, delivered_timestamp, estimated_delivery_timestamp FROM order_details WHERE customer_id='{customer_id}';")
    orders_list = cur.fetchall()
    orders_list = [ord for ord in orders_list]
    print(orders_list)
    return render_template('my_orders.html', order_details=orders_list)

@app.route('/view_pro')
def view_pro():
    cur.execute("select product_id,category_name from product_details;")
    products_list = cur.fetchall()
    products_list = [pro for pro in products_list]
    print(products_list)
    return render_template('view_pro.html', product_details=products_list)

@app.route('/view_promote')
def view_promote():
    cur.execute("select type_id,promotion_type from promotion_details;")
    promotions_list = cur.fetchall()
    promotions_list = [promote for promote in promotions_list]
    print(promotions_list)
    return render_template('view_promote.html', promotion_details=promotions_list)

@app.route('/query')
def query():
    return render_template('query.html')

@app.route('/execute_query', methods=['POST'])
def execute_query():
    sql_query = request.form['query']
    cur.execute(sql_query)
    query_results = cur.fetchall()
    column_names = [desc[0] for desc in cur.description]
    return render_template('query.html', query_results=query_results, column_names=column_names)

@app.route('/customer/add', methods=["POST"])
def add_new_cust():
        customer_id = request.form["cust_id"]
        email = request.form["email_name"]
        zipcode = request.form["zip"]
        record = customer_data(customer_id=customer_id, email=email,zipcode=zipcode)
        curr_session.add(record)
        curr_session.flush()
        curr_session.commit()
        return redirect('/customers')

@app.route('/delete_cust', methods=['GET'])
def delete_customer():
    customer_id = request.args.get('cust_id')
    rows_deleted = db.session.query(customer_data).filter_by(customer_id=customer_id).delete()
    db.session.commit()
    if rows_deleted > 0:
        return redirect('/customers')
    else:
        return "Customer not found"


@app.route("/update_customer", methods=["GET", "POST"])
def update_customer():
    if request.method == "POST":
        customer_id = request.form["customer_id"]
        email = request.form["email"]
        zipcode = request.form["zipcode"]
        customer = curr_session.query(customer_data).filter_by(customer_id=customer_id).first()
        if customer:
            customer.email = email
            customer.zipcode = zipcode
            curr_session.commit()
    return redirect('/customers')

@app.route('/order/add', methods=["POST"])
def add_new_ord():
        order_id = request.form["order_id"]
        customer_id = request.form["customer_id_name"]
        status = request.form["status"]
        purchase_timestamp = request.form["purchase"]
        delivered_timestamp = request.form["delivery"]
        estimated_delivery_timestamp = request.form["estimated"]
        record = order_details(order_id=order_id, customer_id=customer_id,status=status,purchase_timestamp=purchase_timestamp,delivered_timestamp=delivered_timestamp,estimated_delivery_timestamp=estimated_delivery_timestamp)
        curr_session.add(record)
        curr_session.flush()
        curr_session.commit()
        return redirect('/orders')

@app.route('/delete_ord', methods=['GET'])
def delete_order():
    order_id = request.args.get('ord_id')
    rows_deleted = db.session.query(order_details).filter_by(order_id=order_id).delete()
    db.session.commit()
    if rows_deleted > 0:
        return redirect('/orders')
    else:
        return "Customer not found"

@app.route("/update_order", methods=["GET", "POST"])
def update_order():
    if request.method == "POST":
        order_id = request.form["order_id"]
        customer_id = request.form["customer_id_name"]
        status = request.form["status"]
        purchase_timestamp=request.form["purchase"]
        delivered_timestamp=request.form["delivery"]
        estimated_delivery_timestamp=request.form["estimated"]
        order = curr_session.query(order_details).filter_by(order_id=order_id).first()
        if order:
            order.status = status
            order.purchase_timestamp = purchase_timestamp
            order.delivered_timestamp=delivered_timestamp
            order.estimated_delivery_timestamp=estimated_delivery_timestamp
            curr_session.commit()
        curr_session.close()
    return redirect('/orders')

@app.route('/product/add', methods=["POST"])
def add_new_pro():
        product_id = request.form["product_id"]
        category_name = request.form["category_name"]
        weight = request.form["weight"]
        length = request.form["length"]
        height = request.form["height"]
        width = request.form["width"]
        record = product_details(product_id=product_id, category_name=category_name,weight=weight,length=length,height=height,width=width)
        curr_session.add(record)
        curr_session.flush()
        curr_session.commit()
        return redirect('/products')

@app.route('/delete_pro', methods=['GET'])
def delete_product():
    product_id = request.args.get('pro_id')
    rows_deleted = db.session.query(product_details).filter_by(product_id=product_id).delete()
    db.session.commit()
    if rows_deleted > 0:
        return redirect('/products')
    else:
        return "Product not found"


@app.route("/update_products", methods=["GET", "POST"])
def update_products():
    if request.method == "POST":
        product_id = request.form["product_id"]
        category_name = request.form["category_name"]
        weight = request.form["weight"]
        length=request.form["length"]
        height=request.form["height"]
        width=request.form["width"]
        print(weight,length,height,width)
        product = curr_session.query(product_details).filter_by(product_id=product_id).first()
        if product:
            product.category_name=category_name
            product.weight=weight
            product.length=length
            product.height=height
            product.width=width
            curr_session.commit()
    return redirect('/products')

@app.route('/promote/add', methods=["POST"])
def add_new_promote():
        type_id = request.form["type_id"]
        promotion_type = request.form["promotion_type"]
        discount_percentage = request.form["discount"]
        record = promotion_details(type_id=type_id, promotion_type=promotion_type,discount_percentage=discount_percentage)
        curr_session.add(record)
        curr_session.flush()
        curr_session.commit()
        return redirect('/promotions')

@app.route('/delete_promote', methods=['GET'])
def delete_promote():
    type_id = request.args.get('promote_id')
    rows_deleted = db.session.query(promotion_details).filter_by(type_id=type_id).delete()
    db.session.commit()
    if rows_deleted > 0:
        return redirect('/promotions')
    else:
        return "Product not found"

@app.route("/update_promotion", methods=["GET", "POST"])
def update_promotion():
    if request.method == "POST":
        type_id = request.form["type_id"]
        promotion_type = request.form["promotion_type"]
        discount_percentage = request.form["discount"]
        promotion = curr_session.query(promotion_details).filter_by(type_id=type_id).first()
        if promotion:
            promotion.promotion_type=promotion_type
            promotion.discount_percentage=discount_percentage
            curr_session.commit()
    return redirect('/promotions')

@app.route('/login/add', methods=["POST"])
def add_new_login():
        name = request.form["name"]
        email_id = request.form["email"]
        password = request.form["password"]
        record = login_details(name=name, email_id=email_id,password=password)
        curr_session.add(record)
        curr_session.flush()
        curr_session.commit()
        return redirect('/logins')

@app.route('/login_p', methods=['GET'])
def login_p():
        email_id = request.args.get('email')
        password = request.args.get('password')
        user = db.session.query(login_details_adm).filter_by(email_id=email_id, password=password).first()
        customer = db.session.query(customer_data).filter_by(email=email_id).first()
        if user:
            session['customer_id'] = 0
            return redirect('/customers')
        else:
             return "User not found"


@app.route('/login_p_c', methods=['GET'])
def login_p_c():
        email_id = request.args.get('email')
        password = request.args.get('password')
        user = db.session.query(login_details).filter_by(email_id=email_id, password=password).first()
        customer = db.session.query(customer_data).filter_by(email=email_id).first()
        if user:
            session['customer_id'] = customer.customer_id
            return redirect('/search_products')
        else:
             return "User not found"

@app.route('/search_pro', methods=['GET'])
def search_pro():
    category_name = request.args.get('category_name')
    cur.execute(f"SELECT product_id, category_name, weight, length, height, width FROM product_details WHERE category_name='{category_name}';")
    pros_list = cur.fetchall()
    pros_list = [pros for pros in pros_list]
    print(pros_list)
    return render_template('cat_pro.html', product_details=pros_list)

@app.route('/my_details')
def my_details():
    customer_id = session.get('customer_id')
    cur.execute(f"SELECT customer_id, zipcode, email FROM customer_data WHERE customer_id='{customer_id}';")
    customers_list = cur.fetchall()
    customers_list = [cus for cus in customers_list]
    print(customers_list)
    return render_template('my_details.html', customer_data=customers_list)
app.run(host='0.0.0.0' , port=9999)