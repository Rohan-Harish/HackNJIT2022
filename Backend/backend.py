from flask import Flask, request, json
import pandas as pd
import numpy as np
app = Flask(__name__)
df = pd.read_csv("ingredientsLookup.csv")
#print(df['name'])

@app.route("/")
def home():
    return "Hello, Flask!2"

@app.route("/eanlookup", methods=['POST'])
def lookup():
    global df 
    print(request)
    data = request.data
    print(data)
    datay = json.loads(data)
    print(datay)

    eannum = datay["ean"]
    #testean = [40000505273, 73430621114, 38000551437]
    avgscore = 0
    ingList = {"Milk Chocolate":9, "Corn Syrup":7,"Sugar":8,"Hydrogenated Palm Kernel Oil and/or Palm Oil":10, "less than 2% Milkfat":5,"Cocoa Powder processed with Alkali":6,"Malted Barley":7,"Salt":7,"Egg Whites":3,"Artificial Flavor.":10, "Natural Spring Water":0,"Enriched Flour":6,"Sugar High Fructose Corn Syrup":10,"Vegetable Oil":10,"Contains Two Percent Or Less of Salt":3,"Fructose":4,"Wheat Starch":5,"Rice Flour":5,"Calcium Carbonate":2,"Cornstarch":4,"Leavening":4,"Soy Lecithin":5,"Caramel Color":8,"Dextrose":6,"Maltodextrin":7,"Gelatin":8,"Sodium Stearoyl Lactylate":3,"Mono- And Diglycerides":2,"Color Added":9,"Natural And Artificial Flavor (Contains Milk)":8,"Modified Food Starch":6,"Confectioner's Glaze":6,"Carrageenan":6,"Cellulose Gum":5,"Carnauba Wax":5,"Vitamin A Palmitate":1,"Niacinamide":0,"Reduced Iron":0,"Red 40":10,"Yellow 6":10,"Pyridoxine Hydrochloride (Vitamin B6)":0,"Yellow 5":10,"Riboflavin (Vitamin B2)":0,"Gum Arabic":7,"Blue 2 Lake":10,"Thiamin Hydrochloride (Vitamin B1)":0,"Blue 1":10,"Annatto Color":10,"Xanthan Gum":8,"Folic Acid":0,"BHT (Preservative)":8,"Blue 2":10}
    # loc = df.loc[df["ean"] == str(eannum)].values.tolist()
    name = df.loc[df["ean"] == str(eannum), "name"].values.tolist()
    print(str(eannum) in df['ean'].tolist())
    inlist = df.loc[df["ean"] == str(eannum), "features.value"].values.tolist()
    ingredients = inlist[0].split(',')
    print(ingredients)

    print(name)
   
    print(ingredients)

    count = 0
    for ing in ingredients:
        #get score of each
        avgscore += ingList[ing]
        count+= 1
    avgscore = avgscore/count
    

    return {"name": name[0], "score": avgscore}


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
    
    # df = pd.read_csv("ingredientsLookup.csv")
