{}: ''
  (deflisten show_workspaces_1
    `python3 ./scripts/workspaces.py listen 0 h 5`
  )

  (deflisten show_workspaces_2
    `python3 ./scripts/workspaces.py listen 1 v 5`
  )

  (defwindow bar1
  	:monitor 0
  	:windowtype "dock"
  	:geometry (geometry
  			:width "100%"
  			:height "2%"
  			:anchor "top center"
  			)
  	:exclusive true
    :stacking "fg"

  	(box :class "h-bar"
      (box :class "workspaces hworkspaces" :halign "start"
        (literal :content show_workspaces_1)
      )
    )
  )

  (defwindow bar2
  	:monitor 1
  	:windowtype "dock"
  	:geometry (geometry
  			:width "2%"
  			:height "100%"
  			:anchor "center left"
  			)
  	:exclusive true
    :stacking "fg"

  	(box :class "v-bar"
      (box :class "workspaces vworkspaces" :valign "start"
        (literal :content show_workspaces_2)
      )
    )
  )
''
