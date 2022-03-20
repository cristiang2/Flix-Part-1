# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [x] (5pts) User can tap a cell to see more details about a particular movie.
- [x] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [ ] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [ ] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

### App Walkthrough GIF

<img src="http://g.recordit.co/Bv8su0tx1l.gif" width=250><br>

### Notes
Describe any challenges encountered while building the app.

The challenge I faced in this part was trying to get my movie poster images enlarged. I looked through the Collection View size inspector side pane and tinkered with various settings. I tried changing the autoresizing and layout as well as the arrange view. Ultimately, I saw the solution on codepath's assignment page and set the estimate size to none in the collection view.

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

<img src="http://g.recordit.co/8raG8Yv3Fl.gif" width=250><br>

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
