# Liv’s guide to frame upscaling with Davinci Resolve

For this example, I’m going to upscale a 25 fps video into 50 fps.

## Step 1
Create a new project.  
Go to `File > Project Settings`.  
In `Timeline frame rate`, select 50 fps.  
Import the footage onto the timeline.  

## Step 2
Since this is a 25 fps video inside a 50 fps video, the video will update on every other frame.
Make sure the video updates on every even frame in the timeline.
If your footage has does not have cuts, move directly to Step 4. If it does, go to Step 3.

## Step 3
Use your arrow keys to find the exact frame a cut happens. Press B and click on the timeline to slice it. Press left-arrow once to navigate to the frame before the cut, and slice it again.
Repeat this step every time there is a cut in the video.

## Step 4
Select all the footage which is longer than 1 frame.
Go to the Inspector on the right side of the screen. Open `Retime and Scaling` and change `Retime Process` to Optical Flow and `Motion Estimation` to Speed Warp.

## Step 5
Render the footage.

## Step 6 (Optional)
Open the rendered footage in a new timeline. You can now edit this new footage as you like.