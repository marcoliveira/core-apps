; FU_remove-paths.scm
; version 2.7 [gimphelp.org]
; last modified/tested by Paul Sherman
; 05/05/2012 on GIMP-2.8
;
; Save time, skip the paths dialog to remove paths
; 
; ========================================================================
;
; LICENSE
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.
;
; ========================================================================

(define (FU-remove-paths image drawable)
	(gimp-image-undo-group-start image)
	
	(let* (
    	(all-paths (gimp-image-get-vectors image))
    	(i (car all-paths))
    	(path 0)
		(GTK_STOCK_ABOUT "gtk_about")
    	)
	  (set! all-paths (cadr all-paths))
	  (while (> i 0)
    	(set! i (- i 1))
    	(set! path (vector-ref all-paths i))
    	(gimp-image-remove-vectors image path)
      ))
	  
	;Finish the undo group for the process
    (gimp-image-undo-group-end image) 
	;Update the display
	(gimp-displays-flush)
)

(script-fu-register "FU-remove-paths"
	"<Image>/Script-Fu/Remove Paths"
	"Removes all image paths"
	"Paul Sherman"
	"Paul Sherman"
	"2010/10/14"
	"*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
)

