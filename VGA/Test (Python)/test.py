from PIL import Image

file = open("vga_testbench.txt", "r")

IMAGE_EXTENSION = "png"
IMAGE_WIDTH = 800
IMAGE_HEIGHT = 525
IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT
IMAGE_ARRAY = file.read().split(' ')

for pos in range(0, IMAGE_SIZE):
    IMAGE_ARRAY[pos] = int(IMAGE_ARRAY[2*pos], 2)

IMAGE_ARRAY = IMAGE_ARRAY[0:IMAGE_SIZE]

img3 = Image.new('L', (IMAGE_WIDTH, IMAGE_HEIGHT))
img3.putdata(IMAGE_ARRAY)
img3.save('vga' + str(IMAGE_WIDTH) + "x" +
          str(IMAGE_HEIGHT) + "." + IMAGE_EXTENSION)
