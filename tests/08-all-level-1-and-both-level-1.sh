test=(
  "2021-01-01T15:30:00 1 true true" 0
  "2021-01-01T15:31:00 1 true false" 0
  "2021-01-01T15:32:00 1 true true" 1
)
init_test "All level 1 and both level 1" "${test[@]}"