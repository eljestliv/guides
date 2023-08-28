Setlocal EnableDelayedExpansion
set INPUT=E:\assets\eurovision\restoration\1997\MakeMKV
set OUTPUT=E:\assets\eurovision\restoration\1997\Deinterlaced

:: encode video:

for %%a in ("%INPUT%\*.*") DO ffmpeg -i "%%a" -filter_complex "[0:v]yadif=mode=1[deinterlaced]" -map "[deinterlaced]" -map 0:a -ac 2 -sws_flags lanczos -c:v libx265 -crf 21 -c:a pcm_s24le -map_chapters -1 "%output%\%%~na.mov"



