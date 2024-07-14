test=(
  "2021-01-01T15:30:00 2 true true" 1
  "2021-01-02T15:30:00 2 true true" 2 # 2 lives

  # Test lives
  "2021-01-03T15:30:00 2 false false" 2 # -1 life => 1 life left
  "2021-01-04T15:30:00 2 false false" 2 # -1 life => 0 life left
  "2021-01-05T15:30:00 2 false false" 0 # No life left, reset score
  "2021-01-06T15:30:00 2 false false" 0 # Still no life left
)
init_test "Has score, has practice, has two lives" "${test[@]}"