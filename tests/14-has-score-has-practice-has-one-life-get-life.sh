test=(
  "2021-01-01T15:30:00 2 true true" 1
  "2021-01-02T15:30:00 2 false false" 1 # 1 life
  "2021-01-03T15:30:00 2 true true" 2 # 1 life
  "2021-01-04T15:30:00 2 true true" 3 # 1 life
  "2021-01-05T15:30:00 2 true true" 4 # 1 life
  "2021-01-06T15:30:00 2 true true" 5 # 1 life
  "2021-01-07T15:30:00 2 true true" 6 # 1 life # 5 days in a row + 1 life

  # Test lives
  "2021-01-08T15:30:00 2 false false" 6 # -1 life => 1 life left
  "2021-01-09T15:30:00 2 false false" 6 # -1 life => 0 life left
  "2021-01-10T15:30:00 2 false false" 0 # No life left, reset score
)
init_test "Has score, has practice, has one life, get life" "${test[@]}"