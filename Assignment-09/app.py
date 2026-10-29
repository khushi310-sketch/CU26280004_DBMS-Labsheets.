
from flask import Flask, render_template, request, redirect, url_for, flash
from pymongo import MongoClient
from pymongo.errors import PyMongoError

app = Flask(__name__)
app.secret_key = "student-record-secret-key"

client = MongoClient("mongodb://localhost:27017/")
db = client["CollegeDB"]
students = db["students"]


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/test-db")
def test_db():
    try:
        client.admin.command("ping")
        return "MongoDB connected successfully!"
    except PyMongoError as e:
        return f"MongoDB connection failed: {e}"


@app.route("/add_student", methods=["GET", "POST"])
def add_student():
    if request.method == "POST":
        roll_no = request.form.get("roll_no", "").strip()
        name = request.form.get("name", "").strip()
        course = request.form.get("course", "").strip()
        email = request.form.get("email", "").strip()

        if not all([roll_no, name, course, email]):
            flash("Please fill in all fields.")
            return redirect(url_for("add_student"))

        if students.find_one({"roll_no": roll_no}):
            flash("This roll number already exists.")
            return redirect(url_for("add_student"))

        student = {
            "roll_no": roll_no,
            "name": name,
            "course": course,
            "email": email
        }

        try:
            students.insert_one(student)
            flash("Student added successfully!")
            return redirect(url_for("add_student"))
        except PyMongoError:
            flash("Could not save student. Check MongoDB connection.")

    return render_template("add_student.html")

@app.route("/students")
def view_students():
    all_students = list(students.find().sort("roll_no", 1))
    return render_template("students.html", students=all_students)


@app.route("/search_student", methods=["GET", "POST"])
def search_student():
    student = None
    searched = False

    if request.method == "POST":
        roll_no = request.form.get("roll_no", "").strip()
        searched = True

        if roll_no:
            student = students.find_one({"roll_no": roll_no})

    return render_template(
        "search_student.html",
        student=student,
        searched=searched
    )


@app.route("/update_student", methods=["GET", "POST"])
def update_student():
    student = None
    message = None

    if request.method == "POST":
        roll_no = request.form.get("roll_no", "").strip()
        action = request.form.get("action", "search")

        if action == "search":
            student = students.find_one({"roll_no": roll_no})
            if not student:
                message = "Student not found."

        elif action == "update":
            name = request.form.get("name", "").strip()
            course = request.form.get("course", "").strip()
            email = request.form.get("email", "").strip()

            if all([roll_no, name, course, email]):
                result = students.update_one(
                    {"roll_no": roll_no},
                    {"$set": {
                        "name": name,
                        "course": course,
                        "email": email
                    }}
                )

                if result.matched_count:
                    message = "Student updated successfully!"
                    student = students.find_one({"roll_no": roll_no})
                else:
                    message = "Student not found."
            else:
                message = "Please fill in all fields."

    return render_template(
        "update_student.html",
        student=student,
        message=message
    )


@app.route("/delete_student", methods=["GET", "POST"])
def delete_student():
    message = None

    if request.method == "POST":
        roll_no = request.form.get("roll_no", "").strip()

        if roll_no:
            result = students.delete_one({"roll_no": roll_no})

            if result.deleted_count > 0:
                message = "Student deleted successfully!"
            else:
                message = "Student not found."
        else:
            message = "Please enter a roll number."

    return render_template("delete_student.html", message=message)


if __name__ == "__main__":
    app.run(debug=True)

