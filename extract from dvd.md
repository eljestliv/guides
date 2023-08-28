# Liv’s guide to extracting from DVD sources

To follow this tutorial, you will need:
* [DVD Decrypter](http://www.dvddecrypter.org.uk/)
* [MakeMKV](https://www.makemkv.com/)

You will also need this if you select Method 1 of deinterlacing:
* [FFmpeg](https://ffmpeg.org/)
* [My .bat-file for deinterlacing](https://github.com/eljestliv/guides/blob/main/Deinterlace%20with%20FFmpeg.bat)

You will also need this if you select Method 2 of deinterlacing:
* [Hybrid](https://www.selur.de/)

## Decrypting the DVD
* Insert the DVD into your computer.
* Open DVD Decrypter.
* Select the DVD drive.
* Select an output folder. In my case, that’s `E:\assets\eurovision\restoration\1997\DVD Decrypt`.

* Start the decryption process and wait for it to finish.

## Making an MKV file
* Open MakeMKV
* Go to `File > Open files` and find the file `VIDEO_TS.IFO` in the output folder you selected in DVD Decrypter.
* Select an output folder. In my case, that’s `E:\assets\eurovision\restoration\1997\MakeMKV`.
* Start the conversion process and wait for it to finish.

## Deinterlacing

### Method 1 (YADIF with FFmpeg)
<!---
* Create a new folder for your deinterlaced videos. In my case, that’s `E:\assets\eurovision\restoration\1997\Deinterlaced`.
* Open the file named `Step 1.bat` with a text editor. Don’t run it.
* On the second line of text, replace the example path to the path where the MakeMKV output was placed.
* Save the file.
* Run the file.
* Take note of the
--->
* Create a new folder for your deinterlaced videos. In my case, that’s `E:\assets\eurovision\restoration\1997\Deinterlaced`.
* Open the file named `Step 2.bat` with a text editor. Don’t run it.
* In the second line of text, replace the example path to the path where the MakeMKV output was placed.
* In the third line of text, replace the example path to the path you just created. In my case, that’s `E:\assets\eurovision\restoration\1997\Deinterlaced`.
* Save the file.
* Run the file. Wait for the conversion to finish.
<!---
`ffmpeg -i "E:\assets\eurovision\restoration\1997\MakeMKV\B1_t00.mkv" -filter_complex "[0:v]yadif=mode=1[deinterlaced]" -map "[deinterlaced]" -map 0:a -ac 2 -sws_flags lanczos -c:v libx265 -crf 21 -c:a pcm_s24le -map_chapters -1 "E:\assets\eurovision\restoration\1997\Deinterlaced.mov"`
--->

### Method 2 (QTGMC with Hybrid)

Coming soon

## Finishing touches

Coming soon