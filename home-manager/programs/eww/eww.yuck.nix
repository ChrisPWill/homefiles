{}: ''
  (defvar home_dir "/home/$USER/.config/eww/scripts")

  (deflisten workspaces :initial "(box (label :text \"        \" ))"
  	`/home/$USER/.config/eww/scripts/workspaces.py`)

  (defwindow bar
  	:monitor 0
  	:windowtype "dock"
  	:geometry (geometry
  			:width "100%"
  			:height "4%"
  			:anchor "top center"
  			)
  	:exclusive true

  	(box :class "main-container"
  	  (box :class "workspaces" :halign "start"
  	    (literal :content "''\${workspaces}")
  	  )
    )
  )
''
