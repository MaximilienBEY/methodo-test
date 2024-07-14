#!/bin/bash

source init_colors.sh
source launch_server.sh
pid=$(cat /tmp/pidfile)

function request() {
  local data="$1"

  date=$(echo "$data" | cut -d ' ' -f 1)
  timestamp=$(date -d "$date" "+%s")
  level=$(echo "$data" | cut -d ' ' -f 2)
  seating=$(echo "$data" | cut -d ' ' -f 3)
  lying=$(echo "$data" | cut -d ' ' -f 4)

  response=$(
    curl \
      --silent \
      --request POST \
      --url http://localhost:3000/ \
      --header 'Content-Type: application/json' \
      --data '{
        "sessionId": "temp",
	      "date": '$timestamp',
        "level": '$level',
        "seating": '$seating',
        "lying": '$lying'
      }'
  )

  return $response
}

current_file=""
function init_test() {
  out_folder=$(echo "${current_file%.*}" | cut -d '/' -f 2)
  test_number=$(echo "${out_folder}" | cut -d '-' -f 1)
  mkdir -p "out/${out_folder}"

  local name="$1"
  local table=("${@:2}")
  num_elements="${#table[@]}"
  num_rows="$(( $num_elements / 2 ))"
  num_cols=2

  success=1

  # Reset the database
  curl --silent --request DELETE --url http://localhost:3000/
  printf "Running test #${test_number} for \"${name}\"..."

  for ((row=0; row<num_rows; row++)); do
    i_data=$(( $row*$num_cols + 0 ))   # index of column 0
    i_expect=$(( $row*$num_cols + 1 )) # index of column 1

    data="${table[$i_data]}"     # column 0
    expect="${table[$i_expect]}" # column 1

    request "$data"
    result=$?

    echo "[${row}] ${data} -> ${expect}" >> "out/${out_folder}/in.log"
    echo "[${row}] ${data} -> ${result}" >> "out/${out_folder}/out.log"

    if [ "$result" -ne "$expect" ]; then
      success=0
    fi
  done

  if [ "$success" -eq 1 ]; then
    printf "${GREEN} ok${NC}\n"
  else
    printf "${RED} ko${NC}\n"
  fi
}

rm -rf out

# if arg is a number, run only that test
if [ "$#" -eq 1 ] && [ "$1" -eq "$1" ] 2>/dev/null; then
  current_file=$(ls tests | grep "^$1-")
  if [ -z "$current_file" ]; then
    echo "Test $1 not found"
    exit 1
  fi
  source "tests/${current_file}"
else
  for file in tests/*; do
    current_file=$(basename "$file")
    source "$file"
  done
fi

kill $pid