//declare display variables
PImage img;
PFont regular;
PFont bold;

//declare data variables
Table table;
StringList neighbourhoods;
IntList prices;
IntList listings;
IntList averages;
Place[] places;

void setup() {
  size(700, 780);

  //initialize display variables
  img = loadImage("photo.png");
  regular = createFont("Atures.ttf", 32);
  bold = createFont("AturesBold.ttf", 32);

  //initialize data variables
  table = loadTable("listings.csv", "header");
  neighbourhoods = new StringList();
  prices = new IntList();
  listings = new IntList();
  averages = new IntList();

  //fill data first so places can use the data
  fillData();
  fillPlaces();
}

void draw() {
  background(255);  //white background
  tint(255, 126);   //opacity
  image(img, 0, 0, width, height);  //resize image to make it fit the window
  fill(0);          //black text
  displayText();    //display text
}



//function definitions

void fillData() {
  // Read neighbourhood and price for each listing
  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    String nbh = row.getString("neighbourhood");
    int p = row.getInt("price");

    if (!neighbourhoods.hasValue(nbh)) {            //this listing's neighbourhood is not in the list
      neighbourhoods.append(nbh);                            //add neighbourhood
      prices.append(p);                                      //add price
      listings.append(1);                                    //it's the first listing in the neighbourhood
    } else {                                        //this listing's neighbourhood is in the list
      for (int j = 0; j < neighbourhoods.size(); j++) {       //go through the list
        if (neighbourhoods.get(j).equals(nbh)) {                 //find the existing neighbourhood
          prices.set(j, prices.get(j) + p);                         //update price and listing for calculations later
          listings.set(j, listings.get(j) + 1);
        }
      }
    }
  }

  // Calculate the average price per neighbourhood
  for (int i = 0; i < neighbourhoods.size(); i++) {
    averages.append(prices.get(i)/listings.get(i));
  }
}

class Place {
  //attributes
  String name;
  int price;
  int listing;
  float y1, y2, font;

  //constructor
  Place(String n, int p, int l) {
    name = n;
    price = p;
    listing = l;
  }
}

void fillPlaces() {
  //initialize variables
  places = new Place[neighbourhoods.size()];
  float y = 10;

  for (int i = 0; i < places.length; i++) {
    //call constructor
    places[i] = new Place(neighbourhoods.get(i), averages.get(i), listings.get(i));

    //modify other attributes
    places[i].y1 = y;
    places[i].font = map(places[i].price, 0, 15000, 5, 45); //prices 0 to 15000 mapped to font 5 to 45
    places[i].y2 = y+places[i].font;

    //update y for the next for loop iteration
    y += places[i].font + 2;
  }
}

void displayText() {
  int margin = 10;

  //display title, description, etc.
  textFont(bold);
  textAlign(RIGHT);
  textSize(30);
  text("Airbnb Listings in", width-margin, 50);
  text("Buenos Aires, Argentina", width-margin, 90);

  textFont(regular);
  textSize(20);
  text("Average price per night", width-margin, 150);
  text("for each neighborhood", width-margin, 180);

  textAlign(RIGHT, BOTTOM);
  textSize(15);
  text("Compiled on March 19, 2020", width-margin, height-margin-20);
  text("Created by Brian Kim", width-margin, height-margin);  


  //go through places
  for (int i = 0; i < places.length; i++) {
    //display each place on the left side with its respective font size
    textFont(regular);
    textAlign(LEFT, TOP);
    textSize(places[i].font);
    text(places[i].name, margin, places[i].y1);

    //if mouseY is between the place's y1 and y2
    if (mouseY > places[i].y1 && mouseY < places[i].y2) {
      //display that place's name and price in ARS and USD on the right side
      textFont(bold);
      textAlign(RIGHT, TOP);
      textSize(40);
      text(places[i].name, width-margin, height/2);
      textSize(30);
      text(places[i].price + " ARS", width-margin, height/2+60);
      textSize(20);
      text(places[i].price/80 + " USD", width-margin, height/2+100); //conversion 80 ARS = USD
    }
  }
}
