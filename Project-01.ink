/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
   - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/
VAR intellect = 0
VAR strength = 0
VAR lighter = 0
VAR dime = 0

Your footsteps echo hollowly through the empty building. The air is stale and smells faintly of mildew.
Outside, rain pours relentlessly.
+[Check self]->checkself

==checkself==
You're soaked from head to toe, but otherwise fine. 
The storm had begun abruptly, and you were lucky to have stumbled across some kind of shelter. It took some work, but you were able to get inside.
+[You had to force open the doors.]->strengthknot
+[You had to find another entrance.]->intellectknot

==strengthknot==
~strength=strength+2
You rub your shoulder sorely, recalling slamming against the door and tumbling inside.
+[Look around]->mainarea

==intellectknot==
~intellect=intellect+2
Faced with an impassable front door, you were forced to climb inside through an unlocked window.
+[Look around]->mainarea

==mainarea==
You are in the main room. Its rather cold and weirdly empty. You're next to a couple of tables, and in front of you, on the far left, is a hallway. Behind you is the main entrance. {energydrink:On the right... a door?}{proteinbar:On the right... a door?}
+[Entrance]->mainentrance
+[Tables]->tables
+[Hallway]->hallwayroom
+{energydrink}[Door]->rightdoor
+{proteinbar}[Door]->rightdoor

==tables==
There are a couple cardboard boxes and scattered papers atop the tables.
*[Look through boxes]->boxes
+[Return]->mainarea

==boxes==
~lighter=lighter+1
Nothing of much interest. Although, you do find a cool looking lighter. Not a cheap one either, it has raised, intracate designs and a crisp, metallic sheen.
You decide to pocket it.
[You gained a lighter.]
+[Return]->tables

==mainentrance==
The storm rages outside. It isn't safe to leave yet.
+[Return]->mainarea

==hallwayroom==
You find yourself in a small room. Its a breakroom. It has a couple of chairs, tables, and a vending machine. There are a few motivational posters hung up on the walls.
*[Vending machine]->vendingmachine
+[Return to main room]->mainarea

==vendingmachine==
As you approach the vending machine you reach into your pocket. Looks like you have enough for one item.
*[Energy drink]->energydrink
*[Protein bar]->proteinbar

==energydrink==
~intellect=intellect+1
You grab the energy drink. After finishing it, your mind feels a bit clearer.
*[Return]->hallwayroom

==proteinbar==
~strength=strength+1
You grab the protein bar. After finishing it, your body feels a bit stronger.
*[Return]->hallwayroom

==rightdoor==
Strange, you didn't notice it at first, but there is a door on the right wall.
+[Open door]->rightroom

==rightroom==
As the door shuts behind you, you notice something perculiar--that is, the size of the room. Its cold, long, and poorly lit. Whats more, it seems a little too big for the building itself.
+[Return to main room]->thunder

==thunder==
As you start to move, you startle as a loud crash of thunder rings out and the lights flicker nervously.
As you regain your compusure, you turn to leave. But to your surprise, the door has been replaced with apathetic, grey wall.
The lights tremble once more before going out. It is completely dark.
+{lighter>0}[Use lighter]->roomlit
+{lighter==0}[Search for door]->badending


==roomlit==
You flick the lighter a few times before it ignites. The room comes back into view.
->rightroomlit

==rightroomlit==
The room is cold, long, and notably doorless. The walls are smooth and unbroken and there don't seem to be any objects in the room. {&You hear a soft tapping sound|The room groans.|You notice a scraping.}
*[Floor]->floor
+[Walls]->walls
+[Ceiling]->ceiling

==floor==
~dime=dime+1
You travel the length of the room, closely inspecting the floor. You find some lint, some gravel, and a dime.
[You gained a dime.]
+[Return]->rightroomlit
->END

==walls==
You walk the perimeter of the room. You run your hands along the walls and find they are totally smooth. About halfway through you notice a large vent.
+[Open vent]->vent

==vent==
This could be your way out!
But... the vent is screwed tightly into the wall.
+{strength>2}[Force vent open]->inthevent
+{intellect>2}[Open the vent]->intvent

==intvent==
You could unscrew the vent if you had some sort of tool.
+{dime>0}[Use dime]->inthevent
+[Return]->vent

==ceiling==
You observe the ceiling closely. Except for the lights--which no longer even work--it is completely barren. You stop, unsatisfied.
+[Return]->rightroomlit

==badending==
Unable to see, you fumble around blindly in the darkness. You feel along the room's endless, smooth walls, finding nothing.
Eventually exhausted, you fall asleep waiting for morning. You don't wake back up.->END

==inthevent==
You open the vent and climb inside. Holding your lighter in front of you, you guide yourself through a long maze. Eventually you make it outside.
You let out a sigh of relief. Who knows if someone would've been able to find you out here? You hike back to the main road.
Despite returning to the trail on several occasions, you were never able to find that building again.
->END

