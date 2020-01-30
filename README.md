# Computer-Vision-Screws
Predict screws lengths using computer vision techniques.
Simple Matlab script using Image Processing Toolbox to predict the length of different screws.

![Original Image](https://github.com/rosasalberto/Computer-Vision-Screws/blob/master/images/original7.png)

First, we adjust the original image and calculate the binary threshold using Otsu's method.
Then we eliminate the black noise and apply opening ( erosion + dilatation ).

![Binary image](https://github.com/rosasalberto/Computer-Vision-Screws/blob/master/images/bw7.png)

Finally, we detect the unique pattern in the image and make some calculations to match the length of the screws with the closest screw in the library.

![Final result](https://github.com/rosasalberto/Computer-Vision-Screws/blob/master/images/result7.png)
