### Note
If you’ve found this on Google, looking for decent FFmpeg tutorials written by actual experts, this one probably isn’t for you.\
I’m just writing this as an intermediate user to introduce the program to friends.

********************************************************************************************************************************

Before we can dive into editing video, we have to understand what video really _is_.\
It may sound kinda silly when put this plainly, but it’s important that we grasp these fundamentals first.
  
What we call a “video” is a series of still images, and an audio waveform, played at the same time.\
But what _is_ a still image?

  •  •  •  

Consider a pixel.

Every pixel on your monitor is made up of three smaller subpixels. One each of red, green, and blue.\
Depending on their combinations of brightnesses, they mix into the colour we see.\
But what numbers are these? If 0 is its minimum value, what’s its maximum?

The most common way of storing these is a scale from 1 to 2⁸, since computers really like powers of 2,\
and we therefore have a scale between 1 and 256.\
(Well, actually from 0 to 255, since computers count from zero.)

This means the pixel has a **bit depth** of 8.  

  •  •  •  

Well, how many pixels do we need to make an image?

Let’s imagine a grid of pixels that are 720px wide, and 576px tall.\
That means the video has a **resolution** of 720×576, which is the standard that DVDs use.\
We can also express this by only stating its vertical resolution (576p) and its **aspect ratio**,\
which is the ratio between its vertical resolution (in this case 720⁄576 = 5⁄4).

  •  •  •  

Now that we have imagined a single still image, let’s put it in motion.\
Think of [flip book animation](https://commons.wikimedia.org/wiki/File:Flip_Book_-_Messi_Example.webm). The faster you flip through the pages,\
the faster the animation seems to go.

Video works just the same, especially if we want it to stay in sync with audio.  
We express this **framerate** as a fraction of how many frames are to be flipped through in how many seconds.  
For instance, 25⁄1 means 25 frames in 1 second, or 25 FPS.  
The reason why we also specify the denominator is because there are also more complicated framerates\
that are not expressed in terms of 1 second, like 24000⁄1001, which is an\
irrational number when expressed in terms of frames per second: 23.~~976023~~ FPS.

  •  •  •  

Let’s do the same thing with audio.  
A standard CD saves a snapshot of audio data at a bit rate of 16 bits.  
It samples this at 44 100 times per second, which captures the entire range of hearing that humans have.

  •  •  •  

Let’s consider a 60 second clip like this.

Its video has a bit depth of 8, a resolution of 720×576, a framerate of 25 FPS,\
and its audio has a sample rate of 44 100 samples per second at 16 bits.

Using some math, we can calculate the amount of information necessary to store all that.  
* **Video:** 8 bits * 3 colours * 720 pixels * 576 pixels * 25⁄1 frames per second * 60 seconds = 14 929 920 000 bits  
* **Audio:** 16 bits * 44 100 samples per second * 60 seconds = 42 336 000 bits  
* **Total:** 14 929 920 000 + 42 336 000 = 14 972 256 000 bits = **1.743 gigabytes**

1.743 GiB for a 1 minute clip is about as wasteful as it gets, and very impractical since\
some people have internet connections that can barely handle 1⁄1000 of that.  
That bit rate is gonna need to be cut down.

  •  •  •  

Fortunately, some very clever people have developed ways to cut down the amount of storage space needed to store these.

We call this a codec. There are many different video codecs and many different audio codecs, with their own pros and cons.\
In order to play back a video file, where you both see a moving image and hear audio at the same time,\
we’re gonna have to package these two codecs together.  We call this package a container.

You’re probably familiar with a few containers, without knowing their names, since they’re the ones that determine\
the file extension of the file on your computer.  For instance, MPEG-4 (`.mp4`), QuickTime (`.mov`), or Audio Video Interleave (`.avi`)\
are all examples of different containers that you may have seen.

********************************************************************************************************************************

That’s all well and good, but does it really matter to the end user?\
They just want the video to work, after all.  Hence, in most cases,\
video editing software just takes care of this in the background automatically.  

But what if we _do_ want control over all these variables?\
Enter **FFmpeg**, the most versitile video editor there is.

********************************************************************************************************************************
