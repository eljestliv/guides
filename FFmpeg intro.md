### Note
If you’ve found this on Google, looking for decent FFmpeg tutorials written by actual experts, this one probably isn’t for you.\
I’m just writing this as an intermediate user to introduce the program to friends.

********************************************************************************************************************************

# What is video?

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
has a bunch of repeating decimals when expressed in terms of frames per second: 23.~~976023~~ FPS.

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

# What is FFmpeg?

That’s all well and good, but does it really matter to the end user?\
They just want the video to work, after all.  Hence, in most cases,\
video editing software just takes care of this in the background automatically.  

But what if we _do_ want control over all these variables?\
Enter **FFmpeg**, the most versitile video editor there is.

  •  •  •

How do I install this software? When you’re totally new\
to using the command line, as I was when I started using it,\
it can be really confusing and filled with tech jargon.\
Don’t worry, I got you.

I will be assuming you’re running Windows 10 or 11 for this guide.

  •  •  •

Before we even start with FFmpeg though, first I should recommend\
downloading [Notepad++](https://notepad-plus-plus.org/downloads/) and make a `.txt` file\
to save FFmpeg commands in.  Being able to copy and paste commands is a _massive_ quality of life improvement.\
I’ve been doing it this way since 2021 and now I basically have a complete record of every single\
command I’ve ever sent with this program in a long text file.  I promise it’ll come in handly.

  •  •  •

After that’s done, we’re gonna create a folder that will be our FFmpeg directory.\
This is something that should never move, so keep it in a good place.\
For me, that’s `E:\configs-programs\ffmpeg`.

Now go to [Gyan’s FFmpeg builds](https://www.gyan.dev/ffmpeg/builds/) and download the one labelled `ffmpeg-git-full.7z`.\
It’ll download the most recent version automatically, in my case that’s `ffmpeg-2026-01-29-git-c898ddb8fe-full_build.7z`.

Place that in your FFmpeg directory. Right click and select “extract here” or\
whatever similarly named option there is in the archive program you have.

  •  •  •

Navigate through its folder system to the `bin` folder located at `…\ffmpeg-2026-01-29-git-c898ddb8fe-full_build\bin`\
and copy the full path to that folder; in my case `E:\configs-programs\ffmpeg\ffmpeg-2026-01-29-git-c898ddb8fe-full_build\bin`.

Now, in the Windows search bar, type `variables` and you should find `Edit the system environment variables`.\
Click on it, then press `Environment Variables` in the bottom right.

Then in the *bottom* window (there are two atop one another; the bottom one, that’s labelled `System variables`),\
find the entry that says `Path` or `PATH`, and click `Edit`.  A new window pops up, click `New`,\
and then paste the link to the `bin` folder that you copied earlier.\
Click `OK` on all the windows.

Success!  You can now access FFmpeg from anywhere on your system.

  •  •  •

Access it how, you ask?\
With Powershell, which is a command line.

Let’s head back to the FFmpeg install folder, the one without the specific version number.\
In my case, that’s `E:\configs-programs\ffmpeg`.

Double click the address bar (where you copied the path from earlier),\
erase what’s there, and type `pwsh` and hit Enter.\
(If it doesn’t work, try typing `powershell` instead.

A new window will open, and this is how we access FFmpeg.

To verify that our installation went correctly, simply type `ffmpeg` and hit enter.\
The console will reply with the following if everything went correctly.
```pwsh
PS E:\configs-programs\ffmpeg> ffmpeg
ffmpeg version 2026-01-29-git-c898ddb8fe-full_build-www.gyan.dev Copyright (c) 2000-2026 the FFmpeg developers
  built with gcc 15.2.0 (Rev8, Built by MSYS2 project)
  configuration: --enable-gpl --enable-version3 --enable-static --disable-w32threads --disable-autodetect --enable-cairo --enable-fontconfig --enable-iconv --enable-gnutls --enable-lcms2 --enable-libxml2 --enable-gmp --enable-bzlib --enable-lzma --enable-libsnappy --enable-zlib --enable-librist --enable-libsrt --enable-libssh --enable-libzmq --enable-avisynth --enable-libbluray --enable-libcaca --enable-libdvdnav --enable-libdvdread --enable-sdl2 --enable-libaribb24 --enable-libaribcaption --enable-libdav1d --enable-libdavs2 --enable-libopenjpeg --enable-libquirc --enable-libuavs3d --enable-libxevd --enable-libzvbi --enable-liboapv --enable-libqrencode --enable-librav1e --enable-libsvtav1 --enable-libvvenc --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxavs2 --enable-libxeve --enable-libxvid --enable-libaom --enable-libjxl --enable-libsvtjpegxs --enable-libvpx --enable-mediafoundation --enable-libass --enable-frei0r --enable-libfreetype --enable-libfribidi --enable-libharfbuzz --enable-liblensfun --enable-libvidstab --enable-libvmaf --enable-libzimg --enable-amf --enable-cuda-llvm --enable-cuvid --enable-dxva2 --enable-d3d11va --enable-d3d12va --enable-ffnvcodec --enable-libvpl --enable-nvdec --enable-nvenc --enable-vaapi --enable-libshaderc --enable-vulkan --enable-libplacebo --enable-opencl --enable-libcdio --enable-openal --enable-libgme --enable-libmodplug --enable-libopenmpt --enable-libopencore-amrwb --enable-libmp3lame --enable-libshine --enable-libtheora --enable-libtwolame --enable-libvo-amrwbenc --enable-libcodec2 --enable-libilbc --enable-libgsm --enable-liblc3 --enable-libopencore-amrnb --enable-libopus --enable-libspeex --enable-libvorbis --enable-ladspa --enable-libbs2b --enable-libflite --enable-libmysofa --enable-librubberband --enable-libsoxr --enable-chromaprint --enable-whisper
  libavutil      60. 24.100 / 60. 24.100
  libavcodec     62. 23.103 / 62. 23.103
  libavformat    62.  8.102 / 62.  8.102
  libavdevice    62.  2.100 / 62.  2.100
  libavfilter    11. 11.101 / 11. 11.101
  libswscale      9.  3.100 /  9.  3.100
  libswresample   6.  2.100 /  6.  2.100
Universal media converter
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Use -h to get full help or, even better, run 'man ffmpeg'
PS E:\configs-programs\ffmpeg>
```

********************************************************************************************************************************

# How do I actually use FFmpeg?

Before we start looking at converting files, let’s use what we’ve learned to look at an already existing video file.

The very basics of an FFmpeg command looks like this:
```pwsh
ffmpeg -i $input
```
Note that when I say `$input`, this is where you should substitute your own input.\
The `$` is not supposed to be there in the final command.\
I recommend putting it in quotes, otherwise spaces could be misinterpreted by the program.\
So if my input is `video.mp4`, and the example command asks for `$input`, you actually write `"video.mp4"`.

And another thing, Powershell has a way of splitting commands across multiple lines\
which makes it a whole lot more readable, if you end every line except the last with a backtick.

```pwsh

# CORRECT
	ffmpeg -i $input $output

# CORRECT
	ffmpeg `
		-i $input `
		$output

# INCORRECT
	ffmpeg
		-i $input
		$output
```

I would also advise running the program with `-hide_banner` enabled, since it shows a bunch of\
debug information by default which just clutters up the screen.  Typing that out every time\
gets annoying, and that’s why having that text file to copy and paste from is so useful.

It might not look that bad if you have line breaking disabled,\
but if you have it enabled, compare this…

```pwsh
PS E:\configs-programs\ffmpeg> ffmpeg
ffmpeg version 2026-01-29-git-c898ddb8fe-full_build-www.gyan.dev Copyright (c) 2000-2026 the FFmpeg developers
  built with gcc 15.2.0 (Rev8, Built by MSYS2 project)
  configuration: --enable-gpl --enable-version3 --enable-static --disable-w32threads --disable-autodetect --enable-cairo --enable-fontconfig --enable-iconv --enable-gnutls --enable-lcms2 --enable-libxml2 --enable-gmp --enable-bzlib --enable-lzma --enable-libsnappy --enable-zlib --enable-librist --enable-libsrt --enable-libssh --enable-libzmq --enable-avisynth --enable-libbluray --enable-libcaca --enable-libdvdnav --enable-libdvdread --enable-sdl2 --enable-libaribb24 --enable-libaribcaption --enable-libdav1d --enable-libdavs2 --enable-libopenjpeg --enable-libquirc --enable-libuavs3d --enable-libxevd --enable-libzvbi --enable-liboapv --enable-libqrencode --enable-librav1e --enable-libsvtav1 --enable-libvvenc --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxavs2 --enable-libxeve --enable-libxvid --enable-libaom --enable-libjxl --enable-libsvtjpegxs --enable-libvpx --enable-mediafoundation --enable-libass --enable-frei0r --enable-libfreetype --enable-libfribidi --enable-libharfbuzz --enable-liblensfun --enable-libvidstab --enable-libvmaf --enable-libzimg --enable-amf --enable-cuda-llvm --enable-cuvid --enable-dxva2 --enable-d3d11va --enable-d3d12va --enable-ffnvcodec --enable-libvpl --enable-nvdec --enable-nvenc --enable-vaapi --enable-libshaderc --enable-vulkan --enable-libplacebo --enable-opencl --enable-libcdio --enable-openal --enable-libgme --enable-libmodplug --enable-libopenmpt --enable-libopencore-amrwb --enable-libmp3lame --enable-libshine --enable-libtheora --enable-libtwolame --enable-libvo-amrwbenc --enable-libcodec2 --enable-libilbc --enable-libgsm --enable-liblc3 --enable-libopencore-amrnb --enable-libopus --enable-libspeex --enable-libvorbis --enable-ladspa --enable-libbs2b --enable-libflite --enable-libmysofa --enable-librubberband --enable-libsoxr --enable-chromaprint --enable-whisper
  libavutil      60. 24.100 / 60. 24.100
  libavcodec     62. 23.103 / 62. 23.103
  libavformat    62.  8.102 / 62.  8.102
  libavdevice    62.  2.100 / 62.  2.100
  libavfilter    11. 11.101 / 11. 11.101
  libswscale      9.  3.100 /  9.  3.100
  libswresample   6.  2.100 /  6.  2.100
Universal media converter
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Use -h to get full help or, even better, run 'man ffmpeg'
PS E:\configs-programs\ffmpeg>
```

…to this! So much cleaner and easy to understand.

```pwsh
PS E:\configs-programs> ffmpeg -hide_banner
Universal media converter
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Use -h to get full help or, even better, run 'man ffmpeg'
PS E:\configs-programs>

```

  •  •  •

Anyway, let’s run that command on our input file.
This is a simplified version of what you’ll see in the output.

```pwsh
PS Q:\> ffmpeg -hide_banner -i "input.mov"
Input #0, from 'input.mov':
  Duration: 00:02:56.49
  Stream #0:0 Video: mpeg2video, yuv420p(tv, smpte170m/bt709/bt709, progressive), 704x576 [PAR 12:11 DAR 4:3], 9001 kb/s, 25 fps
PS Q:\>
```

The first line tells us our 1st input (which from now on in this guide is 0th, since computers count from 0),\
which is of course the only file we specified, then its duration and starting timestamp.

Then it lists all the streams in the video. You **do not** need to know the specifics here,\
I’m just meaning to explain what all these random numbers and letters mean.

The 0th input in the 0th stream is `0:0`, and that’s the video stream.\
Its codec is MPEG-2, its colour space is YUV with a chroma subsampling of 4:2:0,\
it’s colour range is TV-limited, in the SMPTE-170 colour space,\
with Rec.709 colour primaries, and transfer characteristics.\
It’s progressive, meaning it shows the entire image at once.\
Its resolution is 704×576, and the pixel making up that image are skewed\
horizontally by a factor of 12:11, resulting in a final aspect ratio of 4:3.\
Its bitrate is 9001 kb/s, and its framerate is 25 FPS.

That was a lot to take in, I know.\
You don’t need to learn all that,\
I’m just saying it so it’s there if you _do_ want to.

  •  •  •

We’ve now opened an input file to see what it’s made out of,\
but let’s try converting a file from one format to another.

Let’s say from JPG to PNG, the two most well-supported image formats,\
and an easy example since it doesn’t require more than an input and an output.

```pwsh
ffmpeg -hide_banner `
	-i "input.jpg" `
	"output.png"
```

This will produce:

```pwsh
PS Q:\assets\misc> ffmpeg -hide_banner `
>>     -i "input.jpg" `
>>     "output.png"
Input #0, image2, from 'input.jpg':
  Duration: 00:00:00.04, start: 0.000000, bitrate: 416305 kb/s
  Stream #0:0: Video: mjpeg (Baseline), yuvj444p(pc, bt470bg/unknown/unknown), 1400x1400 [SAR 600:600 DAR 1:1], 25 fps, 25 tbr, 25 tbn
Stream mapping:
  Stream #0:0 -> #0:0 (mjpeg (native) -> png (native))
Press [q] to stop, [?] for help
[swscaler @ 000001fd27865d80] deprecated pixel format used, make sure you did set range correctly
Output #0, image2, to 'output.png':
  Metadata:
    encoder         : Lavf62.8.102
  Stream #0:0: Video: png, rgb24(pc, gbr/unknown/unknown, progressive), 1400x1400 [SAR 1:1 DAR 1:1], q=2-31, 200 kb/s, 25 fps, 25 tbn
    Metadata:
      encoder         : Lavc62.23.103 png
    Side data:
      EXIF metadata: (78 bytes)
[image2 @ 000001fd27829f80] The specified filename 'output.png' does not contain an image sequence pattern or a pattern is invalid.
[image2 @ 000001fd27829f80] Use a pattern such as %03d for an image sequence or use the -update option (with -frames:v 1 if needed) to write a single image.
[out#0/image2 @ 000001fd27829e80] video:3338KiB audio:0KiB subtitle:0KiB other streams:0KiB global headers:0KiB muxing overhead: unknown
frame=    1 fps=0.0 q=-0.0 Lsize=N/A time=00:00:00.04 bitrate=N/A speed=0.284x elapsed=0:00:00.14
PS Q:\assets\misc>
```

Now, we have the file `output.png` in the directory we ran the command from, in my case `Q:\assets\misc`.

  •  •  •

Let’s now scale it down to a resolution of 600×600 before converting.\
For this, we’ll use `-vf`, meaning video filter.

```pwsh
ffmpeg -hide_banner `
	-i "input.jpg" `
	-vf "scale=600:600" `
	"output.png"
```

Note that it’ll prompt you if you want to overwrite the previous file,\
in this case we do, so we type `y` (or simply append `-y` to the original command).

  •  •  •

Actually no, let’s crop that down first,\
to 700×700, with an offset of 24×16 from the top left corner,\
_then_ scale it down to 600×600.

We can chain multiple filters together with commas.

```pwsh
ffmpeg -hide_banner `
	-i "input.jpg" `
	-vf "crop=700:700:24:16,scale=600:600" `
	"output.png" -y
```

********************************************************************************************************************************

# WORK IN PROGRESS

********************************************************************************************************************************
