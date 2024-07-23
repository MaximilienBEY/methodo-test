test=(
  "2021-01-01T15:30:00 2 true true" 1
  "2021-01-02T15:30:00 2 true true" 2
  # "2021-01-03T15:30:00" Skip one day
  # "2021-01-04T15:30:00" Skip one day
  "2021-01-05T15:30:00 2 true true" 3 # => 0 life left
  # "2021-01-06T16:30:00 2" Skip one day => no life left, reset score
  "2021-01-07T17:30:00 2 true true" 1
)
init_test "Skip days, lose lives, reset score" "${test[@]}"