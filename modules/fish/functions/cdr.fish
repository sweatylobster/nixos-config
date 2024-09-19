function cdr -d "cd into root folder of current repo"
  cd (git rev-parse --show-toplevel)
end
