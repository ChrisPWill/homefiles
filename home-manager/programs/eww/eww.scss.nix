{theme}: ''
  $bg: rgba(${theme.background},0.1);
  $fg: ${theme.foreground};
  $shadow: rgba(#000000,0.3);
  $border_col: rgba(#cccccc,0.18);
  $best_so_far: rgba(255,255,255,0.1);

  .bar1 {
  	background-color: transparent;
  }
  .bar2 {
  	background-color: transparent;
  }

  .h-bar {
  	margin: 4px 12px 0px 12px;
  }

  .v-bar {
  	margin: 8px 2px 0px 2px;
  }

  .workspaces {
  	background-color: $bg;
  	border-radius: 10px;
  	color: $fg;
  	border: 1px solid $border_col;
    font-size: 24px;
  	box-shadow: 2px 2px 2px $shadow;
  }

  .hworkspaces {
  	margin-top: 0px;
  	margin-bottom: 2px;
  	padding: 2px 20px 2px 20px;
  	min-height: 15px;
  }

  .vworkspaces {
  	padding: 6px 10px 4px 10px;
  }
''
