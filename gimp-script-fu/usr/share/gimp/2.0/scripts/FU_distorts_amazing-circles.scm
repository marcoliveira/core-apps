; FU_distorts_amazing-circles.scm
; version 2.7 [gimphelp.org]
; last modified/tested by Paul Sherman
; 05/05/2012 on GIMP-2.8
;
; ------------------------------------------------------------------
; Original information ---------------------------------------------
;
; Amazing Circles is a script for The GIMP
;
; Turn an image into an Amazing Circle.
; The script is located in menu "<Image> / Filters / Distorts / Circle Maker"
; Last changed: 7 August 2007
; Copyright (C) 2007 Harry Phillips <script-fu@tux.com.au>
;
; Made to not error out by attempting to use on indexed image
; and changed menu location by Paul Sherman on 11/30/2007
; distributed by gimphelp.org
; --------------------------------------------------------------------
;  
; Changelog:
;  Version 1.4 (7th August 2007)
;    - Cleaned up the code
;    - Created a mini funtion "square-crop"
;    - Added the cropping multi option
;
;  Version 1.3 (5th August 2007)
;    - Added GPL3 licence 
;    - Menu location at the top of the script
;    - Removed the "script-fu-menu-register" section
;
;  Version 1.2
;    - Made the script compatible with GIMP 2.3
;
;  Version 1.1
;    - Added a check to see if the image is already square
; --------------------------------------------------------------------
; 
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 3 of the License, or
; (at your option) any later version.  
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program; if not, you can view the GNU General Public
; License version 3 at the web site http://www.gnu.org/licenses/gpl-3.0.html
; Alternatively you can write to the Free Software Foundation, Inc., 675 Mass
; Ave, Cambridge, MA 02139, USA.
;
; End original information ------------------------------------------
;--------------------------------------------------------------------
;

(define (square-crop image)
    
    (let* 
    (
        ;Read the image width and height
	(width (car (gimp-image-width image)))
	(height (car (gimp-image-height image)))

    )
	
	(if (= width height)
		()
		(begin

	;Check which is longer
	(if 	(> width height)
		(gimp-image-crop image height height (/ (- width height) 2) 0)
		(gimp-image-crop image width width 0 (/ (- height width) 2))
	
	))
)))


(define (FU-amazing-circles	theImage
					theLayer
					circlePercent
					cropType
	)

    ;Start an undo group so the process can be undone with one undo
    (gimp-image-undo-group-start theImage)

    ;Select none
    (gimp-selection-none theImage)

    ;Select none
    (gimp-selection-none theImage)

    (if (= cropType 1)
    	(square-crop theImage)
    	()
    )

    ;First polar co-ord with "To Polar = off"
    (plug-in-polar-coords 1 theImage theLayer circlePercent 0 1 0 0)

    ;Flip vertically
    (gimp-image-flip theImage 1)

    ;Second polar co-ord with "To Polar = on"
    (plug-in-polar-coords 1 theImage theLayer circlePercent 0 1 0 1)

    (if (= cropType 0)
    	(square-crop theImage)
    	()
    )

    ;Finish the undo group for the process
    (gimp-image-undo-group-end theImage)

    ;Ensure the updated image is displayed now
    (gimp-displays-flush)
)

(script-fu-register "FU-amazing-circles"
	"<Image>/Script-Fu/Distorts/Circle Maker"
	"Does the amazing circles on a square image"
	"Harry Phillips"
	"Harry Phillips"
	"Mar. 23 2007"
	"RGB* GRAY*"
	SF-IMAGE		"Image"     0
	SF-DRAWABLE		"Drawable"  0
	SF-ADJUSTMENT	_"Circle depth"      '(100 0 100 1 10 1 0)
	SF-OPTION		"Crop image?"		'("Crop after" "Crop before" "Don't crop")
)



