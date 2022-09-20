function dc { run docker @args }

function dck { dc kill $(docker ps -q) }

function dcrm { dc rm $(docker ps -a -q) }

function dcrmi {  dc image rm $(dc images -q) }

function dcnp { dc network prune }
