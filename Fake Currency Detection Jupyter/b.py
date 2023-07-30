
import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage.metrics import structural_similarity as ssim

#Resizing the Plots
plt.rcParams["figure.figsize"] = (12, 12)
%store -z  # Deleting all pre- stored variables
# The GUI file produces and then stores the variables path and option
# Reading the stored variables

%store -r selectedImage
%store -r path
%store -r option

print('Image selected: ', selectedImage)
print('Path: ', path)
print('Currency type: ', option)
if selectedImage == True:
    if option == 1:                        # For 500 currency note
        %run ./500_Testing.ipynb
    elif option == 2:                      # For 2000 currency note
        %run ./2000_Testing.ipynb
if selectedImage == True:
    # The above file produces and stores result_list variable
    # Reading the variable
    %store -r result_list

    # Showing the results
    # The result list variable is a list of lists and each list conatins details about each feature
    for x in result_list:
        if x[0] is not None:            
            plt.imshow(x[0])   # Showing images
            plt.show()

if selectedImage == True:
# Show output in GUI

    %run ./gui_2.ipynb

if selectedImage == True:
# Show output in GUI

    %run ./gui_2.ipynb
%store -z  # Deleting all pre- stored variables
