# image_template_matching

The goal of this code is to locate specific objects in an image and find the distance and relative angle between them. Locating objects is done via indexing a 2d cross-correlation matrix between the object and image for it's peak correlation. Once found, the euclidean distance and relative angle between two objects in the image can be calculated as a measure of their position relative to one another. 

This was written to score a spatial memory task in which participants placed recognized stimuli around a 2d map of a room they previously navigated. 
