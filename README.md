# Computer-Architecture-Lab---IT3280--Project
# Draw a shape on the Bitmap screen
Requirements:
- Use MIPS to draw a moving ball on the screen simulating Mars Bitmap).
- If the ball hits the edge of the screen, it will move in the opposite direction.
- The direction of movement depends on the key the user presses, including (move up (W), move down (S), Left (A), Right (D) in the Keyboard and Display MMIO Simulator) .
- Initial ball position is in the middle of the screen.
- The speed at which the ball moves is constant.
- When the user holds a certain key (W, S, A, D), the ball will accelerate in that direction with optional acceleration.

# Postscript CNC Marsbot
Requirements:
- Use Marsbot Tool in MARS MIPS software to draw the words DCE, SoICT and a shape of your choice (minimum 10 cut lines)
- Create postscript according to the structure <motion angle>, <time>, <cut/uncut> stored permanently inside the source code to draw the above words
- The source code contains 3 postscripts and the user uses 3 keys 0, 4, 8 on the Key Matrix keyboard of Digital Lab Sim to select the postscript to be processed:
  - Key 0: the program will execute postscript 0 (drawing from DCE)
  - Key 4: the program will execute postscript 4 (drawn from SoICT)
  - Key 8: the program will execute postscript 8 (draw a heart shape)
