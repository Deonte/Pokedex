# Pokedex Requirements

## Dependencies *Alomofire, SD_WebImage, SwiftyJSON, PokemonAPI, 

## Features

1. User is able to search Pokemon, Items, and moves.
2. Each List shows first 20 Pokemon, Items, and moves in a list. For starters
3. Each tableview is clickable and will show a detailView of the clicked item.
4. The clicked item will include a photo of the pokemon, a short description of the pokemon, its type, Evolutions, 
    and moves set. Items/Moves as well.

## PokemonViewTab

1. This view contains a Navigation Controller  w/ SearchBar, and a TableView.
2. Each cell presents search results with a Sprite, PokemonName, Pokedex Number, and Type badge(s).
    ex. Charizard is a Fire as well as a Flying type Pokemon.
3. Upon tapping on the PokemonTab this shows a random list of 20 pokemon the user can explore if they don't have
    an pokemon to search for in mind.
    
## PokemonDetailView

1. This view will have a Larger Sprite, PokeName, PokeTypeImage, Evolutions, Moves that it can learn and at what Level.

### Evolutions - Sprites evolving from/to as well as the Level in which it evolves. In a tableView

### Moves - This will contain all the Moves the Pokemon can learn on its own, and the level at which it learns it. In a tableView


## MovesViewTab

1. This view contains a Navigation Controller w/ SearchBar, and a TableView.
2. Each Cell presents a MoveName, and MoveTypeImage.
3. Upon tapping on the MovesTab this shows a random list of 20 moves the user can explore if they don't have
    an move to search for in mind.
    
## MovesDetailView

1. This view will have an Image of a larger TypeImage, MoveName, Type, and MoveDescription

### Moves BasePower, Accuracy, and PP

## ItemViewTab

1. This view contains a Navigation Controller w/ SearchBar, and a TableView.
2. Each Cell presents a Sprite, ItemName, and in-game price.
3. Upon tapping on the ItemsTab this shows a random list of 20 items the user can explore if they don't have an item to search for in mind.


## ItemsDetailView

1. This view shows a larger ItemSprite, ItemName, ItemPrice, and Item Description


# Like To Haves.

### Create a database that stores all the pokedata at once. And saves them persistently using CoreData or Realm. To make the loading of data local rather than relying to heavily on the internet. 


### Or Create a favorites tab that stores data locally.
