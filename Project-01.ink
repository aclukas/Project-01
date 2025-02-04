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

-> start

VAR satchelinven = 0
VAR flashlightinven = 0
VAR splint = 0
VAR sticks = 0
VAR sweatshirt = 0
VAR granola = 0
VAR treasure = 0

==start==
You stand excitedly at the entrance of a cave. It's not on your map, which means it's completely undiscovered!
+[Enter the cave]->entercave

==entercave==
You clutch your satchel and flashlight as you make your way inside.
+[Keep walking]->prefall
==prefall==
You're about 5 minutes away from the entrance when you suddenly lose your footing, tumbling down a conveniently leaf-covered hole.
->fall

==fall==
{not injuries: As you fall, your body is thrown around violently, somehow colliding with every single obstacle on its way down. You finally reach the ground, propping yourself up as you try to catch your breath.}
*[Check yourself for injuries]-> injuries
*{injuries}[Look around]-> lookaround

==injuries==
Your body aches and something feels very wrong with your right leg. You can barely put any weight on it.
->fall

==lookaround==
You are underground, in a large open area. Above you is the hole that brought you here. {flashlightinven==0 and satchelinven==0: You can see your satchel and flashlight.} {flashlightinven==1 and satchelinven==0: You can see your satchel.} {flashlightinven==0 and satchelinven==1: You can see your flashlight.} You can see two passages ahead of you.
*[Pick up flashlight]->flashlight
*[Pick up satchel]->satchelpickup
+{flashlightinven == 0}[Take the right passage]->rightpassagedark
+{flashlightinven == 0}[Take the left passage]->leftpassagedark
+{flashlightinven == 1}[Take the right passage]->rightpassage
+{flashlightinven == 1}[Take the left passage]->leftpassage

==flashlight==
~flashlightinven = flashlightinven +1
You pick up the flashlight, flicking it on so you can see better.
+[Go Back]->lookaround

==satchelpickup==
~satchelinven = satchelinven + 1
~sweatshirt = sweatshirt+1
~granola = granola+3
You pick up your satchel. During the fall, some of its contents had disappeared. However, there are still three granola bars and an extra sweatshirt in your bag.
+[Go Back]->lookaround

==rightpassagedark==
You can't see anything. It's too dark to go any further.
+[Go Back]->lookaround

==leftpassagedark==
You can't see anything. It's too dark to go any further.
+[Go Back]->lookaround

==rightpassage==
You are in a small room. {not movestonepass: The way ahead is blocked by a large stone.} {movestonepass: There is a path ahead.} {not firstgranola: You spot a granola bar on the ground.}
*{not firstgranola}[Pick up granola bar]->firstgranola
+{splint==0 and not movestonepass}[Move stone]->movestonefail
+{splint==1 and not movestonepass}[Move stone]->movestonepass
+{movestonepass}[Take the path]->newpassage
+[Go Back]->lookaround

==firstgranola==
~granola=granola+1
You pick up the granola bar. It must have fallen out of your satchel on your way down. You now have {granola} granola bars.
+[Go Back]->rightpassage

==leftpassage==
You are in a narrow room. To the right is an old table. On the ground there is a pile of leaves. {not secondgranola: You spot a granola bar on your left.}
*{not secondgranola}[Pick up granola bar]->secondgranola
+[Use table]->table
+{sticks==0 and splint==0}[Search the leaves]->leafpile
+[Go Back]->lookaround

==secondgranola==
~granola=granola+1
You pick up the granola bar. It must have fallen out of your satchel on your way down. You now have {granola} granola bars.
+[Go Back]->leftpassage

==movestonefail==
You attempt to move the stone, but your leg is too weak.
+[Go Back] -> rightpassage

==movestonepass==
You move the stone, revealing another path.
+[Go Back]->rightpassage

==leafpile==
~sticks=sticks+2
You search the pile of leaves and find 2 sticks. You can use them and the sweatshirt in your satchel to craft a splint for your leg at the table.
+[Go Back]->leftpassage

==table==
{sticks==0 and sweatshirt==0: There is nothing to do at the table.} {sticks==2 and sweatshirt==0: You can craft a splint if you find your satchel.} {sticks==0 and sweatshirt==1: You can craft a splint if you find some sticks.} {sticks==2 and sweatshirt ==1: You can craft a splint.}
+{sticks==2 and sweatshirt==1}[Craft splint]->craftsplint
+[Go Back]->leftpassage

==craftsplint==
~sticks=sticks-2
~sweatshirt=sweatshirt-1
~splint=splint+1
You rip up the sweatshirt in your satchel, making three rags. Using the rags and the sticks, you craft a makeshift splint for your leg. You feel stronger.
+[Go Back]->table

==newpassage==
The path slopes upward. Eventually, the path splits in two. The path to the left continues to slope upwards, while the path to the right goes straight ahead.
+[Take the left path]->newleftpath
+[Take the right path]->newrightpath
+[Go Back]->rightpassage

==newleftpath==
After a lot of walking, you see daylight filtering into the cave. You found the exit.
+[Go Back]->newpassage
+[Exit the cave]->exit

==newrightpath==
You are in a large cavern with a sparkling body of water in the center.
+[Inspect the water]->magicpond
+[Go Back]->newpassage

==magicpond==
There is something otherworldly about this water. You feel a strange pull. You sense that it wants you to offer it something.
+{granola>0}[Offer it a granola bar]->granolapond
+[Go Back]->newrightpath

==granolapond==
~granola=granola-1
~treasure=treasure+1
You toss a granola bar in. You now have {granola} granola bars. After a moment, a {&gold bar|jewel|beautiful diamond necklace} floats to the top.
+[Go Back]->magicpond

==exit==
{treasure==0: You exit the cave and return home.}
{treasure==1: You exit the cave and return home. You sell your treasure and recieve a little money.}
{treasure==2: You exit the cave and return home. You sell your treasure and recieve a decent sum.}
{treasure==3: You exit the cave and return home. You sell your treasure and recieve a decent sum.}
{treasure==4: You exit the cave and return home. You sell your treasure and recieve a decent sum.}
{treasure==5: You exit the cave and return home. You sell your treasure and recieve a TON of money. You use some of it to take a much needed vacation!}
->END



















