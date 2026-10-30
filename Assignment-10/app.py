
from flask import Flask, render_template, request, redirect, url_for, flash
from pymongo import MongoClient
from pymongo.errors import PyMongoError

app = Flask(__name__)
app.secret_key = "hospital-medicine-project-key"

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/", serverSelectionTimeoutMS=3000)
db = client["HospitalDB"]
medicines = db["medicines"]


@app.route("/")
def home():
    return render_template("index.html")


# Add Medicine
@app.route("/add", methods=["GET", "POST"])
def add_medicine():
    if request.method == "POST":
        try:
            medicine = {
                "medicine_id": request.form["medicine_id"].strip(),
                "name": request.form["name"].strip(),
                "category": request.form["category"].strip(),
                "price": float(request.form["price"]),
                "stock": int(request.form["stock"]),
                "manufacturer": request.form["manufacturer"].strip()
            }

            if not all([
                medicine["medicine_id"],
                medicine["name"],
                medicine["category"],
                medicine["manufacturer"]
            ]):
                flash("Please fill in all fields.")
                return redirect(url_for("add_medicine"))

            if medicine["price"] < 0 or medicine["stock"] < 0:
                flash("Price and stock cannot be negative.")
                return redirect(url_for("add_medicine"))

            if medicines.find_one({"medicine_id": medicine["medicine_id"]}):
                flash("Medicine ID already exists.")
                return redirect(url_for("add_medicine"))

            medicines.insert_one(medicine)
            flash("Medicine added successfully!")
            return redirect(url_for("view_medicines"))

        except (ValueError, KeyError):
            flash("Enter a valid price and stock.")
        except PyMongoError:
            flash("Could not save medicine. Check MongoDB connection.")

    return render_template("add_medicine.html")


# View Medicines
@app.route("/medicines")
def view_medicines():
    try:
        all_medicines = list(medicines.find({}, {"_id": 0}).sort("medicine_id", 1))
        return render_template("medicines.html", medicines=all_medicines)
    except PyMongoError:
        flash("Could not load medicines. Check MongoDB connection.")
        return render_template("medicines.html", medicines=[])


# Search Medicine
@app.route("/search", methods=["GET", "POST"])
def search_medicine():
    results = []
    searched = False

    if request.method == "POST":
        searched = True
        keyword = request.form.get("keyword", "").strip()

        if keyword:
            try:
                results = list(medicines.find({
                    "$or": [
                        {"medicine_id": {"$regex": keyword, "$options": "i"}},
                        {"name": {"$regex": keyword, "$options": "i"}}
                    ]
                }, {"_id": 0}))
            except PyMongoError:
                flash("Search failed. Check MongoDB connection.")

    return render_template(
        "search_medicine.html",
        medicines=results,
        searched=searched
    )


# Update Medicine Stock
@app.route("/update", methods=["GET", "POST"])
def update_stock():
    if request.method == "POST":
        medicine_id = request.form.get("medicine_id", "").strip()

        try:
            new_stock = int(request.form.get("stock", ""))

            if new_stock < 0:
                flash("Stock cannot be negative.")
            else:
                result = medicines.update_one(
                    {"medicine_id": medicine_id},
                    {"$set": {"stock": new_stock}}
                )

                if result.matched_count:
                    flash("Medicine stock updated successfully!")
                else:
                    flash("Medicine ID not found.")

        except ValueError:
            flash("Please enter a valid whole number for stock.")
        except PyMongoError:
            flash("Could not update stock. Check MongoDB connection.")

        return redirect(url_for("update_stock"))

    return render_template("update_stock.html")


# Delete Medicine
@app.route("/delete", methods=["GET", "POST"])
def delete_medicine():
    if request.method == "POST":
        medicine_id = request.form.get("medicine_id", "").strip()

        try:
            result = medicines.delete_one({"medicine_id": medicine_id})

            if result.deleted_count:
                flash("Medicine deleted successfully!")
            else:
                flash("Medicine ID not found.")

        except PyMongoError:
            flash("Could not delete medicine. Check MongoDB connection.")

        return redirect(url_for("delete_medicine"))

    return render_template("delete_medicine.html")


# Low Stock Medicines
@app.route("/low-stock")
def low_stock():
    try:
        low_medicines = list(
            medicines.find(
                {"stock": {"$lt": 30}},
                {"_id": 0}
            ).sort("stock", 1)
        )

        return render_template(
            "low_stock.html",
            medicines=low_medicines
        )

    except PyMongoError:
        flash("Could not load low-stock medicines. Check MongoDB.")
        return render_template("low_stock.html", medicines=[])


# Inventory Report
@app.route("/report")
def inventory_report():
    try:
        total_medicines = medicines.count_documents({})
        
        summary = list(medicines.aggregate([
            {
                "$group": {
                    "_id": None,
                    "total_stock": {"$sum": "$stock"}
                }
            }
        ]))

        total_stock = summary[0]["total_stock"] if summary else 0
        low_stock_count = medicines.count_documents({"stock": {"$lt": 30}})

        most_expensive = medicines.find_one(
            {}, {"_id": 0}, sort=[("price", -1)]
        )
        cheapest = medicines.find_one(
            {}, {"_id": 0}, sort=[("price", 1)]
        )

        return render_template(
            "report.html",
            total_medicines=total_medicines,
            total_stock=total_stock,
            low_stock_count=low_stock_count,
            most_expensive=most_expensive,
            cheapest=cheapest
        )

    except PyMongoError:
        flash("Could not generate report. Check MongoDB connection.")
        return render_template(
            "report.html",
            total_medicines=0,
            total_stock=0,
            low_stock_count=0,
            most_expensive=None,
            cheapest=None
        )

if __name__ == "__main__":
    app.run(debug=True)
