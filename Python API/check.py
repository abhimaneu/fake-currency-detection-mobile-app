import cv2

# Load the resized image
image = cv2.imread('Python API/500_s2.jpg')

# Load the original image to get its dimensions
original_image = cv2.imread('Python API/500_s2.jpg')
original_height, original_width = original_image.shape[:2]

# Display the image and select the region of interest
roi = cv2.selectROI(image)

# Extract the coordinates of the selected region
x, y, w, h = roi

# Adjust the coordinates based on the original image dimensions
x = int(x * (original_width / image.shape[1]))
y = int(y * (original_height / image.shape[0]))
w = int(w * (original_width / image.shape[1]))
h = int(h * (original_height / image.shape[0]))

# Print the coordinates
print("Coordinates (x, y, width, height):", x, y, w, h)

# Display the selected region
selected_region = original_image[y:y+h, x:x+w]
cv2.imshow('Selected Region', selected_region)
cv2.waitKey(0)
cv2.destroyAllWindows()