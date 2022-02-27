# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

📝 `NOTE - PASTE PART 2 SNIPPET HERE:` Paste the README template for part 2 of this assignment here at the top. This will show a history of your development process, which users stories you completed and how your app looked and functioned at each step.

---

## Flix Part 1

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [ ] (2pt) User can view the app on various device sizes and orientations.
- [ ] (1pt) Run your app on a real device.

### App Walkthrough GIF

<img src="http://g.recordit.co/r5h5GaUf07.gif" width=250><br>

### Notes
Describe any challenges encountered while building the app.

The challenge I encountered while building the first part of this app was trying to 
resolve this error:
    Fatal error: Unexpectedly found nil while unwrapping an Optional value
This error was displaying on line 44 in my ViewController file which at the time was this:
    let posterPath = movie["[poster_path]"] as! String
I resolved this error by removing the internal square brackets around poster_path 
with the new line being:
    let posterPath = movie["poster_path"] as! String
I believe this error arose from accidentally pressing the square bracket button again after inserting the quotation marks.
