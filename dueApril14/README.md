# Data Visualization
Comparing Airbnb prices of different neighborhoods of Buenos Aires, Argentina

Check out the [sample video](https://youtu.be/lbSguHTDa7k) and the [full code](/dueApril14/data_visualization.pde).

<img src="initial.png" alt="initial" width="350" height="390"><img src="display.png" alt="game" width="350" height="390">

## Concept
For this week's assignment, we were asked to use Processing to get some free public data for analysis and use it to create some visualization.
I decided to access data of over 20,000 Airbnb listings in Buenos Aires and compare the average price per night of every neighborhood.

(FYI, I chose to do data on Buenos Aires, and not some other location, because I had the privilege of going there over J-term for a film class and fell in love with the city.)

## Features
The window has a nice image of San Telmo as the background and some text as well.

On the top right and bottom right, we have the title, description, and the date of data compilation.

On the left side of the window, we have a list of 48 neighborhoods of Buenos Aires that have at least 1 listing on Airbnb.
The font size is mapped to the average price per night, which means that the bigger the font of the neighborhood, the more expensive it is on Airbnb.

When the user uses the mouse and hovers over the name of the neighborhood, its name displays on the right side, so even the cheap neighborhoods, which are hard to see on the left, can be seen clearly.
Below the name, we have the price displayed in both Argentine pesos (ARS) and US dollars (USD).

## Challenges
The way I structured data did not allow me to sort the neighborhoods in the order of price, with the neighborhood with the highest price in the front.
I could have used a sorting algorithm to do so, but because I am on Processing and Java is not my main language, it was hard to figure this out just over the weekend.
This is why the order in which neighborhoods appear on the left is the order in which the first listing of that neighborhood appears in the Airbnb data, which is sorted by their opened date.

Also, another self-critique is that my code requires a lot of memory allocation.
I feel like there is a better way to structure my data without requiring four separate lists that are used just to fill up the main data, but again, for the sake of time, I did this because it was simple and intuitive.

Finally, the data itself is not really an accurate depiction of how expensive a neighborhood is. It doesn't take into account other factors, such as room type.
Some listings are a shared room, while others are an entire villa. This means that the price for each listing is not fully dependent on the neighborhood itself.
Although I recognize this, I thought that the relationship between neighborhood and average price per night was still visually interesting to see for a simple assignment like this.

## Reference
Free Airbnb Data: http://insideairbnb.com/get-the-data.html

Image source: https://explorewithlora.com/neighbourhoods-in-buenos-aires/
