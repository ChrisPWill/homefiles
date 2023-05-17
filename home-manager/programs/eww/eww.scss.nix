{theme}: ''
  $bg: rgba(${theme.background},0.1);
  $fg: ${theme.foreground}
  $shadow: rgba(#000000,0.3);
  $border_col: rgba(#cccccc,0.18);
  $best_so_far: rgba(255,255,255,0.1);

  .bar {
  	background-color: transparent;
  }

  .main-container {
  	margin: 8px 12px 0px 12px;
  }

  .workspaces {
  	background-color: $bg;
  	border-radius: 10px;
  	color: $fg;
  	margin-bottom: 10px;
  	border: 1px solid $border_col;
  	padding: 6px 20px 4px 20px;
         	font-size: 22px;
  	box-shadow: 2px 2px 2px $shadow;
  	min-height: 25px;
  }
''
