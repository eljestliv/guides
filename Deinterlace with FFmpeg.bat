Setlocal EnableDelayedExpansion
set INPUT=E:\assets\eurovision\restoration\1997\MakeMKV\Disc 1
set OUTPUT=E:\assets\eurovision\restoration\1997\Deinterlaced

:: look up aspect ratio:

FOR /F "tokens=*" %%g IN ('ffprobe -v error -select_streams v:0 -show_entries stream^=display_aspect_ratio -of default^=noprint_wrappers^=1:nokey^=1 -i "%INPUT%\B1_t00.mkv"') do (SET ASPECTRATIO=%%g)

SET "ASPECTRATIODIVIDE=%ASPECTRATIO::=/%"

:: deinterlace video:

for %%a in ("%INPUT%\*.*") DO ffmpeg -i "%%a" -filter_complex "[0:v]yadif=mode=1[deinterlaced];[deinterlaced]scale=ih*(%ASPECTRATIODIVIDE%):ih[aspectratiofix]" -map "[aspectratiofix]" -map 0:a -sws_flags lanczos -c:v libx265 -crf 21 -c:a copy -map_chapters -1 "%output%\%%~na.mov"

pause

Endlocal