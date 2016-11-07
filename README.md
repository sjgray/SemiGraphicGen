ColourPET Semi-graphic Generator (C)2016 Steve J. Gray
================================

This program builds semi-graphics fonts for use with my ColourPET/Dual board.

The ColourPET/Dual gives one 40x25 by 16-colour screen, or two independent 40x25 monochrome screens.
The PET has several standard semi-graphic character by dividing the 8x8 pixel character into
four 2x2 pixel blocks (ie: 4-bit). All combinations are defined (16 characters), which means you can
generate a 80x50 resolution "bitmap" screen using only characters.

The ColourPET/Dual board lets you overlay the two 40x25 text screen, so you could use one screen for
text, and the other screen for graphics. Since the second screen does not have a hardware reverse
mode, it allows for 256 character fonts. By diving a character into 8 blocks (8-bit) in a 2x4 or 4x2
configuration we can generate either a 80x100 or 160x50 bitmap screen. However, using two custom
character sets we can actually double the resolution to 160x100. This is done by generating a 4x2
block set using only the top 4 pixels on one screen, and a 4x2 block set using only the bottom 4 pixels
on the second screen. When overlayed they effectively become a 4x4 block with 2x2 pixels.
The only problem we have is the standard pet screen fonts contain only 128 character plus reverse,
so we need to do some calculations in order to dispay the correct combination of pixels.

The program is written in VisualBASIC6. The screen has a box to enter a filename, a drop-down list
to select which type of font to generate, and an option to create fonts with either 128 or 256 character.
Click the START button to generate the font.

Steve
