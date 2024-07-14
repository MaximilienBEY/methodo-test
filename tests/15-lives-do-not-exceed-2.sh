test=(
  "2021-01-01T15:30:00 2 true true" 1
  "2021-01-02T15:30:00 2 true true" 2
  "2021-01-03T15:30:00 2 true true" 3
  "2021-01-04T15:30:00 2 true true" 4
  "2021-01-05T15:30:00 2 true true" 5 # 5 days in a row + should not obtain a life because max: 2

  # Test lives
  "2021-01-06T15:30:00 2 false false" 5 # -1 life => 1 life left
  "2021-01-07T15:30:00 2 false false" 5 # -1 life => 0 life left
  "2021-01-08T15:30:00 2 false false" 0 # No life left, reset score
)
init_test "Lives do not exceed 2" "${test[@]}"