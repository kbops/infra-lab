from flask import Flask, render_template, request, redirect, url_for
import socket
import datetime

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        f_name = request.form.get("f_name", "Captain")
        l_name = request.form.get("l_name", "Kube")
        friends = request.form.get("friends", "Саня,Сергій,Богдан,Паша")
        return redirect(url_for("ship", f_name=f_name, l_name=l_name, friends=friends))
    return render_template("index.html")

@app.route("/ship")
def ship():
    f_name = request.args.get("f_name", "Captain")
    l_name = request.args.get("l_name", "Kube")
    friends_str = request.args.get("friends", "Саня,Сергій,Богдан,Паша")
    names = [x.strip() for x in friends_str.split(",") if x.strip()]

    myip = socket.gethostbyname(socket.gethostname())
    hostname = socket.gethostname()
    date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    return render_template("result.html",
                           f_name=f_name,
                           l_name=l_name,
                           names=names,
                           myip=myip,
                           hostname=hostname,
                           date=date)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
